{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-dhall-nix";
    rev = "1aa3b306e49cada554d8acfe3902e27527ecef98";
    sha256 = "1hhm4m6y5iavfx088qbifn76jdrgglkgqvmgki8z6hj5bz5mnh06";
  }
) {
  inherit pkgs;
}
