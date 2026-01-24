---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


---@class VectorLib
local VectorLib = {}

---@param a Vector3
---@param b Vector3
---@return Vector3
function VectorLib.add(a, b) end

---@param a Vector3
---@param b number|Vector3
---@return Vector3
function VectorLib.multiply(a, b) end

---@param a Vector3
---@param b number|Vector3
---@return Vector3
function VectorLib.divide(a, b) end

---@type VectorLib
vector = VectorLib
