{ pkgs ? import <nixpkgs> {} }:

pkgs.fetchFromGitHub (
  builtins.fromJSON (
    builtins.readFile ./revision.json
  )
)
