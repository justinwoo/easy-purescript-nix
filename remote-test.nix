{ pkgs ? import <nixpkgs> {} }:
let
  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "91e293a2625cd9d58fc514894dfdff22b4ee82c1";
    sha256 = "1rd18wy9jcdx65by04qr852wdwar31d0h5j6dykaymifj6qajh8d";
  });
in pkgs.runCommand "easy-purescript-remote-test" {
  buildInputs = remote.buildInputs;
} ""
