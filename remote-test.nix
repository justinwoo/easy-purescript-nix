let
  pkgs = import <nixpkgs> {};

  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "43b18de";
    sha256 = "0c36pxafmlyq643kvyq61rw8z3h5dbg5gjb6mi7rxb5bsasqwxp8";
  });
in pkgs.stdenv.mkDerivation {
  name = "remote-test";
  src = ./.;

  buildInputs = remote.buildInputs;
}
