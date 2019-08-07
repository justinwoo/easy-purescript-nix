{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.0";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.0/macos.tar.gz";
      sha256 = "0xpisy38gj6fgyyzm6fdl0v819dhjmil4634xxangvhvs7jf5il0";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.0/linux64.tar.gz";
      sha256 = "06g5q69yv6c3alq9vr8zjqqzamlii7xf6vj9j52akjq5lww214ba";
    };

in import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
