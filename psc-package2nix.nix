{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "b6025852ab1067577c33d9011fbd7eae5adf0ded";
  sha256 = "03k94k5y89dabi6bd85hm6jnps4bcjalq64r77gn69dyw33j1465";
}) {
  inherit pkgs;
}
