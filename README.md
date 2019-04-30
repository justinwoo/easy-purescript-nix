# Easy PureScript Nix, NixOS Ready™

[![Build Status](https://travis-ci.com/justinwoo/easy-purescript-nix.svg?branch=master)](https://travis-ci.com/justinwoo/easy-purescript-nix)

Improvements welcomed, following two rules:

Rules:

1. Binary downloads, no rebuilding
2. Should be easy to pull it from remote (could be improved, see [remote-test.nix](./remote-test.nix))

See the blog post about this here: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2018-10-24-using-purescript-easily-with-nix.md>

Raison d'etre: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2019-04-29-why-easy-purescript-nix.md>

## Example usage

This repository uses Easy-PureScript-Nix for its setup:

<https://github.com/justinwoo/spacchetti-react-basic-starter>

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
    rev = "993f63359b64db080061b274e4688e3b80c4f68e";
    sha256 = "18b7fmmxkg38y1av9kfgcv2rikdlji51ya5b9p7sy3aml2hprmi5";
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
