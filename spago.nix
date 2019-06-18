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

  version = "0.8.4.0";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.8.4.0/osx.tar.gz";
      sha256 = "1xg2diidz3z53jvk4n9df24k5va7lww92md58a6r5vbnc4z0avv8";
    }
    else pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.8.4.0/linux.tar.gz";
      sha256 = "0i6q21dhn78sjgzfvdxh6i59jfq6z2q1xzzdv3c3mnxlmjpi4y96";
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
