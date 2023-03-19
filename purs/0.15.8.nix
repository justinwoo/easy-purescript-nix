{ pkgs ? import <nixpkgs> { }, system ? pkgs.stdenv.hostPlatform.system }:

let
  version = "v0.15.8";

  urls = {
    "x86_64-linux" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
      sha256 = "192px9a4ja1iazhahc6ilgxk0x2bjp59qxd9zaww4pldj1b7z20y";
    };
    "x86_64-darwin" = {
      url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
      sha256 = "0aq6b8yw2ll3qgmc21ap2pxfnr7glqhrjx3ggc21q4gwq3zxrrrp";
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
