{ pkgs ? import <nixpkgs> {} }:

let
  patchelf = libPath: if pkgs.stdenv.isDarwin
    then ""
    else ''
          chmod u+w $SPAGO
          patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $SPAGO
          chmod u-w $SPAGO
        '';

in pkgs.stdenv.mkDerivation rec {
  name = "spago";

  version = "0.8.0.0";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.8.0.0/osx.tar.gz";
      sha256 = "1dnkjw5h9fyp43gj70z07cwah2hz5cg0krxmjri7h87zp7mc9b17";
    }
    else pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.8.0.0/linux.tar.gz";
      sha256 = "14vgjgkg67q4kjgkbn61x9d3qv8wi5ii42nfg84qdmvg4km91pcn";
    };

  buildInputs = [ pkgs.gmp pkgs.zlib pkgs.ncurses5 pkgs.stdenv.cc.cc.lib ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
      mkdir -p $out/bin
      tar xf $src -C $out/bin

      SPAGO=$out/bin/spago
      ${patchelf libPath}


      mkdir -p $out/etc/bash_completion.d/
      $SPAGO --bash-completion-script $SPAGO > $out/etc/bash_completion.d/spago-completion.bash
    '';

  dontInstall = true;
}
