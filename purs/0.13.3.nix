{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.3";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.3/macos.tar.gz";
      sha1 = "fb719a9299a5b86fb3b5ba211c27c8370d99c161";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.3/linux64.tar.gz";
      sha1 = "6838ae5972a6130608c04002e46e96915e05f256";
    };

in import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
