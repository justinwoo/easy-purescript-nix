{ pkgs, nodeEnv, purs }:
let
  src = pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "pscid";
    rev = "8e80848a04d72da69ff20cacda302ee742ba19d4";
    sha256 = "017b4n8n2v6chlb00v11xgadprbqxhxyhkxnh49xig2r9k7x0vbv";
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
