---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


-- dump(value, name) -> string
---@param value any
---@param name? string
---@return string
function dump(value, name) end


---@param s string
---@param delim string
---@param include_empty? boolean  -- if true, keep empty parts
---@param max_splits? integer    -- max number of splits (engine behavior)
---@param sep_is_pattern? boolean -- if true, `delim` is a Lua pattern
---@return string[]
function string.split(s, delim, include_empty, max_splits, sep_is_pattern) end

---@param s string
---@return string
function string.trim(s) end

-- Optional: makes `"abc":trim()` resolve cleanly in some setups
---@param self string
---@return string
function string:trim() end
