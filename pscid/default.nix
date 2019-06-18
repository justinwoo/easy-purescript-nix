{ pkgs, nodeEnv, purs }:
let
  src = pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "pscid";
    rev = "a4b698f877a73cbc3a552f4d67a8a77e280509f5";
    sha256 = "1xjs2q23x16h6zxkl6lwh2z8z88cwwnnbayymqmi347ki8g6hjmj";
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
