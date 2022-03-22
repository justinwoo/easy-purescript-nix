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

  # Temporary fix for https://github.com/justinwoo/easy-purescript-nix/issues/188
  pkgs_ncurses = pkgs.extend (self: super: {
      ncurses5 = super.ncurses5.overrideAttrs (attr: {
        configureFlags = attr.configureFlags ++ ["--with-versioned-syms"];
      });
    });
in
import ./mkPursDerivation.nix {
  inherit version src;
  pkgs = pkgs_ncurses;
}
