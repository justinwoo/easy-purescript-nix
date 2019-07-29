{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "1f0f602adbb60c77e1b9aacd1ee21ba61cb05765";
  sha256 = "1pm1ml24984cchz2j6lmk1l321lqcpvfa967a860m1frsg9x9gay";
}) {}
