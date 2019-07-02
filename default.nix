{ pkgs ? import <nixpkgs> {} }:

let
  easy-dhall = import ./easy-dhall.nix {
    inherit pkgs;
  };

  nodeEnv = (import ./node-env.nix {
    inherit (pkgs) fetchurl;
  }) {
    nodejs = pkgs.nodejs-10_x;

    # NOTE: Need to use node2nix --nodejs-10

    inherit (pkgs) stdenv python2 utillinux runCommand writeTextFile;

    libtool = if pkgs.stdenv.isDarwin
      then pkgs.darwin.cctools
      else null;
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
  };

  buildInputs = builtins.attrValues inputs;

in inputs // {
  inputs = inputs;

  buildInputs = buildInputs;

  shell = pkgs.runCommand "easy-purescript-nix-shell" {
    buildInputs = buildInputs;
  } "";
}
