#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-git jq

# prelude
script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")

# config
owner="kRITZCREEK"
repo="pscid"

# script
output=$(nix-prefetch-git https://github.com/$owner/$repo)
rev=$(echo "$output" | jq --raw-output .rev)
sha256=$(echo "$output" | jq --raw-output .sha256)

cat > "$script_dir/revision.json" <<EOF
{
  "owner": "$owner",
  "repo": "$repo",
  "rev": "$rev",
  "sha256": "$sha256"
}
EOF
