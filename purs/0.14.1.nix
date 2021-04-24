{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.1";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "1m2xpnf6npnp1dgwqd1fcfbl6nq1p2k7fbz0jsywx3d6hdn1w7hv";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "1j3g5l0aqqfw8clra36ddnl55ir9k8yqbndnp04ya7s4vwr1hr2v";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
