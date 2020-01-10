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
    sha256 = "611f73d90196e1b97ce0616685389a2d4a698b340772f8253635c605fec6131a";
  }
  else pkgs.fetchurl {
    url = "https://github.com/spacchetti/spago/releases/download/0.13.1/linux.tar.gz";
    sha256 = "85c25d8c5bfd6ca45298ea66c50bab05020885caf0b920ac5c9524d23c984c68";
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
