{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "zephyr";
  version = "v0.2.1";

  src = pkgs.fetchurl {
    url = "https://github.com/coot/zephyr/releases/download/${version}/linux64.tar.gz";
    sha256 = "0afcnpqabjs4b60grkcvz2hb3glpjhlnvqvpgc0zsdwaqnmcrrnk";
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
    tar xf $src --strip 1 -C $out

    ZEPHYR=$out/bin/zephyr
    install -D -m555 -T $out/zephyr $ZEPHYR

    chmod u+w $ZEPHYR
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $ZEPHYR
    chmod u-w $ZEPHYR

    mkdir -p $out/etc/bash_completion.d/
    $ZEPHYR --bash-completion-script $ZEPHYR > $out/etc/bash_completion.d/zephyr-completion.bash
  '';

  dontInstall = true;
}
