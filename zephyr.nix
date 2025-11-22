{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "zephyr";

  version = "0.5.2";

  src =
    if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then
      (pkgs.fetchurl {
        url = "https://github.com/MaybeJustJames/zephyr/releases/download/v${version}/Linux.tar.gz";
        sha256 = "15gfifqxxzr3slgk5a3bwjq5zfxm0gabknzqhl72x69rl959lwwh";
      })
    else if pkgs.stdenv.hostPlatform.system == "x86_64-darwin" then
      (pkgs.fetchurl {
        url = "https://github.com/MaybeJustJames/zephyr/releases/download/v${version}/macOS.tar.gz";
        sha256 = "06y82s2r5w8gryr6r2a4cwqwk01lrqgcv1x6qzxijh0ssfv42z1x";
      })
    else if pkgs.stdenv.hostPlatform.system == "aarch64-darwin" then
      (pkgs.fetchurl {
        url = "https://github.com/MaybeJustJames/zephyr/releases/download/v${version}/macOS.tar.gz";
        sha256 = "06y82s2r5w8gryr6r2a4cwqwk01lrqgcv1x6qzxijh0ssfv42z1x";
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
