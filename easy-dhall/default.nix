{ pkgs ? import <nixpkgs> {} }:

let
  src = pkgs.fetchFromGitHub (
    builtins.fromJSON (
      builtins.readFile ./revision.json
    )
  );
in
  import src { inherit pkgs; }
