# Easy PureScript Nix, NixOS Ready™

A project for using PureScript and related tooling easily with Nix. Note that the `purescript` derivation used in nixpkgs is a derivative of the derivatifrom this project, so if you do not care about which version of PureScript you want to use, you can simply use it from there.

## Example usage

See [ci.nix](./ci.nix) in this repo for example `nix-shell` usage.

## Potential questions

### How do I install to my system from here?

Behold:

```
> nix-env -f default.nix -iA purs
# or nix-env -if purs.nix

> which purs
/home/justin/.nix-profile/bin/purs
> purs --version
0.13.2
```

Or by `shell.nix`:

```nix
{ pkgs ? import <nixpkgs> { } }:
let
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "0ba91d9aa9f7421f6bfe4895677159a8a999bf20";
      sha256 = "1baq7mmd3vjas87f0gzlq83n2l1h3dlqajjqr7fgaazpa9xgzs7q";
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
