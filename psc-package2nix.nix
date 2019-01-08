{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "e1ebb9fc76bc11a8f2b31dda287239043931174a";
  sha256 = "05h74w0zakpadnywcn1w807p1yf4wkz2qnkb0p0gbkvw24c1dgri";
}) {
  inherit pkgs;
}
