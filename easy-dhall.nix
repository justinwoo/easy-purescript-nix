{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-dhall-nix";
    rev = "e0b4e37a6eb3b6546748fab2814988cf492ac46a";
    sha256 = "04jf1w7jkv5xinsh8lkl3cd6y750824six83ymiibiblvy81cgf6";
  }
) {
  inherit pkgs;
}
