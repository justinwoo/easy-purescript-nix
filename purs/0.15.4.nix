{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.15.4";

  src =
    if pkgs.stdenv.isDarwin then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "0rksc6c98pp48lcavair6apjpgq3s1zz0lhkc59vbz67c8zxc26d";
        }
    else # assume Linux
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "13p6qsba6kmcsppc3z6vcm3v5c7jxhp10nyvxry4nmj9mkdmjaiy";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
