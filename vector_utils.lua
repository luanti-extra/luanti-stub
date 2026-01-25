---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


---@class VectorLib
local VectorLib = {}

---@overload fun(): Vector3
---@overload fun(v: Vector3): Vector3
---@overload fun(x: number, y: number, z: number): Vector3
---@return Vector3
function VectorLib.new(x, y, z) end

---@overload fun(a: Vector3, b: number): Vector3
---@param a Vector3
---@param b Vector3
---@return Vector3
function VectorLib.add(a, b) end

---@overload fun(a: Vector3, b:number): Vector3
---@param a Vector3
---@param b Vector3
---@return Vector3
function VectorLib.subtract(a, b) end

---@param a Vector3
---@param b Vector3
---@return boolean
function VectorLib.equals(a, b) end

---@param a Vector3
---@param b number|Vector3
---@return Vector3
function VectorLib.multiply(a, b) end

---@param a Vector3
---@param b number|Vector3
---@return Vector3
function VectorLib.divide(a, b) end

---@overload fun(a: Vector3, b: Vector3): Vector3
function VectorLib.distance(a, b) end

---@type VectorLib
vector = VectorLib
