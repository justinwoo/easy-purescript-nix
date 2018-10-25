let
  pkgs = import <nixpkgs> {};

  remote = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "347ab7c91634462c2039c6c0641af5386c251a98";
    sha256 = "0njhcl7dq58b3kmjbz6ndsccv4pcmdxc5lg7p13115phcmznpn99";
  });
in pkgs.stdenv.mkDerivation {
  name = "remote-test";
  src = ./.;

  buildInputs = remote.buildInputs;
}
