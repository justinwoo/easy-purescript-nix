{ pkgs ? import <nixpkgs> {} }:

let
  default = import ./default.nix {};

  buildInputs = builtins.attrValues {
    inherit (pkgs) gnumake which;

    inherit (default)
      purs
      purp
      dhall-simple
      spago
      pscid
      spago2nix
      purty;
  };

in pkgs.mkShell {
  buildInputs = buildInputs;
}
