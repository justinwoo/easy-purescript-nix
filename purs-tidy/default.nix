{ pkgs ? import <nixpkgs> { inherit system; }
, system ? builtins.currentSystem
  # node: >=14
, nodejs ? pkgs.nodejs
  # purs: ~0.14.3
, purs ? (import ../default.nix { inherit pkgs; }).purs-0_14_3
}:

let
  # one should be able to regenarate using process substitution, but spago 
  # issue #472
  # ```fish
  # spago2nix generate 4 -- \
  #   --config (echo "https://raw.githubusercontent.com/natefaubion/purescript-tidy/v${version}/bin/spago.dhall" | psub)
  # ```
  # but you can create a temp file with the echo’d URL for spago2nix and spago 
  # to call
  spagoPkgs = import ./spago-packages.nix { inherit pkgs; };
in
pkgs.stdenv.mkDerivation rec {
  pname = "purs-tidy";
  version = "0.4.2";

  src = pkgs.fetchFromGitHub {
    owner = "natefaubion";
    repo = "purescript-tidy";
    rev = "v${version}";
    sha256 = "sha256-GmsCiB+RIqqh2BFY2YXvmoOiCzrGYdJ2RmRlfHv8zD8=";
  };

  buildInputs = [ nodejs ];
  nativeBuildInputs = [
    spagoPkgs.installSpagoStyle
    spagoPkgs.buildSpagoStyle
    spagoPkgs.buildFromNixStore
    purs
  ];

  # this allows us to drop the package.json file all together
  patchPhase = ''
    substituteInPlace bin/Bin/Version.js \
      --replace 'require("../../package.json").version' '"${version}"';
  '';

  unpackPhase = ''
    cp $src/{packages,spago}.dhall .
    cp -r $src/bin $src/src .
    install-spago-style
  '';

  buildPhase = ''
    build-spago-style "./src/**/*.purs" "./bin/**/*.purs"
  '';

  installPhase = ''
    mkdir -p $out/{bin,output}
    cp -r output/ $out
    cp $src/bin/index.js $out/bin/purs-tidy
    chmod u+x $out/bin/purs-tidy
  '';
}
