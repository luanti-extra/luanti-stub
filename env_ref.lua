---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


---@class EnvRef
---@field [string] fun(self: EnvRef, ...: any): any  -- fallback: env can proxy lots of core funcs
EnvRef = {}

-- Environment access (method forms)
---@param pos Vector3
---@return NodeSpec
function EnvRef:get_node(pos) end

---@param pos Vector3
---@return NodeSpec|nil
function EnvRef:get_node_or_nil(pos) end

---@param pos Vector3
---@param node NodeSpec
function EnvRef:set_node(pos, node) end

---@param pos Vector3
---@param node NodeSpec
function EnvRef:add_node(pos, node) end

---@param pos Vector3
---@param node NodeSpec
function EnvRef:swap_node(pos, node) end

---@param pos Vector3
function EnvRef:remove_node(pos) end

---@param pos Vector3
---@return NodeMetaRef
function EnvRef:get_meta(pos) end

