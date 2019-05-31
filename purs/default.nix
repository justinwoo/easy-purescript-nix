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

  revisions = builtins.fromJSON (builtins.readFile ./revision.json);
in pkgs.stdenv.mkDerivation rec {
  name = "purs-simple";

  version = revisions.version;

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl { inherit (revisions.mac) url sha256; }
    else pkgs.fetchurl { inherit (revisions.linux) url sha256; };

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
