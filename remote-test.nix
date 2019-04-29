{ pkgs ? import <nixpkgs> {} }:

let
  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "5d8808480436f178ccdc6593744cb6ca642cbb6c";
    sha256 = "0r80d4dmagvkgm44rpjszl84xwgcwdbks2x9inad7akcpmkc8nnh";
  });

in pkgs.runCommand "easy-purescript-remote-test" {
  buildInputs = remote.buildInputs;
} ""
