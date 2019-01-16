{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
  platform =
    if pkgs.stdenv.isDarwin
      then "macos"
      else "linux64";

  sha256 =
    if pkgs.stdenv.isDarwin
      then "1bll735777098anx30rgw1yyk8mjxyj729laimbdzkp64ckzzsiv"
      else "0wzsl3yqz9gmsi77a7m73y5g8g8k7hnmd3i2f0gf2k8wx32ak43a";

  patchelf = libPath :
    if pkgs.stdenv.isDarwin
      then ""
      else
        ''
          chmod u+w $PURS
          patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PURS
          chmod u-w $PURS
        '';

in pkgs.stdenv.mkDerivation rec {
  name = "purs-simple";
  version = "v0.12.2";

  src = pkgs.fetchurl {
    url = "https://github.com/purescript/purescript/releases/download/${version}/${platform}.tar.gz";
    sha256 = sha256;
  };


  buildInputs = [ pkgs.zlib
                  pkgs.gmp
                  pkgs.ncurses5];
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
