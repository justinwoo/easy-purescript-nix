{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.2";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.2/macos.tar.gz";
      sha256 = "14svlra2vhbxyk2l76czhxj16w9jhnwagb8mwv9pw4siiayqa8cz";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.2/linux64.tar.gz";
      sha256 = "00jm8hmg7xq4c6z1b00b4y229n6bpbvfkzbij2idanms1p1m4mfm";
    };

in import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
