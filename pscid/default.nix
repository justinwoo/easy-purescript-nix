{ pkgs, nodeEnv, purs }:
let
  src = builtins.fetchTarball {
    url = "https://github.com/kritzcreek/pscid/archive/338d7ef7c38b6928713aaef9304da6ff09247fc2.tar.gz";
    sha256 = "1j11fll3qs4sxk1sc86vd8vmxqp9sz3qpynmr1xs9r8lsyp30jb7";
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
