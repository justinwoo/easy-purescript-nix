{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-dhall-nix";
    rev = "9c4397c3af63c834929b1e6ac25eed8ce4fca5d4";
    sha256 = "1cbrqfbx29rymf4sia1ix4qssdybjdvw0is9gv7l0wsysidrcwhf";
  }
) {
  inherit pkgs;
}
