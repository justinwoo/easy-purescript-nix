{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "spacchetti";
  version = "0.5.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/spacchetti-cli/releases/download/${version}/linux.tar.gz";
    sha256 = "1rgkwxhvzy5scjn5v0hf988k8sdmm3qa9agj9swxq6w2h80i1lnr";
  };

  buildInputs = [ pkgs.gmp ];
  dontStrip = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src -C $out/bin
    chmod u+w $out/bin/spacchetti
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath "${pkgs.gmp}/lib" $out/bin/spacchetti
    chmod u-w $out/bin/spacchetti
  '';

  dontInstall = true;
}
