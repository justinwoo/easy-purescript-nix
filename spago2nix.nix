{ pkgs ? import <nixpkgs> { } }:

import
  (
    pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "spago2nix";
      rev = "a4622c3b27fca47e3276131a8ec4097a1d3c78a7";
      sha256 = "1v7mpzqx9hwfk7xz1vyf3xf2ry7zb7658mh11r7d2avb311b1xw2";
    }
  ) {
  inherit pkgs;
}
