{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "6a7f2fac708abd2f8f5e25680d7fb8cb7d21b3e2";
  sha256 = "1isn8xxi0kxd53wj75j933jvckmzsdm750f1pb7kxzpxwihhlk95";
}) {
  inherit pkgs;
}
