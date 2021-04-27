{ inputs.utils.url = "github:numtide/flake-utils";

  outputs = { utils, ... }:
    utils.lib.eachDefaultSystem
      (system:
         { packages =
             (import ./.  { pkgs = import ./pinned.nix { inherit system; }; }).inputs;
         }
      );
}
