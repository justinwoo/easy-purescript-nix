#! /usr/bin/env nix-shell
#! nix-shell -p node2nix -i bash

node2nix -i node-packages.json -c composition.nix  -14
