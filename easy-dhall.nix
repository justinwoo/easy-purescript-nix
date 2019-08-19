{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "14f7e929210e928f7b5beade5ef163a62a5d1f4b";
  sha256 = "02f5723rx4q4b53dbckmc7mgzfc1m27xbh1m8rkdhlkklwb5jydp";
}) {
  inherit pkgs;
}
