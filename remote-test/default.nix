{ pkgs ? import <nixpkgs> {} }:

let
  src = pkgs.fetchFromGitHub (
    builtins.fromJSON (
      builtins.readFile ./revision.json
    )
  );

  remote = import src { inherit pkgs; };
in
  pkgs.runCommand "easy-purescript-remote-test" {
    buildInputs = remote.buildInputs;
  } ""
