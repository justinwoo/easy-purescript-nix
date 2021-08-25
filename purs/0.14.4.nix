{ pkgs ? import <nixpkgs> { } }:

let
  version = "v0.14.4";

  src =
    if pkgs.stdenv.isDarwin
    then
      pkgs.fetchurl
        {
          url = "https://github.com/purescript/purescript/releases/download/${version}/macos.tar.gz";
          sha256 = "0m6zwb5f890d025zpn006qr8cky6zhjycap5az9zh6h47jfbrcf9";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
        sha256 = "0hgsh6l52z873b2zk3llvqik18ifika48lmr71qyhlqf250ng9m0";
      };

in
import ./mkPursDerivation.nix {
  inherit pkgs version src;
}
