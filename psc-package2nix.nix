{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    rev = "ec7452fa9dd969b07ffa22f5b3cef5f3655f0e88";
    sha256 = "07gbqy3n3nbscxwni3rvq0bsr77x6xfdrqhzk9ci5r550ldzlqc5";
  }
) {
  inherit pkgs;
}
