{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "816e72e91dae2fff8ef99808bd084c535e1be068";
  sha256 = "0h51dzcchw177x2pgqxi0md0mcmsx649h2p0j0vgjr57h9vnl5vj";
}) {
  inherit pkgs;
}
