default:
	nix-shell --run 'make test'
test:
	which purs
	purs --version

	which psc-package
	psc-package --version

	which purp
	purp version

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
