{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "purp";
  rev = "f4689b1a5ea9251136edf3f1929ae40977d8fc75";
  sha256 = "0ym9842y9dq1d5bhn1a9rhhf8kiwwn6m1zjl827a8fxsg15z1y0v";
}) {
  inherit pkgs;
}
