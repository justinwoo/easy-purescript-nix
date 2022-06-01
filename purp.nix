{ pkgs ? import <nixpkgs> {} }:

import (
  builtins.fetchTarball {
    url = "https://justin.gateway.scarf.sh/purp/d56cc038cd1255c1ea87bdfe916e88890404e3b8.zip";
    sha256 = "0s8drj4zw3fnqwpgsp7zansm0zracxiq8hj59gzdy3r4p7hmp58m";
  }
) {
  inherit pkgs;
}
