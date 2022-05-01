{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.15.0";

  src =
    if pkgs.stdenv.isDarwin then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "09d9pwba6fzc08m3nkc7xni29yr12gw5fj00aa77n9kxmsba0fkb";
        }
    else # assume Linux
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "1ygp6wvbgl3y15wq1q41j9kg2ndaxr32rpgbzfzyd9zb8n9z8lpx";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
