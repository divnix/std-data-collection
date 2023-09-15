# Deprecated

This repository has been archived, the nixago configuration data has been upstream into `divnix/std`.

Where before you did:
```nix
(mkNixago input$.std-data-collection.data.configs.lefthook)
```

Now do:
```nix
(mkNixago input$.std.data.configs.lefthook)
```

- `mdbook-kroki-preprocessor` was also removed from the `mdbook` preset
