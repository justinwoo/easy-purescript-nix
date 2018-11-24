{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";
  version = "1.19.0";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-${version}-x86_64-linux.tar.bz2";
    sha256 = "0vxl0q5lm9h5s8x3xbqqffx8z3c25c65xy5kplzkpdvibjnf2frp";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall $out/bin/dhall
  '';
}
