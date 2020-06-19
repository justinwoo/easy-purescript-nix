{ pkgs, nodeEnv, purs }:
let
  src = builtins.fetchTarball {
    url = "https://registry.npmjs.org/pscid/-/pscid-2.9.2.tgz";
    sha256 = "0gdjh16v25grqwlg9g60yigq5q6m0gqbkh8vgpyjrb3xnarr2smp";
  };

  # Generated with node2nix
  # https://github.com/svanderburg/node2nix
  # (node2nix --lock package-lock.json --nodejs-10)
  nodeModules = import ./node-modules.nix {
    inherit (pkgs) fetchurl fetchgit;
  };

  args = {
    name = "pscid";
    packageName = "pscid";
    version = "2.9.2";
    inherit src;
    meta = {
      description = "A lightweight editor experience for PureScript development";
      license = "LGPL-3.0";
    };
    production = true;
    bypassCache = true;
    dependencies = nodeModules;
    buildInputs = [ purs ];
  };
in
nodeEnv.buildNodePackage args
