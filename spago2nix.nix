{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "spago2nix";
    rev = "ff6197f08125a82e722303c05aa7b93492a225b3";
    sha256 = "1k1ib5zascl8zzfq0djwg24q7f6742gb6pcdfq52a3icxjch3178";
  }
) {
  inherit pkgs;
}
