{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "78eb918b67302721125ec99d8d7b99478931f9e4";
  sha256 = "1mgcsbg19ppdk973dajpyqnhxcas50sfbzljzzc6ydr2i7vy2nim";
}) {
  inherit pkgs;
}
