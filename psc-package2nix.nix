{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "psc-package2nix";
  rev = "406aa13874b0a6e2e19c0356cd06497b529a3322";
  sha256 = "0wf5k4saw10yhv0i1p9nj8q6m6rfs5yqq9cg2fh3vkflfiy8ggfd";
}) {
  inherit pkgs;
}
