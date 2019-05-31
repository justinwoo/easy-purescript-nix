#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-git jq nodePackages.node2nix nodePackages.bower2nix

# prelude
script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")

# script
$script_dir/update-revision.sh

src_dir=$(nix-build --quiet $script_dir/src.nix)

mkdir -p $script_dir/generated

node2nix \
  --input $src_dir/package.json \
  --lock $src_dir/package-lock.json \
  --nodejs-10 \
  --output $script_dir/generated/node2nix-node-modules.nix \
  --composition $script_dir/generated/node2nix-default.nix \
  --node-env $script_dir/generated/node2nix-node-env.nix

bower2nix $src_dir/bower.json $script_dir/generated/bower2nix-bower-components.nix
