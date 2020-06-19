{ pkgs ? import <nixpkgs> {
    inherit system;
  }
, system ? builtins.currentSystem
, nodejs ? pkgs."nodejs-12_x"
}:
let
  nodeEnv = import ./node-env.nix {
    inherit (pkgs) stdenv python2 utillinux runCommand writeTextFile;
    inherit nodejs;
    libtool = if pkgs.stdenv.isDarwin then pkgs.darwin.cctools else null;
  };

  args = (import ./node-packages.nix {
    inherit (pkgs) fetchurl fetchgit;
    inherit nodeEnv;
  }
  ).args;

  npmPackage = builtins.fetchTarball {
    url = "https://registry.npmjs.org/pscid/-/pscid-2.9.3.tgz";
    sha256 = "1vzpi43l5h85j1am4qhxqmzx3rkpa1527jdzgcys7ixhsxs349my";
  };
in
nodeEnv.buildNodePackage (args // { src = npmPackage; })
