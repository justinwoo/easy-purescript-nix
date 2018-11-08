{ pkgs ? import <nixpkgs> {} }:

let dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
in pkgs.stdenv.mkDerivation rec {
  name = "psc-package-simple";
  version = "v0.4.2";

  src = pkgs.fetchurl {
    url = "https://github.com/purescript/psc-package/releases/download/${version}/linux64.tar.gz";
    sha256 = "0h8jkxqxi44vrzwl1c5zddxjxqbzkwgmn2m7gxlgs019xlsmml4w";
  };

  buildInputs = [ pkgs.gmp ];
  libPath = pkgs.lib.makeLibraryPath buildInputs;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T psc-package $out/bin/psc-package
    chmod u+w $out/bin/psc-package
    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $out/bin/psc-package
    chmod u-w $out/bin/psc-package
  '';
}
