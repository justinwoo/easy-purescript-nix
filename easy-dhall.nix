{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "725fdd1402ca5de9465f9ca94352f34b46deab4f";
  sha256 = "0jap36hns6bby0k7w0p4h5zrd334sscic36zpfl8808r23y24nni";
}) {}
