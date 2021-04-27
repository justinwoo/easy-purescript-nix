{ inputs =
    { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      utils.url = "github:ursi/flake-utils/1";
    };

  outputs = { nixpkgs, utils, ... }:
    utils.default-systems
      ({ pkgs, ... }: { packages = (import ./. { inherit pkgs; }).inputs; })
      { inherit nixpkgs; };
}
