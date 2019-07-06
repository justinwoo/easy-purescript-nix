# Easy PureScript Nix, NixOS Ready™

[![Build Status](https://travis-ci.com/justinwoo/easy-purescript-nix.svg?branch=master)](https://travis-ci.com/justinwoo/easy-purescript-nix)

A project for using PureScript and related tooling easily with Nix.

## Example usage

See [ci.nix](./ci.nix) in this repo for example `nix-shell` usage.

This repository uses Easy-PureScript-Nix for its setup: <https://github.com/justinwoo/vidtracker>

## Potential questions

### Can I see an example of this at work?

As usual, my vidtracker also has lots of usages: <https://github.com/justinwoo/vidtracker/tree/f78b3df57eaf5b122f0a0b51cc4e3c246bf96f88>

### Porco zio, I love this. How do I install to my system from here?

Behold:

```
> nix-env -f default.nix -iA purs
# or nix-env -if purs.nix

> which purs
/home/justin/.nix-profile/bin/purs
> purs --version
0.13.2
```

Or in your own Nix expressions instead:

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  easyPS = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "<some-rev-here>";
    sha256 = "<some-sha-here>";
  });
in {
  inherit (easyPS)
    purs
    spago;
}
```

etc.

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


## Why was this made?

See the blog post about this here: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2018-10-24-using-purescript-easily-with-nix.md>

Raison d'etre: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2019-04-29-why-easy-purescript-nix.md>

## Credits

Thanks to Pekka (@kaitanie) for making this work on NixOS.
