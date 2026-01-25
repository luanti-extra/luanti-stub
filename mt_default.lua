---@meta
-- Minetest Game (MTG) "default" mod stub (practical LuaLS/EmmyLua annotations)
-- Note: MTG's "default" is not a formal stable API surface; this stub focuses on the
-- commonly-used exported helpers (especially node sounds) + leaves room for extra fields.


---@class SimpleSoundSpec
---@field name string
---@field gain number|nil
---@field pitch number|nil
---@field fade number|nil

---@alias DefaultSoundSpec SimpleSoundSpec|string

---@class DefaultNodeSounds
---@field footstep DefaultSoundSpec|nil
---@field dig DefaultSoundSpec|nil
---@field dug DefaultSoundSpec|nil
---@field place DefaultSoundSpec|nil

---@class DefaultNodeSoundsOverrides : DefaultNodeSounds

---@class DefaultLeafDecayDef
---@field trunks string[]      -- itemstrings of trunk nodes
---@field leaves string[]      -- itemstrings of leaf nodes
---@field radius integer|nil   -- search radius
---@field time integer|nil     -- legacy: decay time (if used by that MTG version)

---@class DefaultFenceDef
---@field description string|nil
---@field texture string|nil
---@field material string|nil
---@field groups table<string, integer>|nil
---@field sounds DefaultNodeSounds|nil
---@field tiles string[]|nil
---@field inventory_image string|nil
---@field wield_image string|nil
---@field sunlight_propagates boolean|nil
---@field paramtype string|nil
---@field drawtype string|nil
---@field is_ground_content boolean|nil
---@field node_box table|nil
---@field selection_box table|nil
---@field collision_box table|nil
---@field on_place fun(itemstack:any, placer:any, pointed_thing:any):any|nil
---@field on_construct fun(pos:Vector3):any|nil
---@field on_destruct fun(pos:Vector3):any|nil

---@class DefaultLib
---@field player_attached table<string, boolean>|nil
---@field gui_bg string|nil
---@field gui_bg_img string|nil
---@field gui_slots string|nil
---@field gui_hotbar_bg string|nil
---@field gui_survival_form string|nil
local DefaultLib = {
    LIGHT_MAX = 0, -- e.g. 10
}

-- Base helper: merge defaults + overrides (commonly used pattern)
---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_defaults(overrides) end

-- Sound presets (these are the ones you actually use in nodedef.sounds)
---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_stone_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_dirt_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_sand_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_gravel_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_wood_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_leaves_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_glass_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_metal_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_water_defaults(overrides) end

---@param overrides DefaultNodeSoundsOverrides|nil
---@return DefaultNodeSounds
function DefaultLib.node_sound_snow_defaults(overrides) end

-- Trees / saplings (commonly depended on by other mods)
---@param pos Vector3
---@param is_apple_tree boolean|nil
function DefaultLib.grow_tree(pos, is_apple_tree) end

---@param pos Vector3
function DefaultLib.grow_jungle_tree(pos) end

---@param pos Vector3
function DefaultLib.grow_pine_tree(pos) end

---@param pos Vector3
function DefaultLib.grow_acacia_tree(pos) end

---@param pos Vector3
function DefaultLib.grow_aspen_tree(pos) end

---@param pos Vector3
function DefaultLib.grow_new_apple_tree(pos) end

---@param pos Vector3
function DefaultLib.grow_new_jungle_tree(pos) end

---@param pos Vector3
function DefaultLib.grow_new_pine_tree(pos) end

---@param pos Vector3
---@return boolean
function DefaultLib.can_grow(pos) end

---@param pos Vector3
function DefaultLib.grow_sapling(pos) end

-- Leaf decay helpers (commonly referenced)
---@param def DefaultLeafDecayDef
function DefaultLib.register_leafdecay(def) end

---@param pos Vector3
---@param placer any
---@param itemstack any
---@param pointed_thing any
---@return any
function DefaultLib.after_place_leaves(pos, placer, itemstack, pointed_thing) end

-- Fences / misc registration helpers (names exist in many MTG-era mods)
---@param name string
---@param def DefaultFenceDef
function DefaultLib.register_fence(name, def) end

---@param name string
---@param def DefaultFenceDef
function DefaultLib.register_fence_rail(name, def) end

---@param name string
---@param def table
function DefaultLib.register_mesepost(name, def) end

---@type DefaultLib
default = DefaultLib
