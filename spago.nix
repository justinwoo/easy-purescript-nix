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

  version = "0.20.5";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/purescript/spago/releases/download/${version}/macOS.tar.gz";
    sha256 = "0yg4nbnngjfzihy86m5qcvi4zmpyfd4x8260x5jq7pb376bblan2";
  }
  else pkgs.fetchurl {
    url = "https://github.com/purescript/spago/releases/download/${version}/Linux.tar.gz";
    sha256 = "1k1c22qv3g30f5awggdjiwxi7aifssfmcvnpjk391cssihj9k2y0";
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
