{ pkgs ? import <nixpkgs> {} }:

let
  revisions = builtins.fromJSON (builtins.readFile ./revision.json);
in pkgs.stdenv.mkDerivation rec {
  name = "zephyr";

  version = revisions.version;

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl { inherit (revisions.mac) url sha256; }
    else pkgs.fetchurl { inherit (revisions.linux) url sha256; };

  buildInputs = [ pkgs.gmp pkgs.zlib pkgs.ncurses5 ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src --strip 1 -C $out

    ZEPHYR=$out/bin/zephyr
    install -D -m555 -T $out/zephyr $ZEPHYR

    chmod u+w $ZEPHYR
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $ZEPHYR
    chmod u-w $ZEPHYR

    mkdir -p $out/etc/bash_completion.d/
    $ZEPHYR --bash-completion-script $ZEPHYR > $out/etc/bash_completion.d/zephyr-completion.bash
  '';

  dontInstall = true;
}
