# Easy PureScript Nix

A project for using PureScript and related tooling easily with Nix. Note that the `purescript` derivation used in nixpkgs is a derivative of the derivation from this project. See `default.nix` for more information on available versions.

## Example usage

See [ci.nix](./ci.nix) in this repo for a Nix expression example to be used with `nix-shell`.

```text
$ nix-shell ./ci.nix
```

Or simply clone this repo, `cd` into it, and type `nix-shell` (which implicitly calls [`shell.nix`](./shell.nix)).

## Potential questions

### How do I use this? (How do I use derivations in Nix?)

I have written about how to use parts of Nix here: <https://github.com/justinwoo/nix-shorts>

### How do I install to my system from here?

Behold:

```
> nix-env -f default.nix -iA purs
# or nix-env -if purs.nix

> which purs
/home/justin/.nix-profile/bin/purs
> purs --version
0.13.8
```

Or by `shell.nix`:

```nix
{ pkgs ? import <nixpkgs> { } }:
let
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "a5fd0328827ac46954db08f624c09eba981f1ab2";
      sha256 = "1g3bk2y8hz0y998yixz3jmvh553kjpj2k7j0xrp4al1jrbdcmgjq";
    }) {
    inherit pkgs;
  };
in
pkgs.mkShell {
  buildInputs = [
    easy-ps.purs-0_13_8
    easy-ps.psc-package
  ];
}
```

## Why was this made?

See the blog post about this here: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2018-10-24-using-purescript-easily-with-nix.md>

Raison d'etre: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2019-04-29-why-easy-purescript-nix.md>

## Credits

Thanks to Pekka (@kaitanie) for making this work on NixOS.
