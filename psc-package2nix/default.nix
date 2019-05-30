{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "6e8f6dc6dea896c71b30cc88a2d95d6d1e48a6f0";
  sha256 = "0fa6zaxxmqxva1xmnap9ng7b90zr9a55x1l5xk8igdw2nldqfa46";
}) {
  inherit pkgs;
}
