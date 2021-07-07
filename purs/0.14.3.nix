{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.3";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "1ipksp6kx3h030xf1y3y30gazrdz893pklanwak27hbqfy3ckssj";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "158jyjpfgd84gbwpxqj41mvpy0fmb1d1iqq2h42sc7041v2f38p0";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
