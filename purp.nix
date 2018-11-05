{ pkgs ? import <nixpkgs> {} }:

let dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
in pkgs.stdenv.mkDerivation rec {
  name = "purp";
  version = "0.3.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/justinwoo/purp/releases/download/${version}/linux.tar.gz";
    sha256 = "0sz9mc5rdj59kxq370dffd2k4zamgxj8m3hr8d8kmzzrmpp4qk66";
  };

  buildInputs = [ pkgs.gmp ];
  libPath = pkgs.lib.makeLibraryPath buildInputs;
  dontStrip = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src -C $out/bin
    chmod u+w $out/bin/purp
    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $out/bin/purp
    chmod u-w $out/bin/purp
  '';

  dontInstall = true;
}
