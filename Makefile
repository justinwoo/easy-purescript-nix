default:
	nix-shell --run 'make test'
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

	which spacchetti
	spacchetti version

	which spago
	spago version

	which zephyr
	zephyr --version

	which psc-package2nix
	which pp2n
	pp2n
