{ pkgs ? import <nixpkgs> {} }:

let
  default = import ./default.nix;

  buildInputs = builtins.attrValues {
    inherit (default)
      purs
      psc-package
      purp
      dhall-simple
      dhall-json-simple
      spago
      zephyr
      psc-package2nix
      spago2nix;
  };

in pkgs.runCommand "easy-purescript-nix-ci-shell" {
  buildInputs = buildInputs;
} ""
