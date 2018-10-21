let
  pkgs = import <nixpkgs> {};

  purs = import ./purs.nix {};
  psc-package-simple = import ./psc-package-simple.nix {};
  purp = import ./purp.nix {};

  dhall-simple = import ./dhall-simple.nix {};
  dhall-json-simple = import ./dhall-json-simple.nix {};
  spacchetti-cli = import ./spacchetti-cli.nix {};
in {
  purs = purs;
  psc-package-simple = psc-package-simple;
  purp = purp;

  dhall-simple = dhall-simple;
  dhall-json-simple = dhall-json-simple;
  spacchetti-cli = spacchetti-cli;

  easy = pkgs.stdenv.mkDerivation {
    name = "easy-purescript-nix";
    src = ./.;

    buildInputs = [
      purs
      psc-package-simple
      purp

      dhall-simple
      dhall-json-simple
      spacchetti-cli
    ];
  };
}
