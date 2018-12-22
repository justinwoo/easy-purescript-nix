{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "c8731c8a0033dcc3efb513003fb860906b691575";
  sha256 = "1ij2l8zsdq06f9lflh41m53m5qgmbzrrza4gwhvlbwps5abdpzij";
}) {
  inherit pkgs;
}
