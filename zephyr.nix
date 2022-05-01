{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "zephyr";

  version = "0.4.0";

  src =
    if pkgs.stdenv.isDarwin then
      pkgs.fetchurl
        {
          url = "https://github.com/MaybeJustJames/zephyr/releases/download/v${version}/macOS.tar.gz";
          sha256 = "1di4zk75pw0g2hk2zq61v7msvq2ibd9wxnk21nz26fxqw09gxacd";
        }
    else
      pkgs.fetchurl {
        url = "https://github.com/MaybeJustJames/zephyr/releases/download/v${version}/Linux.tar.gz";
        sha256 = "002rlf9s81il5x3adv7qhj0wxbnvv348l5rcllkrbivk008bb83x";
      };

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
