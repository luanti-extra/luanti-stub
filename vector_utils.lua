---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


---@class Vector3 An XYZ coordinate.
---@field x number
---@field y number The vertical position.
---@field z number
---@field minp? Vector3 Custom field for minimum values
---@field maxp? Vector3 Custom field for maximum values

---@class VectorLib
local VectorLib = {}

---@overload fun(): Vector3
---@overload fun(v: Vector3): Vector3
---@overload fun(x: number, y: number, z: number): Vector3
---@return Vector3
function VectorLib.new(x, y, z) end

---@overload fun(a: Vector3, b: number): Vector3
---@overload fun(a: Vector3, b: Vector3): Vector3
function VectorLib.add(a, b) end

---@overload fun(a: Vector3, b:number): Vector3
---@overload fun(a: Vector3, b:Vector3): Vector3
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

---@overload fun(a: Vector3, b: Vector3): number
function VectorLib.distance(a, b) end

---@param v Vector3
---@return number
function VectorLib.length(v) end

---@param v Vector3
---@return Vector3
function VectorLib.normalize(v) end

---@param v Vector3
---@return Vector3
function VectorLib.round(v) end

---@param a Vector3
---@param b Vector3
---@return Vector3
function VectorLib.cross(a, b) end

---@type VectorLib
vector = VectorLib
