{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.0";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.0/macos.tar.gz";
      sha1 = "c3c3e51519683d55844fcd141b20eff472f94385";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.0/linux64.tar.gz";
      sha1 = "249be2fa812c544d69dadaff45af53943d428215";
    };

in import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
