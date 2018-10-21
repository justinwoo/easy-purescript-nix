{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";
  version = "1.18.0";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-${version}-x86_64-linux.tar.bz2";
    sha256 = "0gq5bjpvndf3m1xccrz3vk1hqjl4pkagzb57q69v7544clvij83v";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall $out/bin/dhall
  '';
}
