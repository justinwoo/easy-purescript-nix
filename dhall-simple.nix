{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";
  version = "1.18.0";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-${version}-x86_64-linux.tar.bz2";
    sha256 = "0jvw6ss96xifb21mzpvfjzvaffcnpj0jhpc4rd36cl2r22800qgx";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall $out/bin/dhall
  '';
}
