{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  patchelf = libPath: if pkgs.stdenv.isDarwin
  then ""
  else ''
    chmod u+w $PURTY
    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PURTY
    chmod u-w $PURTY
  '';

in
pkgs.stdenv.mkDerivation rec {
  name = "purty";

  version = "4.5.1";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-4.5.1-osx.tar.gz";
    sha256 = "1nl86ajix0kzz7l6my1nj22zra4pcz7mp6kb730p2a9jxdk37f12";
  }
  else pkgs.fetchurl {
    url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-4.5.1-linux.tar.gz";
    sha256 = "050m7wnaz7d20amsprps02j65qywa4r0n873f444g6db9alvazrv";
  };

  buildInputs = [ pkgs.zlib pkgs.gmp pkgs.ncurses5 ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
    tar xf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    PURTY="$out/bin/purty"

    install -D -m555 -T purty $PURTY
    ${patchelf libPath}

    mkdir -p $out/etc/bash_completion.d/
    $PURTY --bash-completion-script $PURTY > $out/etc/bash_completion.d/purty-completion.bash
  '';
}
