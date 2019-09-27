{ pkgs, nodeEnv, purs }:
let
  src = builtins.fetchTarball {
    url = "https://registry.npmjs.org/pscid/-/pscid-2.8.3.tgz";
    sha256 = "0ck3h78gn2bs990jya3zw0a265yn4fb8hdyfv6g3gmx121rifxx6";
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
    version = "2.6.0";
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
