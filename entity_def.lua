---@meta

-- Basic shared types used by entity defs


-- A 6-number AABB: { xmin, ymin, zmin, xmax, ymax, zmax }
---@alias CuboidDef number[]

-- Selectionbox is like CuboidDef, but can optionally include rotate=boolean
---@alias SelectionBoxDef (CuboidDef|{[1]:number,[2]:number,[3]:number,[4]:number,[5]:number,[6]:number, rotate:boolean?})

---@class NodeTable
---@field name string
---@field param1 integer?
---@field param2 integer?

-- ToolCapabilities placeholder (optional to fully flesh out elsewhere)
---@class ToolCapabilities

-- Collision info (moveresult) for on_step

---@class MoveresultCollisionBase
---@field axis "x"|"y"|"z"
---@field old_velocity Vector3
---@field new_velocity Vector3
---@field new_pos Vector3?  -- only present if feature "moveresult_new_pos" exists

---@class MoveresultCollisionNode: MoveresultCollisionBase
---@field type "node"
---@field node_pos Vector3

---@class MoveresultCollisionObject: MoveresultCollisionBase
---@field type "object"
---@field object ObjectRef

---@alias MoveresultCollision MoveresultCollisionNode|MoveresultCollisionObject

---@class Moveresult
---@field touching_ground boolean
---@field collides boolean
---@field standing_on_object boolean
---@field collisions MoveresultCollision[]

-- Object properties (used inside entitydef.initial_properties)

---@class ObjectProperties
---@field hp_max integer?
---@field breath_max integer?      -- players only
---@field zoom_fov number?         -- players only (degrees)
---@field eye_height number?       -- players only
---@field physical boolean?
---@field collide_with_objects boolean?
---@field collisionbox CuboidDef?
---@field selectionbox SelectionBoxDef?
---@field pointable boolean|"blocking"?
---@field visual "cube"|"sprite"|"upright_sprite"|"mesh"|"wielditem"|"item"|"node"|string?
---@field visual_size Vector3?
---@field mesh string?
---@field textures string[]?
---@field colors ColorSpec[]?
---@field node NodeTable?          -- only for visual="node"
---@field wield_item ItemString?   -- only for visual="wielditem" (preferred over textures={itemname})
---@field use_texture_alpha boolean?
---@field spritediv Vector2?
---@field initial_sprite_basepos Vector2?
---@field is_visible boolean?
---@field makes_footstep_sound boolean?
---@field automatic_rotate number? -- radians/sec
---@field stepheight number?
---@field automatic_face_movement_dir number|false? -- degrees offset, false disables
---@field automatic_face_movement_max_rotation_per_sec number?
---@field backface_culling boolean?
---@field glow integer?
---@field nametag string?
---@field nametag_color ColorSpec?
---@field nametag_bgcolor ColorSpec|false?
---@field nametag_fontsize integer|false?
---@field nametag_scale_z boolean?
---@field infotext string?
---@field static_save boolean?
---@field damage_texture_modifier string?
---@field shaded boolean?
---@field show_on_minimap boolean?



-- Entity definition table passed to register_entity

---@class EntityDefinition
---@field initial_properties? ObjectProperties
---@field on_activate? fun(self: LuaEntity, staticdata: string, dtime_s: number)
---@field on_deactivate? fun(self: LuaEntity, removal: boolean)
---@field on_step? fun(self: LuaEntity, dtime: number, moveresult: Moveresult|nil)
---@field on_punch? fun(self: LuaEntity, puncher: ObjectRef|nil, time_from_last_punch: number|nil, tool_capabilities: ToolCapabilities|nil, dir: Vector3, damage: number): boolean  -- return true to stop default damage
---@field on_death? fun(self: LuaEntity, killer: ObjectRef|nil)
---@field on_rightclick? fun(self: LuaEntity, clicker: ObjectRef)
---@field on_attach_child? fun(self: LuaEntity, child: ObjectRef)
---@field on_detach_child? fun(self: LuaEntity, child: ObjectRef)
---@field on_detach? fun(self: LuaEntity, parent: ObjectRef)
---@field get_staticdata? fun(self: LuaEntity): string
---@field velocity? number the entity's velocity
---@field [string] any  -- allow custom fields (convention: prefix with "_")


