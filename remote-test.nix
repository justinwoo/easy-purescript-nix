{ pkgs ? import <nixpkgs> {} }:

let
  remote = import (
    pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "054caeb3cd4292920e21a4de92a9decbac8e8953";
      sha256 = "0d6r5a9ayk1l0001aqjcmhkdhqmvwbpnb1w10grilbpwnm3bvz1r";
    }
  ) {
    inherit pkgs;
  };

in
pkgs.mkShell {
  buildInputs = remote.buildInputs;
}
