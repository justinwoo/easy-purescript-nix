{ pkgs ? import <nixpkgs> { }, system ? pkgs.stdenv.hostPlatform.system }:

let
  version = "v0.15.7";

  urls = {
    "x86_64-linux" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
      sha256 = "032jqrk46k9zbq058ms8rnrq0209rd8vkxwj73vqrlgqvpzlfl5k";
    };
    "x86_64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
      sha256 = "0aq5sr93z6c5l76sqbj3g48z6yrhxfqxri0x1ajmjwhcwjg79d6v";
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
