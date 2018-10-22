let
  pkgs = import <nixpkgs> {};

  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "84723cd";
    sha256 = "1vid6djm64c4whyxsnpxr4s1j7x9fkiv456h3hxagq6z4jsrar71";
  });
in pkgs.stdenv.mkDerivation {
  name = "remote-test";
  src = ./.;

  buildInputs = remote.buildInputs;
}
