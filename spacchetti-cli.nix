{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "spacchetti";
  version = "0.4.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/spacchetti-cli/releases/download/${version}/linux.tar.gz";
    sha256 = "0ngp1x85darqx0hlyl9cajjc8gh6lmp3pkpxmsb338rsk72nwx6l";
  };

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src -C $out/bin
  '';

  dontInstall = true;
}
