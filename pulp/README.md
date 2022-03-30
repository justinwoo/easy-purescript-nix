
## How to generate `default.nix`, `node-env.nix`, `node-packages.nix`

```
cd pulp/16.0.0-0
nix-shell -p nodePackages.node2nix --command 'node2nix --nodejs-14 --input package.json'
```

See https://github.com/justinwoo/easy-purescript-nix/issues/192
