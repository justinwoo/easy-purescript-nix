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
  pname = "spago";

  version = "0.18.1";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/spago/releases/download/${version}/macOS.tar.gz";
    sha256 = "0bzswl0lz64lahxjrb0mwr7ykv4g181mivhvp5y2pggmczbrm2yh";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/spago/releases/download/${version}/Linux.tar.gz";
    sha256 = "10c9njn3lp37wj1jyzqpyjjksrxipidkpjmbb90x68q0wzf688c7";
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
