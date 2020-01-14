{ pkgs ? import <nixpkgs> {} }:

let
  patchelf = libPath: if pkgs.stdenv.isDarwin
  then ""
  else ''
    chmod u+w $SPAGO
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $SPAGO
    chmod u-w $SPAGO
  '';

in
pkgs.stdenv.mkDerivation rec {
  name = "spago";

  version = "0.13.1";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/spacchetti/spago/releases/download/0.13.1/osx.tar.gz";
    sha256 = "06hkqvz0biim6qjzhwh76j5njjidk8w8ark1w1ybkqcn07cp67v1";
  }
  else pkgs.fetchurl {
    url = "https://github.com/spacchetti/spago/releases/download/0.13.1/linux.tar.gz";
    sha256 = "0s2ck0yd494mbjn21fghra2hh0h5mc5warpak19a8v7xbf65vhl5";
  };

  buildInputs = [ pkgs.gmp pkgs.zlib pkgs.ncurses5 pkgs.stdenv.cc.cc.lib ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src -C $out/bin

    SPAGO=$out/bin/spago
    ${patchelf libPath}


    mkdir -p $out/etc/bash_completion.d/
    $SPAGO --bash-completion-script $SPAGO > $out/etc/bash_completion.d/spago-completion.bash
  '';

  dontInstall = true;
}
