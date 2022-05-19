{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.15.2";

  src =
    if pkgs.stdenv.isDarwin then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "06fsq9ynfvfqn3ac5jxdj81lmzd6bh84p7jz5qib31h27iy5aq4h";
        }
    else # assume Linux
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "1p37k6briczw6gvw04idkx734ms1swgrx9sl4hi6xwvxkfp1nm0m";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
