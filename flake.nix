{
  description = "Easy PureScript Nix";

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
                  psa
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
                printf "%-25s" "  purs $(purs --version)"
                printf "%-25s" "  $(pulp --version | head -1)"
                printf "%-25s" "  psc-package $(psc-package --version)"
                echo ""
                printf "%-25s" "  spago $(spago --version)"
                printf "%-25s" "  psa $(psa --version)"
                printf "%-25s" "  pscid $(pscid --version)"
                echo ""
                printf "%-25s" "  purs-tidy $(purs-tidy --version)"
                printf "%-25s" "  purs-backend-es $(purs-backend-es --version 2>&1)"
                printf "%-25s" "  $(purty version)"
                echo ""
                printf "%-25s" "  node $(node --version)"
                printf "%-25s" "  esbuild $(esbuild --version)"
                printf "%-25s" "  zephyr $(zephyr --version)"
                echo ""
                printf "%-25s" "  bower $(bower --version)"
                printf "%-50s" "  purescript-language-server $(purescript-language-server --version)"
                echo ""
                '';
              };
           };
         }
      );
}

