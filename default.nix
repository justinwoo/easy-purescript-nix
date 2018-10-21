let
  pkgs = import <nixpkgs> {};

  inputs = {
    purs = import ./purs.nix {};
    psc-package-simple = import ./psc-package-simple.nix {};
    purp = import ./purp.nix {};

    dhall-simple = import ./dhall-simple.nix {};
    dhall-json-simple = import ./dhall-json-simple.nix {};
    spacchetti-cli = import ./spacchetti-cli.nix {};
  };

  buildInputs = builtins.attrValues inputs;
in {
  inherit (inputs);
  buildInputs = buildInputs;

  shell = pkgs.stdenv.mkDerivation {
    name = "easy-purescript-nix-shell";
    src = ./.;
    buildInputs = buildInputs;
  };
}
