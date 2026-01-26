---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


---@class MTSettings
MTSettings = {}

--- Returns the specific settings
---@param key string The name of the setting
---@return string? -- The setting that was found (or nil)
function MTSettings:get(key) end

--- Returns the specific setting as boolean
---@param key string The name of the setting
---@param default? boolean The default value to return if the key was not found
---@return boolean? value The setting that was found (or nil)
function MTSettings:get_bool(key, default) end


---@param key string
---@return NoiseParams|nil value
function MTSettings:get_np_group(key) end


---@param key string
---@return table<string, boolean>|nil flags
function MTSettings:get_flags(key) end

---@param key string
---@return Vector3|nil pos
function MTSettings:get_pos(key) end

---@param key string
---@param value string
function MTSettings:set(key, value) end

---@param key string
---@param value boolean
function MTSettings:set_bool(key, value) end

---@param key string
---@param value NoiseParams
function MTSettings:set_np_group(key, value) end

---@param key string
---@param value Vector3
function MTSettings:set_pos(key, value) end

---@param key string
---@return boolean ok
function MTSettings:remove(key) end

---@return string[] keys
function MTSettings:get_names() end

---@param key string
---@return boolean exists
function MTSettings:has(key) end

---@return boolean ok
function MTSettings:write() end

---@return table<string, string> t
function MTSettings:to_table() end

