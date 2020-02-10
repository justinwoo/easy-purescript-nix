{ pkgs ? import ./pinned.nix {} }:

(import ./default.nix { inherit pkgs; }).shell
