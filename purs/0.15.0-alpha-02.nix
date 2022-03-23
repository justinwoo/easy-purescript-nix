{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.15.0-alpha-02";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "1cfjrp6cgn70x8hwdnhrw1h8q602kbd1l8mxwngrwa1x1bgxcsd6";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "12z1x0zk23k6chdzilk5dlnz5sqlqq9pjxn9gma2346vgnjjcrw3";
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
