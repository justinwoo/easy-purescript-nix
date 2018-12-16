let
  pkgs = import <nixpkgs> {};
  easy-dhall = import ./easy-dhall.nix { inherit pkgs; };

  inputs = {
    purs = import ./purs.nix { inherit pkgs; };
    psc-package-simple = import ./psc-package-simple.nix { inherit pkgs; };
    purp = import ./purp.nix { inherit pkgs; };

    inherit (easy-dhall)
      dhall-simple
      dhall-json-simple;
    spacchetti-cli = import ./spacchetti-cli.nix { inherit pkgs; };

    spago = import ./spago.nix { inherit pkgs; };

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
