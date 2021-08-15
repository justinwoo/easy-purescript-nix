{ pkgs ? import <nixpkgs> { inherit system; }
, system ? builtins.currentSystem
  # node: >=14
, nodejs ? pkgs.nodejs
  # purs: ~0.14.3
, purs ? (import ../default.nix { inherit pkgs; }).purs-0_14_3
}:

let
  # one should be able to regenarate using process substitution
  # ```fish
  # spago2nix generate 4 -- \
  #   --config (echo "https://raw.githubusercontent.com/natefaubion/purescript-tidy/v${version}/bin/spago.dhall" | psub)
  # ```
  spagoPkgs = import ./spago-packages.nix { inherit pkgs; };
in
pkgs.stdenv.mkDerivation rec {
  pname = "purs-tidy";
  version = "0.4.1";

  src = pkgs.fetchgit {
    url = "https://github.com/natefaubion/purescript-tidy.git";
    rev = "v${version}";
    sha256 = "sha256-WvJyZwRsGy28kYHrTTSZQiZJEpONFiLem8n4rUETqYQ=";
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
    ls -a
    build-spago-style "./src/**/*.purs" "./bin/**/*.purs"
  '';

  installPhase = ''
    mkdir -p $out/{bin,output}
    cp -r output/ $out
    cp $src/bin/index.js $out/bin/purs-tidy
    chmod u+x $out/bin/purs-tidy
  '';
}
