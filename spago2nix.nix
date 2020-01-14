{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "spago2nix";
    rev = "ad1976ee9e402e91232bbe933ce4cbddba7affc2";
    sha256 = "1w129hrmddgbz51dxjgcf774lh7yxj68h4wch9c31hmpym5d6xp7";
  }
) {
  inherit pkgs;
}
