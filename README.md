# Easy PureScript Nix, First Draft

Improvements welcomed, following two rules:

Rules:

1. Binary downloads, no rebuilding
2. Should be easy to pull it from remote (could be improved, see [remote-test.nix](./remote-test.nix))

## Potential questions

### Porco zio, I love this. How do I install to my system from here?

Behold:

```
> nix-env -f ~/Code/easy-purescript-nix/default.nix -iA inputs.dhall-simple
replacing old 'dhall-simple'
installing 'dhall-simple'
building '/nix/store/n2q4i6c28vhh6ff302k606lg7abbh998-user-environment.drv'...
created 504 symlinks in user environment

> which dhall
/home/justin/.nix-profile/bin/dhall

> dhall version
1.18.0
```

Or in your dotfiles instead:

```
let
  pkgs = import <nixpkgs> {};

  easyPS = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "3c61e4e";
    sha256 = "0182jpx1yvn1570vd9lv92y0rbhyszhjrbg5y4g42rzy5nnyxx4c";
  });
in {
  inherit(easyPS.inputs)
   purs
   psc-package-simple
   purp
   ;
}
```

### Why not upstream `purp` and `spacchetti-cli` to nixpkgs?

Surely someone else will make a PR if they want it, but I am unlikely to use any nixpkgs version currently.
