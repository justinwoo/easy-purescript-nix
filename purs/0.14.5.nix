{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.5";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "1brvbpzr3cwls809fl0sjrm9cbh8v7maf5d7ic2mha0xapabgfpv";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "1mvxvn30iyrq0ck6g08f925gxnnhbfgl29b2gjjsmm3m9mpll7ws";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
