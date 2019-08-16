{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "spago2nix";
  rev = "1e8d02926761d38f9500691ef802c2938af46f0b";
  sha256 = "0fqrmw8k3kq0q3v236y9xllgl0pxhcv5bsyig8v2s39bjm2skdsz";
}) {
  inherit pkgs;
}
