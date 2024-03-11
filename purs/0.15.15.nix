{ pkgs ? import <nixpkgs> { }, system ? pkgs.stdenv.hostPlatform.system }:

let
  version = "v0.15.15";

  urls = {
    "x86_64-linux" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
      sha256 = "1w4jgjpfhaw3gkx9sna64lq9m030x49w4lwk01ik5ci0933imzj3";
    };
    "x86_64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
      sha256 = "178ix54k2yragcgn0j8z1cfa78s1qbh1bsx3v9jnngby8igr6yn3";
    };
    "aarch64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos-arm64.tar.gz";
      sha256 = "0bi231z1yhb7kjfn228wjkj6rv9lgpagz9f4djr2wy3kqgck4xg0";
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
