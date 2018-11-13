{ pkgs ? import <nixpkgs> {} }:

let dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
in pkgs.stdenv.mkDerivation rec {
  name = "purs-simple";
  version = "v0.12.1";

  src = pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/${version}/linux64.tar.gz";
    sha256 = "01az5127g7jpznsjvpkrl59i922fc5i219qdvsrimzimrv08mr18";
  };

  buildInputs = [ pkgs.zlib
                  pkgs.gmp
                  pkgs.ncurses5];
  libPath = pkgs.lib.makeLibraryPath buildInputs;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T purs $out/bin/purs
    chmod u+w $out/bin/purs
    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $out/bin/purs
    chmod u-w $out/bin/purs
  '';
}
