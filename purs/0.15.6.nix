{ pkgs ? import <nixpkgs> { }, system ? pkgs.stdenv.hostPlatform.system }:

let
  version = "v0.15.6";

  urls = {
    "x86_64-linux" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
      sha256 = "1vw3igxv4zr5gf1ml5ls17w9cc9shdn8fvbk6dkfnxrs93cwrq0k";
    };
    "x86_64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
      sha256 = "14l4m9xgp9slg4hfaqkwvzdvmg26qj2livldni3lmivvcagjgb2x";
    };
  };

  src =
    if builtins.hasAttr system urls then
      (pkgs.fetchurl urls.${system})
    else if system == "aarch64-darwin" then
      let
        useArch = "x86_64-darwin";
        msg = "Using the non-native ${useArch} binary. While this binary may run under Rosetta 2 translation, no guarantees can be made about stability or performance.";
      in
      pkgs.lib.warn msg (pkgs.fetchurl urls.${useArch})
    else
      throw "Architecture not supported: ${system}";
in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
