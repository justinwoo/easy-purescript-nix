{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "73ed20532413fe27fd6df78b9f690feab7b65bd7";
  sha256 = "1hgs0bwzvfv5mlcby6gr4m8algnm2xxii0cdn53ya3fx66m6dz2z";
}) {
  inherit pkgs;
}
