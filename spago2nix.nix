{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "spago2nix";
  rev = "6b9cd7054139290e67cb1c1b9248ce3c62aa8156";
  sha256 = "08j8kd9pd3w1k9bpwfdvgd81gcr2287q47wq8irizykzx6ghlqz5";
}) {
  inherit pkgs;
}
