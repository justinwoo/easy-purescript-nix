{
  description = " Easy PureScript Nix";

  nixConfig = { # https://github.com/NixOS/nix/pull/4189
    allow-import-from-derivation = "true"; # TODO doesn't work? https://github.com/hasktorch/hasktorch/blob/7b63d730964a44a6bcdd853cd5b140a24e210298/flake.nix#L16
  };

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          # TODO pinned.nix could be a flake input.nixpkgs instead.
          pkgs = import ./pinned.nix { inherit system; };
          packages = (import ./default.nix { inherit pkgs; }).inputs;
        in
         {
           inherit packages;
           devShells = {
              deluxe = pkgs.mkShell {
                name = "easy-purescript-nix-shell-deluxe";
                buildInputs = with packages; [
                  purs
                  pulp
                  psc-package
                  purp
                  spago
                  spago2nix
                  pscid
                  purescript-language-server
                  purs-tidy
                  purty
                  zephyr
                  purs-backend-es
                  pkgs.nodejs-18_x
                  pkgs.nodePackages.bower
                  pkgs.esbuild
                  pkgs.dhall
                ];
              shellHook = ''
                source <(spago --bash-completion-script `which spago`)
                source <(node --completion-bash)
                echo -e "  \033[1measy-purescript-nix deluxe development environment\033[0m"
                echo -e "  \033[1mSee https://discourse.purescript.org/t/recommended-tooling-for-purescript-in-2022\033[0m"
                '';
              };
           };
         }
      );
}

