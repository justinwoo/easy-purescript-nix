{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.6";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "0yfl4galaqzbbkql2vfsg4zrc5cv037286764kv8qibdk2yrhap3";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "01mf850a9jhqba6a3hsbl9fjxp2khplwnlr15wzp637s5vf7rd79";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
