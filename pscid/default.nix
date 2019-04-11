{ pkgs, nodeEnv, purs }:
let
  src = pkgs.fetchFromGitHub {
    owner = "kRITZCREEK";
    repo = "pscid";
    rev = "6bf65c5368fd997d980b7528f6fe39bd92fcc07a";
    sha256 = "0s0s065gi859n9fbvwm0v2p73vqd99vcax9zfhg9ip00k7aswn36";
  };

  # Generated with node2nix
  # https://github.com/svanderburg/node2nix
  # (node2nix --lock package-lock.json --nodejs-10)
  nodeModules = import ./node-modules.nix {
    inherit (pkgs) fetchurl fetchgit;
  };

  # Generated with bower2nix
  # https://github.com/rvl/bower2nix
  bowerComponents = pkgs.buildBowerComponents {
    name = "pscid";
    generated = ./bower-components.nix;
    inherit src;
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
nodeEnv.buildNodePackage (args // {
  inherit src bowerComponents;

  fixupPhase = ''
    cp --reflink=auto --no-preserve=mode -R $bowerComponents/bower_components .
    npm run build
  '';
})
