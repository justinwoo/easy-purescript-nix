# Easy PureScript Nix

A project for using PureScript and related tooling easily with Nix. Note that the `purescript` derivation used in nixpkgs is a derivative of the derivation from this project. See `default.nix` for more information on available versions.

## Example usage

See [ci.nix](./ci.nix) in this repo for a Nix expression example to be used with `nix-shell`.

```console
$ nix-shell ./ci.nix
```

Or simply clone this repo, `cd` into it, and type `nix-shell` (which implicitly calls [`shell.nix`](./shell.nix)).

## Potential questions

### How do I use this? (How do I use derivations in Nix?)

I have written about how to use parts of Nix here: <https://github.com/justinwoo/nix-shorts>

### How do I install to my system from here?

Behold:

```console
$ nix-env -f default.nix -iA purs
  # or nix-env -if purs.nix

$ which purs
/home/justin/.nix-profile/bin/purs
$ purs --version
0.14.4
```

Or by `shell.nix`:

```nix
{ pkgs ? import <nixpkgs> { } }:
let
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "5716cd791c999b3246b4fe173276b42c50afdd8d";
      sha256 = "1r9lx4xhr42znmwb2x2pzah920klbjbjcivp2f0pnka7djvd2adq";
    }) {
    inherit pkgs;
  };
in
pkgs.mkShell {
  buildInputs = [
    easy-ps.purs-0_14_4
    easy-ps.psc-package
  ];
}
```

## Nix Flakes

There is a `flake.nix`. To see what the `flake.nix` provides,

```
nix flake show github:justinwoo/easy-purescript-nix
```

You might need the flag `--allow-import-from-derivation` if you’re on an older version of Nix.

### Deluxe `nix develop` shell

To get a deluxe PureScript development shell which includes the latest
versions of everything,

```
nix develop github:justinwoo/easy-purescript-nix#deluxe
```

### Custom `nix develop` shell

Create a custom `nix develop` shell with a `flake.nix` like this for example:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    easy-purescript-nix.url = "github:justinwoo/easy-purescript-nix";
  };

  outputs = { nixpkgs, flake-utils, easy-purescript-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        easy-ps = easy-purescript-nix.packages.${system};
      in
      {
        devShells = {
          default = pkgs.mkShell {
            name = "purescript-custom-shell";
            buildInputs = [
              easy-ps.purs-0_15_8
              easy-ps.spago
              easy-ps.purescript-language-server
              easy-ps.purs-tidy
              pkgs.nodejs-18_x
              pkgs.esbuild
            ];
            shellHook = ''
              source <(spago --bash-completion-script `which spago`)
              source <(node --completion-bash)
              '';
          };
       };
     }
  );
}
```


## Why was this made?

See the blog post about this here: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2018-10-24-using-purescript-easily-with-nix.md>

Raison d'etre: <https://github.com/justinwoo/my-blog-posts/blob/master/posts/2019-04-29-why-easy-purescript-nix.md>

## Credits

Thanks to Pekka (@kaitanie) for making this work on NixOS.
