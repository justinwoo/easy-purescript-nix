{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "511ea3ff35b79064b3e5a8d500599f9abf56e16a";
  sha256 = "0cy4nd1amhiaa7cxyix7ph88ndw7xrqd1c8mx54ydr01yqny3n95";
}) {
  inherit pkgs;
}
