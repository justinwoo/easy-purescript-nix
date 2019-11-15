{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.5";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.5/macos.tar.gz";
    sha1 = "9375793d3ffdef7cf9bebaa7a3135ef9b19ac6c0";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.5/linux64.tar.gz";
    sha1 = "58b14014ba08ef6550fa61700797688d27a9a2f3";
  };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
