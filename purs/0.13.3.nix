{ pkgs ? import <nixpkgs> {} }:

let
  version = "v0.13.3";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.3/macos.tar.gz";
      sha256 = "04ylhqadj7wnclhiar9il6fkrxmh9qkz6fpas7z3b37w4qg0gshl";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.3/linux64.tar.gz";
      sha256 = "1xcn694qfql87pdjh09hhvfvpakzxb2hagss61vh9msqq3s96l3z";
    };

in import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
