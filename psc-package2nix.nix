{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "38e3d1f8edc859c0e0f1292fae05cdcccaaadb10";
  sha256 = "0v0hnjs753saknfa23wa3ha7adnxz1hnii05gi506d35rn6yf4l3";
}) {
  inherit pkgs;
}
