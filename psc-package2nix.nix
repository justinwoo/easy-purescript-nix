{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "8986905477d95bb0e215a1ad605fd3301d3e3de5";
  sha256 = "1ix7d4nfqr5hx57v7rck05i3q1ji84qxlkl1zgq4x8bmlgcjy2wl";
}) {
  inherit pkgs;
}
