{ pkgs ? import <nixpkgs> {} }:
let
  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "2f56e0895959db39293942786d4d346524360e5b";
    sha256 = "0vaqn0v6abffzma9gfv5cwknz4kpc3kj50siia5cv2mp752b8w98";
  });
in pkgs.runCommand "easy-purescript-remote-test" {
  buildInputs = remote.buildInputs;
} ""
