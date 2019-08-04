{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "83158cb4bb6ea21ccf74f08335b0369b527d12a6";
  sha256 = "1r8biwf3ilkw9hf0f2dqibdj2mk66885fhccp34i44rgmgg755bl";
}) {
  inherit pkgs;
}
