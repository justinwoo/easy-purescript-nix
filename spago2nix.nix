{ pkgs ? import <nixpkgs> { }
, nodejs ? pkgs."nodejs-14_x"
}:

import
  (
    pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "spago2nix";
      rev = "da4a833b53f9139e596f89ad89d892f4f60fc179";
      sha256 = "sha256-oTBdCpCJmuMQ6nYR1+tamL9xDPm720dRVxsKtKOzTfs=";
    }
  )
{
  inherit pkgs nodejs;
}
