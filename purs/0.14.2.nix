{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.2";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "1ga2hn9br71dyzn3p9jvjiksvnq21p6i5hp1z1j5fpz9la28nqzf";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "1kv7dm1nw85lw3brrclkj7xc9p021jx3n8wgp2fg3572s86ypskw";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
