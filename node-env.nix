{ fetchurl }:

let
  rev = "199de0468881366154840753a946dd585677ea52";

in
import (
  fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixpkgs/${rev}/pkgs/development/node-packages/node-env.nix";
    name = "node-env-${rev}";
    sha256 = "04krw2q8ia9m5z565pq2jwys8d1yvi6dr9248q76apcdi19c54a7";
  }
)
