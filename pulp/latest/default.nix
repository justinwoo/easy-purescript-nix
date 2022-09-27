{ pkgs ? import <nixpkgs> { } }:

(import ./composition.nix { inherit pkgs; })."pulp"
