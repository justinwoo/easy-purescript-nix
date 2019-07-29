{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "spago2nix";
  rev = "1e5f612ee1d57476fa145993e99e4d1a085d2a7f";
  sha256 = "1hpmj3qwidrrshjgkiw9hc3h5mg5hm63hxhyhfj3vy946nlkhng2";
}) {
  inherit pkgs;
}
