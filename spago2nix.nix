{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "spago2nix";
    rev = "c87562adeba1f0900ad8d54558794eb721b6add4";
    sha256 = "1yy2csl1zmzqpwzpspvdw3ypvhyci1araqid7a658lj280i9wc7c";
  }
) {
  inherit pkgs;
}
