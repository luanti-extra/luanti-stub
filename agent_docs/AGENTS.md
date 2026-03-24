# AGENTS

## Main Purpose

This workspace is used for two related tasks across Luanti/Minetest mods:

1. Refactor mod runtime Lua into cleaner, more consistent, more maintainable code.
2. Maintain stub files in `mods/luanti-stub` so VS Code LuaLS (Sumneko / Lua Language Server) provides strong type hints and clean diagnostics.

The user cares about code quality, API clarity, and LuaLS cleanliness.

## Code Style Expectations

- Prefer `:` only for real methods that need `self`.
- Prefer `.` for namespace/table functions that do not use implicit `self`.
- Fix incorrect mixed colon/dot usage in both runtime code and stubs.
- Keep runtime API and stub API aligned.
- Reduce LuaLS warnings instead of papering over them when practical.
- Do not casually change behavior just to satisfy the linter; preserve mod compatibility unless there is a clear bug.

## Stub Expectations

- Stub files live under `mods/luanti-stub`.
- Stubs should describe the real runtime API shape, not an idealized one.
- For globals/tables such as `mobs`, prefer class/table declarations that LuaLS accepts cleanly.
- Avoid LuaLS `inject-field` patterns when declaring stub APIs.

Example of a bad stub shape:

```lua
---@class SomeAPI
---@type SomeAPI
Some = {}

function Some.foo() end
```

Prefer:

```lua
---@class Some
Some = {}

function Some.foo() end
```

## Lint / Diagnostic Workflow

There is a PowerShell wrapper on `PATH` named `lua-ls`.

Use it directly instead of rediscovering the VS Code extension binary.

Basic checks:

```powershell
lua-ls --version
```

Check a mod workspace:

```powershell
lua-ls --check="path/mod_folder" --check_format=pretty --checklevel=Information --configpath=".luarc.json" --force-accept-workspace
```

Check the stub workspace:

```powershell
lua-ls --check="path/luanti-stub" --check_format=pretty --checklevel=Information --force-accept-workspace
```

If needed, add a log path:

```powershell
lua-ls --check="PATH_TO_WORKSPACE" --check_format=pretty --checklevel=Information --logpath=".lua_ls_log" --force-accept-workspace
```

## Practical Priorities

- When touching a mod, inspect both the runtime file(s) and the matching stub file(s).
- If the user asks for cleanup, run LuaLS checks after edits when feasible.
- Use grep/search to identify colon/dot misuse and callback signature mismatches.
- When fixing APIs, update internal call sites, compatibility helpers, and stubs together.

## User Preferences

- The user is forking mods and wants them modernized, not merely minimally patched.
- The user uses VS Code with the Lua extension and expects diagnostics to matter.
- The user does not want future sessions to waste time rediscovering the LuaLS executable path.
