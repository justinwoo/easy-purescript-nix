{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "spago";
  version = "0.6.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/spacchetti/spago/releases/download/${version}/linux.tar.gz";
    sha256 = "13jdki193pif3w6lrzizil8s8az3gs9bg0jzx98ar5sy9d8iikrm";
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

    chmod u+w $SPAGO
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $SPAGO
    chmod u-w $SPAGO

    mkdir -p $out/etc/bash_completion.d/
    $SPAGO --bash-completion-script $SPAGO > $out/etc/bash_completion.d/spago-completion.bash
  '';

  dontInstall = true;
}
