{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "purty";

  version = "7.0.0";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-7.0.0-osx.tar.gz";
    sha256 = "0ci72ijx6m43fy61cwkkyxp4prxhwrrnbh5myr3sva97cqvm6bj8";
  }
  else pkgs.fetchurl {
    url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-7.0.0-linux.tar.gz";
    sha256 = "17fzdfiws4wmhbj2q5mf5cadbsnp7ag2bf12y3awfvvmajh5ddjh";
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

    mkdir -p $out/etc/bash_completion.d/
    $PURTY --bash-completion-script $PURTY > $out/etc/bash_completion.d/purty-completion.bash
  '';
}
