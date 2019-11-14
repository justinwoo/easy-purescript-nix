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

  version = "0.10.0.0";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/spacchetti/spago/releases/download/0.11.1.0/osx.tar.gz";
    sha256 = "1bwp665k0fvma9rjlp0fhs65165z5krchdpi41pisxl4rpdgaxdz";
  }
  else pkgs.fetchurl {
    url = "https://github.com/spacchetti/spago/releases/download/0.11.1.0/linux-dynamic.tar.gz";
    sha256 = "0yr3n6rsg9ly1v2cxldi174026z59klm1k40sadrqvhhh9kasfjh";
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
