{ pkgs ? import <nixpkgs> {} }:

let
  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "6e570ee02fb1f021ec394544864db23f46d25169";
    sha256 = "0hdza0y5ahk0yx9qhgzfdinr1qrxkdfi4m0mw0js2zcbpgxyyrgx";
  }) {
    inherit pkgs;
  };

in pkgs.mkShell {
  buildInputs = remote.buildInputs;
}
