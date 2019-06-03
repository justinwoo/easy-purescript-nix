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

  version = "0.8.3.0";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.8.3.0/osx.tar.gz";
      sha256 = "1dyrgzhc20sjwiq74dv7ca7nxhwnwzz4b8r1p5zayd2hg4qqs1cg";
    }
    else pkgs.fetchurl {
      url = "https://github.com/spacchetti/spago/releases/download/0.8.3.0/linux.tar.gz";
      sha256 = "1mp24ygf4sj8hpz343q0121xl0l5a6azsrm0dn90pdi2wmrn3kyk";
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
