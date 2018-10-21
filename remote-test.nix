let
  pkgs = import <nixpkgs> {};

  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "ee7da7d";
    sha256 = "19vdqz8045l47in45a8kgw5ygsj3cbhjczbw62ih56dqwxrd2w44";
  });
in pkgs.stdenv.mkDerivation {
  name = "remote-test";
  src = ./.;

  buildInputs = remote.buildInputs;
}
