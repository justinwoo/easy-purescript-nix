{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.14.0";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
    sha256 = "0dfnn5ar7zgvgvxcvw5f6vwpkgkwa017y07s7mvdv44zf4hzsj3s";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
    sha256 = "1l3i7mxlzb2dkq6ff37rvnaarikxzxj0fg9i2kk26s8pz7vpqgjh";
  };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
