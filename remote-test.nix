{ pkgs ? import <nixpkgs> {} }:

let
  remote = import (
    pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "d4879bfd2b595d7fbd37da1a7bea5d0361975eb3";
      sha256 = "0kzwg3mwziwx378kvbzhayy65abvk1axi12zvf2f92cs53iridwh";
    }
  ) {
    inherit pkgs;
  };

in
pkgs.mkShell {
  buildInputs = remote.buildInputs;
}
