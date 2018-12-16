{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "4dc25445b5e368ecc683f337f286d7bbcb05d3f3";
  sha256 = "1bnl3rzgggzlbvrcq76xgb45v4b9pxsvsdyyyxddpf7jlv73j2vm";
}) {
  inherit pkgs;
}
