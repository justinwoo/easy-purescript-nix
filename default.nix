{ pkgs ? import <nixpkgs> {} }:

let
  easy-dhall = import ./easy-dhall {
    inherit pkgs;
  };

  inputs = rec {
    purs = import ./purs {
      inherit pkgs;
    };

    purs-simple = purs;

    purescript = purs;

    psc-package-simple = import ./psc-package-simple {
      inherit pkgs;
    };

    psc-package = psc-package-simple;

    purp = import ./purp {
      inherit pkgs;
    };

    inherit (easy-dhall) dhall-simple dhall-json-simple;

    spago = import ./spago {
      inherit pkgs;
    };

    psc-package2nix = import ./psc-package2nix {
      inherit pkgs;
    };

    zephyr = import ./zephyr {
      inherit pkgs;
    };

    pscid = import ./pscid {
      inherit pkgs purs;
    };
  };

  buildInputs = builtins.attrValues inputs;

in inputs // {
  inputs = inputs;

  buildInputs = buildInputs;

  shell = pkgs.runCommand "easy-purescript-nix-shell" {
    buildInputs = buildInputs;
  } "";
}
