{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-dhall-nix";
    rev = "62f6ab3eec5a2c0bf62f604f48cd15465b10023a";
    sha256 = "07lvvc3yvjy6ji3z320f467n485hzwwa9ldwi6zylxcb6a2jb7i0";
  }
) {
  inherit pkgs;
}
