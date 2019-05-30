let
  pkgs = import <nixpkgs> {};

  easy-dhall = import ./easy-dhall {
    inherit pkgs;
  };

  inputs = rec {
    purs = import ./purs.nix {
      inherit pkgs;
    };

    purs-simple = purs;

    purescript = purs;

    psc-package-simple = import ./psc-package-simple.nix {
      inherit pkgs;
    };

    psc-package = psc-package-simple;

    purp = import ./purp.nix {
      inherit pkgs;
    };

    inherit (easy-dhall) dhall-simple dhall-json-simple;

    spacchetti-cli = import ./spacchetti-cli.nix {
      inherit pkgs;
    };

    spago = import ./spago.nix {
      inherit pkgs;
    };

    psc-package2nix = import ./psc-package2nix.nix {
      inherit pkgs;
    };

    zephyr = import ./zephyr.nix {
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
