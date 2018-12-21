{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "ad0a04d268f6fed746cf6cb9008e006fced11177";
  sha256 = "0v70x0lm1l4qm92v6ricxhnivb5f78909dgyp46lw7g45bkqkidh";
}) {
  inherit pkgs;
}
