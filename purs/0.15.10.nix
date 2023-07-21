{ pkgs ? import <nixpkgs> { }, system ? pkgs.stdenv.hostPlatform.system }:

let
  version = "v0.15.10";

  urls = {
    "x86_64-linux" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
      sha256 = "03p5f2m5xvrqgiacs4yfc2dgz6frlxy90h6z1nm6wan40p2vd41r";
    };
    "x86_64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
      sha256 = "14yd00v3dsnnwj2f645vy0apnp1843ms9ffd2ccv7bj5p4kxsdzg";
    };
    "aarch64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos-arm64.tar.gz";
      sha256 = "1pk6mkjy09qvh8lsygb5gb77i2fqwjzz8jdjkxlyzynp3wpkcjp7";
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
