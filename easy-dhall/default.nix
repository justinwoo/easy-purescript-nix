{ pkgs ? import <nixpkgs> {} }:

let
  revData = builtins.fromJSON (builtins.readFile ./revision.json);
  owner   = builtins.elemAt (builtins.match "https?://.*/(.*)/.*" revData.url) 0;
  repo    = builtins.elemAt (builtins.match "https?://.*/.*/(.*)" revData.url) 0;

  src = pkgs.fetchFromGitHub {
    inherit owner repo;
    inherit (revData) rev sha256;
  };
in
  import src { inherit pkgs; }
