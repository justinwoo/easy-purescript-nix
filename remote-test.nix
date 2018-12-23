{ pkgs ? import <nixpkgs> {} }:
let
  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "a4f7d519ddfada355194a70c0889e86e807d2f7d";
    sha256 = "131p54hnkgyy9k2fk94zck79s0bn5rwwlimk8kknjyhyfzfd7aml";
  });
in pkgs.runCommand "easy-purescript-remote-test" {
  buildInputs = remote.buildInputs;
} ""
