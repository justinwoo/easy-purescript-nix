{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-dhall-nix";
    rev = "d8043ca5c48505ac75175a3bf846eecf9c859da2";
    sha256 = "1d6wxavcvvmjpw3j81mplpmgqh28dwhfcr8mpzpwv1y84x48id6m";
  }
) {
  inherit pkgs;
}
