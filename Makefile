default:
	nix-shell ci.nix --run 'make test'
test:
	which purs
	purs --version

	which psc-package
	psc-package --version

	which purp
	purp

	which dhall
	dhall version

	which dhall-to-json
	dhall-to-json --version

	which spago
	spago version

	which zephyr
	zephyr --version

	which psc-package2nix
	which pp2n
	pp2n

	which spago2nix
	spago2nix

	which pscid
	pscid --help

	which purty
	purty --help
