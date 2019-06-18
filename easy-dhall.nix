{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "b4736f4496cf313d41203f75a87f229b9a435f76";
  sha256 = "0lzzbwnkfs5fqya0r2wzzrysmn08rl002cndkz9s261gydp03pz4";
}) {}
