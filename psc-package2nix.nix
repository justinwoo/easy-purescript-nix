{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "5d5fac12e04b00299b413f25a2ea0174cef8bf10";
  sha256 = "0zvfwp3lcz2yc225q78xn8437657cpfd42gyjhm54hr22mq1mcpy";
}) {
  inherit pkgs;
}
