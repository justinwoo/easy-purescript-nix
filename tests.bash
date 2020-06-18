#!/usr/bin/env nix-shell
#!nix-shell ci.nix -i bash

which purs
purs --version

which psc-package
psc-package --version

which purp
purp

which dhall
dhall version

which spago
spago version

which spago2nix
spago2nix

which pscid
pscid --help

which purty
purty --help

which zephyr
zephyr --version
