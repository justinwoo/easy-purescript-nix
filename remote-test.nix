{ pkgs ? import <nixpkgs> {} }:

let
  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "9a8d138663c5d751e3a84f1345166e1f0f760a07";
    sha256 = "1c0mqn4wxh4bmxnf6hgrhk442kl2m9y315wik87wrw2ikb7s1szf";
  }) {
    inherit pkgs;
  };

in pkgs.runCommand "easy-purescript-remote-test" {
  buildInputs = remote.buildInputs;
} ""
