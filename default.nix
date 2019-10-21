{ pkgs ? import <nixpkgs> {} }:

let
  easy-dhall = import ./easy-dhall.nix {
    inherit pkgs;
  };

  nodeEnv = (
    import ./node-env.nix {
      inherit (pkgs) fetchurl;
    }
  ) {
    nodejs = pkgs.nodejs-10_x;

    # NOTE: Need to use node2nix --nodejs-10

    inherit (pkgs) stdenv python2 utillinux runCommand writeTextFile;

    libtool = if pkgs.stdenv.isDarwin
    then pkgs.darwin.cctools
    else null;
  };

  inputs = rec {
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

    purs = purs-0_13_4;

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

    pscid = import ./pscid {
      inherit pkgs nodeEnv purs;
    };

    purty = import ./purty.nix {
      inherit pkgs;
    };
  };

  buildInputs = builtins.attrValues inputs;

in
inputs // {
  inputs = inputs;

  buildInputs = buildInputs;

  shell = pkgs.runCommand "easy-purescript-nix-shell" {
    buildInputs = buildInputs;
  } "";
}
