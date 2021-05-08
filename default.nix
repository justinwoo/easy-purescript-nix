{ pkgs ? import <nixpkgs> { } }:

let
  easy-dhall = import ./easy-dhall.nix {
    inherit pkgs;
  };

  inputs = rec {
    purs-0_14_1 = import ./purs/0.14.1.nix {
      inherit pkgs;
    };

    purs-0_14_0 = import ./purs/0.14.0.nix {
      inherit pkgs;
    };

    purs-0_13_8 = import ./purs/0.13.8.nix {
      inherit pkgs;
    };

    purs-0_13_6 = import ./purs/0.13.6.nix {
      inherit pkgs;
    };

    purs-0_13_5 = import ./purs/0.13.5.nix {
      inherit pkgs;
    };

    purs-0_13_4 = import ./purs/0.13.4.nix {
      inherit pkgs;
    };

    purs-0_13_3 = import ./purs/0.13.3.nix {
      inherit pkgs;
    };

    purs-0_13_2 = import ./purs/0.13.2.nix {
      inherit pkgs;
    };

    purs-0_13_0 = import ./purs/0.13.0.nix {
      inherit pkgs;
    };

    purs = purs-0_14_1;

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

    spago = import ./spago.nix {
      inherit pkgs;
    };

    psc-package2nix = import ./psc-package2nix.nix {
      inherit pkgs;
    };

    spago2nix = import ./spago2nix.nix {
      inherit pkgs;
    };

    zephyr = import ./zephyr.nix {
      inherit pkgs;
    };

    psa = import ./psa {
      inherit pkgs;
    };

    pscid = import ./pscid {
      inherit pkgs;
    };

    pulp = (import ./pulp {
      inherit pkgs;
    }).pulp;
  };

  buildInputs = builtins.attrValues inputs;

in
inputs // {
  inputs = inputs;

  buildInputs = buildInputs;

  shell = pkgs.runCommand "easy-purescript-nix-shell"
    {
      buildInputs = buildInputs;
    } "";
}
