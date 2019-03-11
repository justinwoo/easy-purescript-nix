{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "5b0470e3743983d27c88b69ff2a85a730d0ac282";
  sha256 = "1464d17f570agr4hm8v0y29l2f582g88wg396vb1mx2yzk3jzg0f";
}) {}
