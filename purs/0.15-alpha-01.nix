{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.15.0-alpha-01";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "1vsm7fjdm463hq4k1xwm1kmjq3rbivxyx5s2zmzbbxwjqqsmimhx";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "11y6bsscm0qcn6y619qvgfyxb9mzpd3pk7gqd024a91ipxr5gj4w";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
