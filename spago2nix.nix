{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "spago2nix";
    rev = "96d0fd2ab96e62ad5fa2d5f0dd086652a2ac2901";
    sha256 = "1kzv2y970x0vii2pgfhpyg9q77vw3zz9p370z70sqkc6m424j2vb";
  }
) {
  inherit pkgs;
}
