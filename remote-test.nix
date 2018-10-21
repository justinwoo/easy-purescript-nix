let
  pkgs = import <nixpkgs> {};

  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "de9275d9e6635addb5c8448e4ca354a62570fd49";
    sha256 = "14g2yrfigsp0z87jk4aand8g1w99fsmfsdbg6zrvkmf4nmjhs074";
  });
in pkgs.stdenv.mkDerivation {
  name = "remote-test";
  src = ./.;

  buildInputs = remote.buildInputs;
}
