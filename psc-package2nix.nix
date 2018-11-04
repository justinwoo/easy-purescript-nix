{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "03c22ec97d39619a66ad7b216bf9fb8b00fc199a";
  sha256 = "0ibgpjik161c8zd8078qpsqydc20kkg59jqx8ln9byi9x1dpf7xl";
}) {
  inherit pkgs;
}
