{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  patchelf = libPath :
    if pkgs.stdenv.isDarwin
      then ""
      else
        ''
          chmod u+w $PURS
          patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PURS
          chmod u-w $PURS
        '';

in pkgs.stdenv.mkDerivation rec {
  name = "purs-simple";
  version = "v0.12.5";

  src =
    if pkgs.stdenv.isDarwin
    then
    pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.12.5/macos.tar.gz";
      sha256 = "15j9lkrl15dicx37bmh0199b3qdixig7w24wvdzi20jqbacz8nkn";
    }
    else
    pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.12.5/linux64.tar.gz";
      sha256 = "07dva5gxq77g787krscv4dsz5088fzkvpmm9fwxw9a59jszzs7kq";
    };


  buildInputs = [ pkgs.zlib
                  pkgs.gmp
                  pkgs.ncurses5];
  libPath = pkgs.lib.makeLibraryPath buildInputs;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    PURS="$out/bin/purs"

    install -D -m555 -T purs $PURS
    ${patchelf libPath}

    mkdir -p $out/etc/bash_completion.d/
    $PURS --bash-completion-script $PURS > $out/etc/bash_completion.d/purs-completion.bash
  '';
}
