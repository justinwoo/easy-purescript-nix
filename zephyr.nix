{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "zephyr";

  version = "0.3.2";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/coot/zephyr/releases/download/v${version}/macOS.tar.gz";
    sha256 = "1zj2fq664akqfmczmcshg9bxlrsa2gj082bp92nkygsq6v677jk4";
  }
  else pkgs.fetchurl {
    url = "https://github.com/coot/zephyr/releases/download/v${version}/Linux.tar.gz";
    sha256 = "106qp9k1lnbxl7pich4i7bqj9gw8v895i3gp58dgcibgz4q8hymw";
  };

  nativeBuildInputs = []
    ++ pkgs.lib.optional pkgs.stdenv.isDarwin pkgs.fixDarwinDylibNames;

  buildInputs = [ pkgs.gmp pkgs.zlib pkgs.ncurses5 ];

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
