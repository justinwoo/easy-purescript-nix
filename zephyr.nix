{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "zephyr";

  version = "0.5.0";

  src =
    if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then
      (pkgs.fetchurl {
        url = "https://github.com/MaybeJustJames/zephyr/releases/download/v${version}/Linux.tar.gz";
        sha256 = "1c44nddlx7hx097klfslhap717fkah20vgf1phsp0gj8imjyvr0h";
      })
    else if pkgs.stdenv.hostPlatform.system == "x86_64-darwin" then
      (pkgs.fetchurl {
        url = "https://github.com/MaybeJustJames/zephyr/releases/download/v${version}/macOS.tar.gz";
        sha256 = "1qpd0mwnvkxygby467cr0zwcrpwnv9f0s99g7w8hfz0zfcg358bg";
      })
    else
      throw "Architecture not supported";

  nativeBuildInputs = [ ]
    ++ pkgs.lib.optional pkgs.stdenv.isDarwin pkgs.fixDarwinDylibNames;

  buildInputs = [
    pkgs.stdenv.cc.cc.lib
    pkgs.gmp
    pkgs.zlib
    pkgs.ncurses6
  ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src --strip 1 -C $out

    ZEPHYR=$out/bin/zephyr
    install -D -m555 -T $out/zephyr $ZEPHYR

    chmod u+w $ZEPHYR
  '' + pkgs.lib.optionalString (!pkgs.stdenv.isDarwin) ''
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $ZEPHYR
  '' + ''
    chmod u-w $ZEPHYR

    mkdir -p $out/etc/bash_completion.d/
    $ZEPHYR --bash-completion-script $ZEPHYR > $out/etc/bash_completion.d/zephyr-completion.bash
  '';

  dontInstall = true;
}
