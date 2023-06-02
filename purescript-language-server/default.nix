# How to generate the files in this directory:
#
#     nix run nixpkgs#node2nix -- -i <(echo '["purescript-language-server"]') -c composition.nix -18
#
{ pkgs ? import <nixpkgs> { } }:

(import ./composition.nix { inherit pkgs; }).purescript-language-server
