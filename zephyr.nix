{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "zephyr";

  version = "v0.2.1";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/coot/zephyr/releases/download/v0.2.1/macos.tar.gz";
      sha256 = "0zwdsrs7r6ff534wrar32lk39fjai1jj4dxz4bjh3yhw63lvdqfn";
    }
    else pkgs.fetchurl {
      url = "https://github.com/coot/zephyr/releases/download/v0.2.1/linux64.tar.gz";
      sha256 = "0afcnpqabjs4b60grkcvz2hb3glpjhlnvqvpgc0zsdwaqnmcrrnk";
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
  '' +
  ''
    chmod u-w $ZEPHYR

    mkdir -p $out/etc/bash_completion.d/
    $ZEPHYR --bash-completion-script $ZEPHYR > $out/etc/bash_completion.d/zephyr-completion.bash
  '';

  dontInstall = true;
}
