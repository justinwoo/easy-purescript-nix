{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";
  version = "1.2.4";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-json/releases/download/${version}/dhall-json-${version}-x86_64-linux.tar.bz2";
    sha256 = "0db8sk05mvlv5nlri3qh5z2ny75jrq1c882iyacgdra6zlbnsz79";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall-to-json $out/bin/dhall-to-json
  '';
}
