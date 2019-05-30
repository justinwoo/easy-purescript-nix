{ pkgs, purs }:

let
  src = import ./src.nix { inherit pkgs; };

  package = (import ./generated/node2nix-default.nix { inherit pkgs; }).package;

  bowerComponents = pkgs.buildBowerComponents {
    name = "pscid";
    generated = ./generated/bower2nix-bower-components.nix;
    inherit src;
  };
in

package.overrideAttrs (oldAttrs: rec {
  inherit src bowerComponents;

  buildInputs = oldAttrs.buildInputs ++ [ purs ];

  fixupPhase = ''
    cp --reflink=auto --no-preserve=mode -R $bowerComponents/bower_components .

    npm run build
  '';
})
