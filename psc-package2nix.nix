{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "4135235e9577bb130e23b33931a2e228a34fcd34";
  sha256 = "087641lyvpwvd51qc3zgfk8nb4n7fhp0cmg4f2f7rvm9k0ha456v";
}) {
  inherit pkgs;
}
