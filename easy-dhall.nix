{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "fc8fb7af3b06e586a937e1addf45e3716d1b1691";
  sha256 = "1gzr3jzrppk648dnz338l5dm2khdbmc1jghhhfw0bpxnc2cxrxgx";
}) {}
