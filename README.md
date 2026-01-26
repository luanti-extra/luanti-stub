# luanti-stub
Specific stub files for luan/minetest.

## How to use

1. Make sure you have sumneko Lua extension enabled in your vscode workspace.

2. Modify (or create) this file: `.luarc.json` alongside of your `init.lua` file.

3. Make sure this content exists in it:

```json
{
    "diagnostics.globals": [],
    "workspace.library": ["../luanti-stub"]
}
```

The path `../luanti-stub` must be the correct path to where you have cloned this repository.
The line `diagnostics.globals` is optional, but in case your mod is defining a global variable, it would be useful for the linter.
