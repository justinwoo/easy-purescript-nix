{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "7d0eb6aa3789720fa806c16fb6e96f4715ab4740";
  sha256 = "095jlmk7z0g38710kh9lnj0byhz2dshwamz2ixzliawwiiw2zzp8";
}) {
  inherit pkgs;
}
