{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "de5dfc71ce9e7597b62b470dee9254c6de09d515";
  sha256 = "1103sczf2xkwgbmmkmaqf59db6q0gb18vv4v3i7py1f8nlpyv02i";
}) {
  inherit pkgs;
}
