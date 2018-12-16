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
    echo 'WARNING: Spacchetti-CLI is now Spago.'
    echo 'You should install the Spago derivation instead.'
    echo 'See changelog here: https://github.com/spacchetti/spago/releases/tag/0.6.0.0'
    mkdir -p $out/bin
    tar xf $src -C $out/bin

    SPACCHETTI=$out/bin/spacchetti

    chmod u+w $SPACCHETTI
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath "${pkgs.gmp}/lib" $SPACCHETTI
    chmod u-w $SPACCHETTI

    mkdir -p $out/etc/bash_completion.d/
    $SPACCHETTI --bash-completion-script $SPACCHETTI > $out/etc/bash_completion.d/spacchetti-cli-completion.bash
  '';

  dontInstall = true;
}
