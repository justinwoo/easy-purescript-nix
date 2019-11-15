{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.4";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.4/macos.tar.gz";
    sha1 = "706b29cd5b23a906cfa8967ced786b6fe29be014";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.4/linux64.tar.gz";
    sha1 = "8a28fb73445bbee411dd5d7f5997ec917bc071c8";
  };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
