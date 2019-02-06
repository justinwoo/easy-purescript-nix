{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "9bff0f9cbdca30bf2f6b5a63436603437ab3cb51";
  sha256 = "1ckrpnzln119k365hapmg73fksna9vzz2q3k752cbxp06s5jpkzp";
}) {
  inherit pkgs;
}
