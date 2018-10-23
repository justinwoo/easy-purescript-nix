# Easy PureScript Nix, First Draft

Improvements welcomed, following two rules:

Rules:

1. Binary downloads, no rebuilding
2. Should be easy to pull it from remote (could be improved, see [remote-test.nix](./remote-test.nix))

See the blog post about this here: https://qiita.com/kimagure/items/de2a4ff45dd8fe8be4b1

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
    rev = "84723cd";
    sha256 = "1vid6djm64c4whyxsnpxr4s1j7x9fkiv456h3hxagq6z4jsrar71";
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
