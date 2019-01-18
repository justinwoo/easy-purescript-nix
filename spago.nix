{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "spago";
  version = "0.6.2.1";

  src = pkgs.fetchurl {
    url = "https://github.com/spacchetti/spago/releases/download/${version}/linux.tar.gz";
    sha256 = "0ljmfjlbppyab009a8g3rzr044mh38qasw2wcngd7s788q9vcjgl";
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
