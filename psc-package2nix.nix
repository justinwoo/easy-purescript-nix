{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "b65125ab1ba2c3554f62de603c5a67f15099bbf7";
  sha256 = "1jzfym0g93bcypahsh0i63dlnqx97a3x9brmfwlp08rql9xmpkvj";
}) {
  inherit pkgs;
}
