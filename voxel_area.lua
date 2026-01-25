---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


-- VoxelArea is a Minetest-provided helper used with VoxelManip data.
-- It converts 3D positions (x,y,z) into a single linear index (vi)
-- that you use to index the `data` array returned by `vm:get_data()`.

---@class VoxelAreaBounds
---@field MinEdge Vector3  -- Lower corner of the area (inclusive)
---@field MaxEdge Vector3  -- Upper corner of the area (inclusive)

---@class VoxelArea
---@field MinEdge Vector3   -- cached bounds (as provided to :new)
---@field MaxEdge Vector3
---@field ystride integer     -- index delta when moving +1 in Y (implementation detail, but often useful)
---@field zstride integer     -- index delta when moving +1 in Z

VoxelArea = {}

---Create a new VoxelArea for a given box.
---You typically pass `emin`/`emax` returned by VoxelManip (the exact area your `data` covers).
---
---Example:
---  local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
---
---@param bounds VoxelAreaBounds
---@return VoxelArea
function VoxelArea:new(bounds) end

---Convert (x,y,z) into a *1-based* linear index into VoxelManip arrays (`data`, `param2`, etc).
---In Minetest, X is the fastest-changing axis, so `vi = vi + 1` moves +1 in X.
---
---@param x integer
---@param y integer
---@param z integer
---@return integer vi  -- 1..area:getVolume()
function VoxelArea:index(x, y, z) end

---Same as `index`, but takes a position table `{x=,y=,z=}`.
---@param pos Vector3
---@return integer vi
function VoxelArea:indexp(pos) end

---Inverse of `index`: convert a linear index back to `{x=,y=,z=}`.
---@param vi integer
---@return Vector3 pos
function VoxelArea:position(vi) end

---Check whether a position lies inside the area bounds.
---@param pos Vector3
---@return boolean
function VoxelArea:contains(pos) end

---Check whether a linear index is within the valid range.
---@param vi integer
---@return boolean
function VoxelArea:containsi(vi) end

---Total number of nodes in the area (extent.x * extent.y * extent.z).
---@return integer
function VoxelArea:getVolume() end

---Size of the area as a vector (width/height/depth).
---@return Vector3 extent
function VoxelArea:getExtent() end
