{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.7";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "0pc07xv5h7jgiy04rcrnsjb97nk5zs7jrvcsqggn0izlnrcyi8rc";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "0vcjxb1v76wg4hmisnw0pp6wl0pwp4fa19cw08zdhgy62w06mqfa";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
