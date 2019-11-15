{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.2";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.2/macos.tar.gz";
      sha1 = "d3ef12d802ef5ace14fbf7c6c2c97ce1c3b6304c";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.2/linux64.tar.gz";
      sha1 = "3d0259a82a48a776e31116bd7a5f607a2f035c49";
    };

in import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
