{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "a55149eb38c90db69f39122a097b6d2ba428a5cd";
  sha256 = "16g8wn1s3vmky9cngmxlq5n8ciwc5ib3n1hly5vxxiryhqb7wfxb";
}) {
  inherit pkgs;
}
