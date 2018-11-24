{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";
  version = "1.2.5";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-json-${version}-x86_64-linux.tar.bz2";
    sha256 = "0dikk4dykggdv89i55jy38njnv53ms747s5lvhd2r86q2ja7a1r1";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall-to-json $out/bin/dhall-to-json
  '';
}
