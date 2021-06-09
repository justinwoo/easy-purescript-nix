{ pkgs ? import <nixpkgs> { inherit system; }
, system ? builtins.currentSystem
, nodejs ? pkgs."nodejs-12_x"
}:

let
  nodeEnv = import ./node-env.nix {
    inherit (pkgs) stdenv lib python2 runCommand writeTextFile;
    inherit pkgs nodejs;
    libtool = if pkgs.stdenv.isDarwin then pkgs.darwin.cctools else null;
  };

  nodePackage = import ./node-packages.nix {
    inherit (pkgs) fetchurl nix-gitignore stdenv lib fetchgit;
    inherit nodeEnv;
  };

  source = nodePackage.sources."purescript-psa-0.8.2".src;
in
nodeEnv.buildNodePackage (nodePackage.args // { src = source; })
