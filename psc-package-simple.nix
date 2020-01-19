{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in
pkgs.stdenv.mkDerivation rec {
  name = "psc-package-simple";

  version = "v0.6.0";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/psc-package/releases/download/v0.6.0/macos.tar.gz";
    sha256 = "0v1hy67rivgcngirfl71nqabq902csdzwqhkx7hnmg49j83fdca2";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/psc-package/releases/download/v0.6.0/linux64.tar.gz";
    sha256 = "1wszhrj7mj7k4k0laq18aip9n52cds6pwrh043iwdj3y0681vwa1";
  };

  buildInputs = [ pkgs.gmp ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin

    PSC_PACKAGE=$out/bin/psc-package

    install -D -m555 -T psc-package $PSC_PACKAGE
    chmod u+w $PSC_PACKAGE
  '' + pkgs.stdenv.lib.optionalString pkgs.stdenv.isDarwin ''
    install_name_tool \
      -change /usr/lib/libSystem.B.dylib ${pkgs.darwin.Libsystem}/lib/libSystem.B.dylib \
      -change /usr/lib/libiconv.2.dylib ${pkgs.libiconv}/libiconv.2.dylib \
      $PSC_PACKAGE
  '' + pkgs.stdenv.lib.optionalString (!pkgs.stdenv.isDarwin) ''
    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PSC_PACKAGE
  '' + ''
    chmod u-w $PSC_PACKAGE

    mkdir -p $out/etc/bash_completion.d/
    $PSC_PACKAGE --bash-completion-script $PSC_PACKAGE > $out/etc/bash_completion.d/psc-package-completion.bash
  '';
}
