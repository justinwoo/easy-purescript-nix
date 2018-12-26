{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "9e3b8744db0a9d369675a4b12a955614b8100449";
  sha256 = "00ww6fhv8lvihjfzjzpd4kgfqx8isk4nalmc79vh9mhfv7ya0m5p";
}) {}
