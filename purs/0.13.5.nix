{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.5";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.5/macos.tar.gz";
    sha256 = "051rb2rpkrvxs00q6ivq6c009azyplsj9a9v7arv18y3cls3h3wg";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.5/linux64.tar.gz";
    sha256 = "016wvwypgb4859f0n1lqsqv9a8cca2y8g7d6ffvzx6rncd115gxi";
  };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
