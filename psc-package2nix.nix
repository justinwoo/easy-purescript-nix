{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "025607f5e87f7fea2b3c8ff1c6c6b515ed0a2aec";
  sha256 = "1736h13wjky8glkhaj60j8hqz74c3i8c5zx36b7lbhqnrrygf5m1";
}) {
  inherit pkgs;
}
