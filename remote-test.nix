let
  pkgs = import <nixpkgs> {};

  remote-src = pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "8d02bf2ce370a4f9a6997094b8eaa0a808372679";
    sha256 = "0b8da75vg9fgaga4v236ibycqski4138s35l35fciz3ydmzbf8hf";
  };

  remote = import remote-src;
in {
  easy = pkgs.stdenv.mkDerivation {
    name = "easy-purescript-nix";
    src = ./.;

    buildInputs = [
      remote.purs
      remote.psc-package-simple
      remote.purp

      remote.dhall-simple
      remote.dhall-json-simple
      remote.spacchetti-cli
    ];
  };
}
