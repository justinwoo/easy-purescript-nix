{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  revisions = builtins.fromJSON (builtins.readFile ./revision.json);
in pkgs.stdenv.mkDerivation rec {
  name = "psc-package-simple";

  version = revisions.version;

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl { inherit (revisions.mac) url sha256; }
    else pkgs.fetchurl { inherit (revisions.linux) url sha256; };

  buildInputs = [ pkgs.gmp ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin

    PSC_PACKAGE=$out/bin/psc-package

    install -D -m555 -T psc-package $PSC_PACKAGE
    chmod u+w $PSC_PACKAGE
    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PSC_PACKAGE
    chmod u-w $PSC_PACKAGE

    mkdir -p $out/etc/bash_completion.d/
    $PSC_PACKAGE --bash-completion-script $PSC_PACKAGE > $out/etc/bash_completion.d/psc-package-completion.bash
  '';
}
