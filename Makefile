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
	which dhall-to-json

	which spacchetti
	spacchetti version
