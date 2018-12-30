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

  platform =
    if pkgs.stdenv.isDarwin
      then "osx"
      else "linux";

  sha256 =
    if pkgs.stdenv.isDarwin
      then "0h44sjxjiklr9851pwv85rpaqc7yck6q41d3bfxcdn2kq00j0dha"
      else "13jdki193pif3w6lrzizil8s8az3gs9bg0jzx98ar5sy9d8iikrm";

in

  pkgs.stdenv.mkDerivation rec {
    name = "spago";
    version = "0.6.0.0";

    src = pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/${version}/${platform}.tar.gz";
      sha256 = sha256;
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
