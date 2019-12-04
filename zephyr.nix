{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "zephyr";

  version = "0.2.2";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/coot/zephyr/releases/download/v0.2.2/x86_64-osx.tar.gz";
    sha256 = "1fslg0h5dzrah1rkjvz9gw2s2kksmdfdkpz7a7z1akn8s6nqnd93";
  }
  else pkgs.fetchurl {
    url = "https://github.com/coot/zephyr/releases/download/v0.2.2/x86_64-linux.tar.gz";
    sha256 = "0kgvrd6i1yj5n09ar82q27wgq6n5x9x6iy93nx1yqvk87kcmbji6";
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
