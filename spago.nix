{ pkgs ? import <nixpkgs> {} }:
let

  patchelf = libPath :
    if pkgs.stdenv.isDarwin
      then ""
      else
        ''
          chmod u+w $SPAGO
          patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $SPAGO
          chmod u-w $SPAGO
        '';
in

  pkgs.stdenv.mkDerivation rec {
    name = "spago";
    version = "0.6.2.1";

    src =
      if pkgs.stdenv.isDarwin
        then pkgs.fetchurl
              { url = "https://github.com/spacchetti/spago/releases/download/0.6.2.1/osx.tar.gz";
                sha256 =  "1y7llfh6yn4i0jhz9fzpiiyr2kzbs1iqkdbh4nxj4m43x949mkf0";
              }
        else pkgs.fetchurl
              { url = "https://github.com/spacchetti/spago/releases/download/0.6.2.1/linux.tar.gz";
                sha256 =  "0ljmfjlbppyab009a8g3rzr044mh38qasw2wcngd7s788q9vcjgl";
              };

    buildInputs = [
      pkgs.gmp
      pkgs.zlib
      pkgs.ncurses5
    ];
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
