{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.4";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.4/macos.tar.gz";
    sha256 = "0rqjair1r1yr1k8rva3ly16dv5594f4s8xwpnrz9n7x3f99mk4fx";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.4/linux64.tar.gz";
    sha256 = "1ajzi5ikgzgdfrgq36r9pc3yc6f7h0qgnqcq414zd66z08mbggng";
  };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
