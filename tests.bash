#!/usr/bin/env nix-shell
#!nix-shell ci.nix -i bash

set -e

which purs
purs --version

which pulp
pulp --help
pulp --version

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
pscid --version

which zephyr
zephyr --version
