{ fetchurl }:
let
  rev = "e6077f3afaec23de5388761e4ed7857603670894";
in
import (fetchurl {
  url = "https://raw.githubusercontent.com/NixOS/nixpkgs/${rev}/pkgs/development/node-packages/node-env.nix";
  name = "node-env-${rev}";
  sha256 = "16zkx405zfwbhpfn6bpawg3ygcphzmc3jzw6ly05m7w7lbqvfiv5";
})
