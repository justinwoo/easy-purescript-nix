{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "zephyr";

  version = "0.3.1";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/coot/zephyr/releases/download/v0.3.1/macOS.tar.gz";
    sha256 = "099w90fhiffkm329x8jckv568sd8y72kdrym8fzm392bp2yinjg1";
  }
  else pkgs.fetchurl {
    url = "https://github.com/coot/zephyr/releases/download/v0.3.1/Linux.tar.gz";
    sha256 = "0c1zpv561sfpi06vvbqq80nflraf68ab0akj9rymyaqpa6988mf3";
  };

  buildInputs = [ pkgs.gmp pkgs.zlib pkgs.ncurses5 ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar xf $src --strip 1 -C $out

    ZEPHYR=$out/bin/zephyr
    install -D -m555 -T $out/zephyr $ZEPHYR

    chmod u+w $ZEPHYR
  '' + pkgs.stdenv.lib.optionalString pkgs.stdenv.isDarwin ''
    install_name_tool \
      -change /usr/lib/libSystem.B.dylib ${pkgs.darwin.Libsystem}/lib/libSystem.B.dylib \
      -change /usr/lib/libz.1.dylib ${pkgs.zlib}/lib/libz.1.dylib \
      -change /usr/lib/libiconv.2.dylib ${pkgs.libiconv}/libiconv.2.dylib \
      $ZEPHYR
  '' + pkgs.stdenv.lib.optionalString (!pkgs.stdenv.isDarwin) ''
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $ZEPHYR
  '' + ''
    chmod u-w $ZEPHYR

    mkdir -p $out/etc/bash_completion.d/
    $ZEPHYR --bash-completion-script $ZEPHYR > $out/etc/bash_completion.d/zephyr-completion.bash
  '';

  dontInstall = true;
}
