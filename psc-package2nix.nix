{ pkgs ? import <nixpkgs> {} }:

import (
  pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    rev = "f271b3ad7a8e2931a50b03dafd906262679d527f";
    sha256 = "0dqz0955912jq7imrh09dms4pj3cj4aags666dpg0p5zgk30sgnl";
  }
) {
  inherit pkgs;
}
