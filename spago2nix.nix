{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "spago2nix";
    rev = "704fc193dd1066d3bee91e525ad5ea4876ad990e";
    sha256 = "1g82s3wz18lxif3pdd9nk6vb3c5cy1i1w5xpkl9gpvc44x8w7lrl";
  }
) {
  inherit pkgs;
}
