{ pkgs ? import <nixpkgs> {} }:
  pkgs.stdenv.mkDerivation rec {
    pname = "purty";
    version = "7.0.0";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/purty/-/purty-${version}.tgz";
      sha256 = "1h9z43aj1gflysy0379j7cpdvszjlk9lvg861hgk7dmqq59qzd4y";
    };

    binPath = if pkgs.stdenv.isDarwin
      then
        "package/bin/osx/purty"
      else
        "package/bin/linux/purty";

    buildInputs = [ pkgs.zlib pkgs.gmp pkgs.ncurses5 ];

    libPath = pkgs.lib.makeLibraryPath buildInputs;

    dontStrip = true;

    unpackPhase = ''
      tar xf $src
    '';

    installPhase = ''
      mkdir -p $out/bin
      PURTY="$out/bin/purty"
      install -D -m555 -T $binPath $PURTY
      mkdir -p $out/etc/bash_completion.d/
      $PURTY --bash-completion-script $PURTY > $out/etc/bash_completion.d/purty-completion.bash
    '';
}
