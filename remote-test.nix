{ pkgs ? import <nixpkgs> {} }:

let
  remote = import (
    pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "a09d4ff6a8e4a8a24b26f111c2a39d9ef7fed720";
      sha256 = "1iaid67vf8frsqfnw1vm313d50mdws9qg4bavrhfhmgjhcyqmb52";
    }
  ) {
    inherit pkgs;
  };

in
pkgs.mkShell {
  buildInputs = remote.buildInputs;
}
