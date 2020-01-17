{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.6";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.6/macos.tar.gz";
    sha256 = "04kwjjrriyizpvhs96jgyx21ppyd1ynblk24i5825ywxlw9hja25";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/v0.13.6/linux64.tar.gz";
    sha256 = "012znrj32aq96qh1g2hscdvhl3flgihhimiz40agk0dykpksblns";
  };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
