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
    version = "0.6.3.0";

    src =
      if pkgs.stdenv.isDarwin
        then pkgs.fetchurl
              { url = "https://github.com/spacchetti/spago/releases/download/0.6.3.0/osx.tar.gz";
                sha256 = "06l1wqa93v8h77s7rvqcr7qdrbc1dccs63fkiv8nzxf2dirq7in4";
              }
        else pkgs.fetchurl
              { url = "https://github.com/spacchetti/spago/releases/download/0.6.3.0/linux.tar.gz";
                sha256 = "0v0cdpsiidlaq04fhmc9bympj036gx4jp1702fff9zs84gkalwfp";
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
