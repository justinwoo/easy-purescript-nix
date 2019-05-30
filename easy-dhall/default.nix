{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "d49cdc77be50dd2506576fc31931297620278bec";
  sha256 = "1gmvaw6wnl5ps1g30sgzy6gy2500dvg3nmbw56h85jlzhficspn6";
}) {}
