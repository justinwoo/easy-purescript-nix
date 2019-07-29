{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in pkgs.stdenv.mkDerivation rec {
  name = "psc-package-simple";

  version = "v0.5.1";

  src = pkgs.fetchurl {
    url = "https://github.com/purescript/psc-package/releases/download/v0.5.1/linux64.tar.gz";
    sha256 = "0nffiqhfdfkg0i9hgz3vhnjrwsb4gg912rmsn2gdfgbh1m44k5df";
  };

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
