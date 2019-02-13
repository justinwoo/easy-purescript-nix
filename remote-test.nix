{ pkgs ? import <nixpkgs> {} }:
let
  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "15ae0484841c4d984fdb59d9af3d13902777f5ea";
    sha256 = "08505jj83qnc9n7c98y6sb0cdyczzgmpi1cyjbg8jl9l648537ml";
  });
in pkgs.runCommand "easy-purescript-remote-test" {
  buildInputs = remote.buildInputs;
} ""
