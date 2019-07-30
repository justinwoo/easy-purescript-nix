{ pkgs ? import <nixpkgs> {} }:

let
  patchelf = libPath: if pkgs.stdenv.isDarwin
    then ""
    else ''
          chmod u+w $SPAGO
          patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath ${libPath} $SPAGO
          chmod u-w $SPAGO
        '';

in pkgs.stdenv.mkDerivation rec {
  name = "spago";

  version = "0.9.0.0";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.9.0.0/osx.tar.gz";
      sha256 = "13xj8g20f2p2cqcqairvpj9gk6im629pqz2cdbay1s850swafaaa";
    }
    else pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.9.0.0/linux.tar.gz";
      sha256 = "0r3kld26badkj9wkqyai9p9irzjpzjdwf40bcgw4qjbvkw5f8fg9";
    };

  buildInputs = [ pkgs.gmp pkgs.zlib pkgs.ncurses5 pkgs.stdenv.cc.cc.lib ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
      mkdir -p $out/bin
      tar xf $src -C $out/bin

      SPAGO=$out/bin/spago
      ${patchelf libPath}


      mkdir -p $out/etc/bash_completion.d/
      $SPAGO --bash-completion-script $SPAGO > $out/etc/bash_completion.d/spago-completion.bash
    '';

  dontInstall = true;
}
