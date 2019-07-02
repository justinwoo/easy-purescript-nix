# Easy PureScript Nix, NixOS Ready™

[![Build Status](https://travis-ci.com/justinwoo/easy-purescript-nix.svg?branch=master)](https://travis-ci.com/justinwoo/easy-purescript-nix)

Improvements welcomed, following two rules:

Rules:

1. Binary downloads, no rebuilding
2. Should be easy to pull it from remote (could be improved, see [remote-test.nix](./remote-test.nix))

See the blog post about this here: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2018-10-24-using-purescript-easily-with-nix.md>

Raison d'etre: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2019-04-29-why-easy-purescript-nix.md>

## Breaking change Jul 02 2019

The default derivation is now a function that will take `pkgs` as an argument. By default, it will use nixpkgs as before.

You can update your usage of this derivation by simply applying an empty set `{}` to the imported function.

E.g.

```nix
  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "7d072cef5ad9dc33a9a9f1b7fcf8ff083ff484b3";
    sha256 = "0974wrnp8rnmj1wzaxwlmk5mf1vxdbrvjc1h8jgm9j5686qn0mna";
  }) {
    inherit pkgs;
  };
```

## Example usage

This repository uses Easy-PureScript-Nix for its setup:

<https://github.com/justinwoo/vidtracker>

## Warning

Thanks to Pekka (@kaitanie), we have things working on NixOS. So report issues if things are broken!

*I (Justin) do not use NixOS, so these builds may require extra patching for consumption from NixOS.*

## Potential questions

### Can I see an example of this at work?

As usual, my vidtracker also has lots of usages: <https://github.com/justinwoo/vidtracker/tree/f78b3df57eaf5b122f0a0b51cc4e3c246bf96f88>

### Porco zio, I love this. How do I install to my system from here?

Behold:

```
> nix-env -f default.nix -iA purs
replacing old 'purs-simple'
installing 'purs-simple'
building '/nix/store/aqiwls5papn9j1hy4gsziywj92m5f632-user-environment.drv'...
created 2259 symlinks in user environment

> which purs
/home/justin/.nix-profile/bin/purs
> purs --version
0.12.5
```

Or in your dotfiles instead:

```nix
let
  pkgs = import <nixpkgs> {};

  easyPS = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "bad807ade1314420a52c589dbc3d64d3c9b38480";
    sha256 = "099dpxrpch8cgy310svrpdcad2y1qdl6l782mjpcgn3rqgj62vsf";
  });
in {
  inherit(easyPS.inputs)
   purs
   psc-package-simple
   purp
   ;
}
```

etc.
