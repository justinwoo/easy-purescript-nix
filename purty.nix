{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "purty";

  version = "6.2.0";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-6.2.0-osx.tar.gz";
    sha256 = "1d81xkhwnkgkdxc91d0knqixbhm5wgkc173m9kzlqzyhvpg90d64";
  }
  else pkgs.fetchurl {
    url = "https://bintray.com/joneshf/generic/download_file?file_path=purty-6.2.0-linux.tar.gz";
    sha256 = "1p6yy8qd7iwm6qw2zmv2m0ikm00xfj302q9arigxgh5kzsmrzg5i";
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
