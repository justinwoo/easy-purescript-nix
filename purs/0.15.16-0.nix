{ pkgs ? import <nixpkgs> { }, system ? pkgs.stdenv.hostPlatform.system }:

let
  version = "v0.15.16-0";

  urls = {
    "x86_64-linux" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
      sha256 = "1shpa3ya7jkmdasqbxkk85j8blp39jfajgknwkl7xx3jrkrxx1rn";
    };
    "x86_64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
      sha256 = "1635hfd0m74wayj18nxl642nf8mpc14655jh65blm5w3fbl5dnj1";
    };
    "aarch64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos-arm64.tar.gz";
      sha256 = "1rygzxkzlsac9p48brf66255ag92k82sw6b18hzrsx166av5qc7w";
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
