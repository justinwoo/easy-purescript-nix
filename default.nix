let
  pkgs = import <nixpkgs> {};

  inputs = {
    purs = import ./purs.nix { inherit pkgs; };
    psc-package-simple = import ./psc-package-simple.nix { inherit pkgs; };
    purp = import ./purp.nix { inherit pkgs; };

    dhall-simple = import ./dhall-simple.nix { inherit pkgs; };
    dhall-json-simple = import ./dhall-json-simple.nix { inherit pkgs; };
    spacchetti-cli = import ./spacchetti-cli.nix { inherit pkgs; };

    psc-package2nix = import ./psc-package2nix.nix { inherit pkgs; };
  };

  buildInputs = builtins.attrValues inputs;
in {
  inputs = inputs;

  buildInputs = buildInputs;

  shell = pkgs.stdenv.mkDerivation {
    name = "easy-purescript-nix-shell";
    src = ./.;
    buildInputs = buildInputs;
  };
}
