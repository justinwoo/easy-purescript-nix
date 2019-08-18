default:
	nix-shell ci.nix --run 'make test'
test:
	which purs
	purs --version

	which purp
	purp

	which dhall
	dhall version

	which dhall-to-json
	dhall-to-json --version

	which spago
	spago version

	which spago2nix
	spago2nix

	which pscid
	pscid --help

	which purty
	purty --help
