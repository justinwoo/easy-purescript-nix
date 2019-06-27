{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "spago2nix";
  rev = "23ea21c94c1ca520fecf6d0c2ddee9bdd9b49540";
  sha256 = "0jmapy9i0v4jfh358krnml7d7m7p30ir4man8hcacm0iyrf97nkb";
}) {
  inherit pkgs;
}
