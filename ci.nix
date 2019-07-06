{ pkgs ? import <nixpkgs> {} }:

let
  default = import ./default.nix {};

  buildInputs = builtins.attrValues {
    inherit (default)
      purs
      psc-package
      purp
      dhall-simple
      dhall-json-simple
      spago
      zephyr
      pscid
      spago2nix
      purty
      psc-package2nix;
  };

in pkgs.runCommand "easy-purescript-nix-ci-shell" {
  buildInputs = buildInputs;
} ""
