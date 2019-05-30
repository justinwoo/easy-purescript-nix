{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  patchelf = libPath: if pkgs.stdenv.isDarwin
    then ""
    else ''
          chmod u+w $PURS
          patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PURS
          chmod u-w $PURS
        '';

in pkgs.stdenv.mkDerivation rec {
  name = "purs-simple";

  version = "v0.13.0";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.0/macos.tar.gz";
      sha256 = "0xpisy38gj6fgyyzm6fdl0v819dhjmil4634xxangvhvs7jf5il0";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.13.0/linux64.tar.gz";
      sha256 = "06g5q69yv6c3alq9vr8zjqqzamlii7xf6vj9j52akjq5lww214ba";
    };

  buildInputs = [ pkgs.zlib pkgs.gmp pkgs.ncurses5 ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    PURS="$out/bin/purs"

    install -D -m555 -T purs $PURS
    ${patchelf libPath}

    mkdir -p $out/etc/bash_completion.d/
    $PURS --bash-completion-script $PURS > $out/etc/bash_completion.d/purs-completion.bash
  '';
}
