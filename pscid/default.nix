{
  pkgs ? import <nixpkgs> { inherit system; },
  system ? builtins.currentSystem,
  nodejs ? pkgs."nodejs-10_x",
  purs
}:

let
  src = import ./src.nix { inherit pkgs; };

  nodeEnv = import ./generated/node2nix-node-env.nix {
    inherit (pkgs) stdenv python2 utillinux runCommand writeTextFile;
    inherit nodejs;
    libtool = if pkgs.stdenv.isDarwin then pkgs.darwin.cctools else null;
  };

  node2nix-output = import ./generated/node2nix-node-modules.nix {
    inherit (pkgs) fetchurl fetchgit;
    inherit nodeEnv;
  };

  args = node2nix-output.args;

  package = nodeEnv.buildNodePackage (args // { inherit src; });

  bowerComponents = pkgs.buildBowerComponents {
    name = "pscid";
    generated = ./generated/bower2nix-bower-components.nix;
    inherit src;
  };
in

package.overrideAttrs (oldAttrs: rec {
  inherit bowerComponents;

  buildInputs = oldAttrs.buildInputs ++ [ purs ];

  fixupPhase = ''
    cp --reflink=auto --no-preserve=mode -R $bowerComponents/bower_components .

    npm run build
  '';
})
