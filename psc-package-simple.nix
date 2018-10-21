{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "psc-package-simple";
  version = "v0.4.2";

  src = pkgs.fetchurl {
    url = "https://github.com/purescript/psc-package/releases/download/${version}/linux64.tar.gz";
    sha256 = "0h8jkxqxi44vrzwl1c5zddxjxqbzkwgmn2m7gxlgs019xlsmml4w";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T psc-package $out/bin/psc-package
  '';
}
