{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "purp";
  rev = "e4c758c04b825b9c29eb76d7965df6c48f13def2";
  sha256 = "155zinqxwmy5sjmia3n9h4g2faj174fi2wlnh1b9mh13nm5rd2hh";
}) { inherit pkgs; }
