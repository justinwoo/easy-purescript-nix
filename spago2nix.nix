{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "spago2nix";
  rev = "be7e3a785be20bf052223e91bbd07ceccfc334c2";
  sha256 = "0m92vjnpnqnaxcvrp8gl0yvz6156cvq75vf28ip9z3jfj86d7rm8";
}) {
  inherit pkgs;
}
