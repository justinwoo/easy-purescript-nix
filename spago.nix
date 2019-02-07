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
    version = "0.6.4.0";

    src =
      if pkgs.stdenv.isDarwin
        then pkgs.fetchurl
              { url = "https://github.com/spacchetti/spago/releases/download/0.6.4.0/osx.tar.gz";
                sha256 = "1wyzrmyyyqai00aaw9n21b2cy2c86x8hr39w6a93zkd81xsp91j7";
              }
        else pkgs.fetchurl
              { url = "https://github.com/spacchetti/spago/releases/download/0.6.4.0/linux.tar.gz";
                sha256 = "0f98w56b0a0gjq593ml00y95fbr90ifn15fd244x5mixa2sfq0ns";
              };

    buildInputs = [
      pkgs.gmp
      pkgs.zlib
      pkgs.ncurses5
      pkgs.stdenv.cc.cc.lib
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
