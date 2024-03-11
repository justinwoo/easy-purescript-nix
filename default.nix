{ pkgs ? import <nixpkgs> { } }:

let
  easy-dhall = import ./easy-dhall.nix {
    inherit pkgs;
  };

  inputs = rec {
    purs-0_15_16-0 = import ./purs/0.15.16-0.nix {
      inherit pkgs;
    };
    purs-0_15_15 = import ./purs/0.15.15.nix {
      inherit pkgs;
    };
    purs-0_15_14 = import ./purs/0.15.14.nix {
      inherit pkgs;
    };
    purs-0_15_13 = import ./purs/0.15.13.nix {
      inherit pkgs;
    };
    purs-0_15_12 = import ./purs/0.15.12.nix {
      inherit pkgs;
    };
    purs-0_15_11 = import ./purs/0.15.11.nix {
      inherit pkgs;
    };

    purs-0_15_10 = import ./purs/0.15.10.nix {
      inherit pkgs;
    };
    purs-0_15_9 = import ./purs/0.15.9.nix {
      inherit pkgs;
    };
    purs-0_15_8 = import ./purs/0.15.8.nix {
      inherit pkgs;
    };
    purs-0_15_7 = import ./purs/0.15.7.nix {
      inherit pkgs;
    };

    purs-0_15_6 = import ./purs/0.15.6.nix {
      inherit pkgs;
    };

    purs-0_15_4 = import ./purs/0.15.4.nix {
      inherit pkgs;
    };

    purs-0_15_3 = import ./purs/0.15.3.nix {
      inherit pkgs;
    };
    purs-0_15_2 = import ./purs/0.15.2.nix {
      inherit pkgs;
    };

    purs-0_15_0 = import ./purs/0.15.0.nix {
      inherit pkgs;
    };

    purs-0_15_0-alpha-02 = import ./purs/0.15.0-alpha-02.nix {
      inherit pkgs;
    };

    purs-0_14_9 = import ./purs/0.14.9.nix {
      inherit pkgs;
    };

    purs-0_14_7 = import ./purs/0.14.7.nix {
      inherit pkgs;
    };

    purs-0_14_6 = import ./purs/0.14.6.nix {
      inherit pkgs;
    };

    purs-0_14_5 = import ./purs/0.14.5.nix {
      inherit pkgs;
    };

    purs-0_14_4 = import ./purs/0.14.4.nix {
      inherit pkgs;
    };

    purs-0_14_3 = import ./purs/0.14.3.nix {
      inherit pkgs;
    };

    purs-0_14_2 = import ./purs/0.14.2.nix {
      inherit pkgs;
    };

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

    purs = purs-0_15_15;

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

    purs-tidy = import ./purs-tidy {
      inherit pkgs;
    };

    psa = import ./psa {
      inherit pkgs;
    };

    pscid = import ./pscid {
      inherit pkgs;
    };

    pulp = import ./pulp { inherit pkgs; };

    purescript-language-server = import ./purescript-language-server {
      inherit pkgs;
    };

    purty = import ./purty.nix {
      inherit pkgs;
    };

    purs-backend-es = import ./purs-backend-es { inherit pkgs; };

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
