{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.15.3";

  src =
    if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then
      (pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "083pd5l0q2dj4ky9r4sgnfiinlch73qcvl3l26jf3nfs48y8hffv";
      })
    else if pkgs.stdenv.hostPlatform.system == "x86_64-darwin" then
      (pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
        sha256 = "01ka3j1aakcabw6kmkfbk4c2cl2prihk6g8zvc995l83snj4n403";
      })
    else
      throw "Architecture not supported";

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
