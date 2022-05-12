{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.9";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "sha256-ZCXWPtDWxKT9KscziqaxJDaTnn+/nRR3N1Uk2HwHc/8=";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "sha256-c/qjAeJrsuhgJce9xfmDItics+X/lnDUPvsthaBSPDw=";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
