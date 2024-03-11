{ pkgs ? import <nixpkgs> { }, system ? pkgs.stdenv.hostPlatform.system }:

let
  version = "v0.15.12";

  urls = {
    "x86_64-linux" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
      sha256 = "05xwplibkv86iiwpv29vg3zxp5yw7waw86zh08q3p0qx355wjy73";
    };
    "x86_64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
      sha256 = "13d2mmphxy9f9yy242qsm58hipr612jymwy7lhf0is4y4m2lvrk2";
    };
    "aarch64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos-arm64.tar.gz";
      sha256 = "0s8j9svgxir0rb0wxkshwal60962g5z0pysdyrjgcr9r77y5gffk";
    };
  };

  src =
    if builtins.hasAttr system urls then
      (pkgs.fetchurl urls.${system})
    else
      throw "Architecture not supported: ${system}";
in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
