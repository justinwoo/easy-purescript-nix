{ pkgs ? import <nixpkgs> { }
, nodejs ? pkgs."nodejs-18_x"
}:

import
  (
    pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "spago2nix";
      rev = "1b8ec352bc7eac077b934d6b9f6efa0129926e59";
      sha256 = "sha256-h9r67pmvDuA3TV9299L4CN60XSm8RRtX1EwUoKu9Pyw=";
    }
  )
{
  inherit pkgs nodejs;
}
