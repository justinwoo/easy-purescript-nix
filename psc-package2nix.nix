{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "f0d76ecb1e1f3b0665cc72ce3a4a656496a0e8d1";
  sha256 = "0mg3pxggag7yl4jkzj6mhp0cjbc7q19k37y7crzl6ki9cbrq2p6a";
}) {
  inherit pkgs;
}
