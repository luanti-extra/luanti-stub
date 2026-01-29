---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


---@class ObjectRef
local ObjectRef = {}

---@class NameTagAttribute
---@field text string The text written on the nametag (can be empty)
---@field color? ColorSpec The color of the text (foreground)
---@field bgcolor? ColorSpec|false 

---@class PlayerHPChangeReason
---@field type? "set_hp"|"punch"|"fall"|"node_damage"|"drown"|"respawn"
---@field from? "mod"|"engine"
---@field object ObjectRef?
---@field node table?
---@field hunger number?

---@alias BoneOverride table
---@alias HUDDefinition table
---@alias HUDFlags table
---@alias PlayerPhysicsOverride table
---@alias PlayerControl table
---@alias MinimapMode table
---@alias PlayerLightingDefinition table
---@alias PlayerSkyParameters table
---@alias PlayerSunParameters table
---@alias PlayerMoonParameters table
---@alias PlayerStarParameters table
---@alias PlayerCloudParameters table
---@alias PlayerCameraParams table
---@alias PlayerFlags table

--- returns the luaentity object associated with this object
---@return LuaEntity? value
function ObjectRef:get_luaentity() end

--- Removes the object ref from the scene.
---@return nil
function ObjectRef:remove() end

---@return boolean
function ObjectRef:is_valid() end

---@return Vector3? value
function ObjectRef:get_pos() end

---@param pos Vector3
function ObjectRef:set_pos(pos) end

---@param pos Vector3
function ObjectRef:add_pos(pos) end

---@return Vector3?
function ObjectRef:get_velocity() end

---@param vel Vector3
function ObjectRef:add_velocity(vel) end

---@param pos Vector3
---@param continuous boolean?
function ObjectRef:move_to(pos, continuous) end

---@param puncher ObjectRef?
---@param time_from_last_punch number?
---@param tool_capabilities table?
---@param dir Vector3?
function ObjectRef:punch(puncher, time_from_last_punch, tool_capabilities, dir) end

---@param clicker ObjectRef
function ObjectRef:right_click(clicker) end

---@return integer?
function ObjectRef:get_hp() end

---@param hp integer
---@param reason PlayerHPChangeReason?
function ObjectRef:set_hp(hp, reason) end

---@return InvRef?
function ObjectRef:get_inventory() end

---@return string
function ObjectRef:get_wield_list() end

---@return integer
function ObjectRef:get_wield_index() end

---@return ItemStack
function ObjectRef:get_wielded_item() end

---@param item ItemStack|string|table
---@return boolean
function ObjectRef:set_wielded_item(item) end

---@return table<string, integer>
function ObjectRef:get_armor_groups() end

---@param groups table<string, integer>
function ObjectRef:set_armor_groups(groups) end

---@param frame_range {x:number, y:number}
---@param frame_speed number?
---@param frame_blend number?
---@param frame_loop boolean?
function ObjectRef:set_animation(frame_range, frame_speed, frame_blend, frame_loop) end

---@return {x:number, y:number} frame_range
---@return number frame_speed
---@return number frame_blend
---@return boolean frame_loop
function ObjectRef:get_animation() end

---@param frame_speed number
function ObjectRef:set_animation_frame_speed(frame_speed) end

---@param parent ObjectRef
---@param bone string?
---@param position Vector3?
---@param rotation Vector3? degrees (relative rotation)
---@param forced_visible boolean?
function ObjectRef:set_attach(parent, bone, position, rotation, forced_visible) end

---@return ObjectRef? parent
---@return string? bone
---@return Vector3? position
---@return Vector3? rotation  degrees (relative rotation)
---@return boolean? forced_visible
function ObjectRef:get_attach() end

---@return ObjectRef[]
function ObjectRef:get_children() end

function ObjectRef:set_detach() end

-- Deprecated (kept for compatibility)
---@param bone string?
---@param position Vector3?
---@param rotation Vector3? degrees (relative rotation)
function ObjectRef:set_bone_position(bone, position, rotation) end

---@param bone string
---@return Vector3? position
---@return Vector3? rotation -- degrees
function ObjectRef:get_bone_position(bone) end

---@param bone string
---@param override? BoneOverride
function ObjectRef:set_bone_override(bone, override) end

---@param bone string
---@return BoneOverride
function ObjectRef:get_bone_override(bone) end

---@return table<string, BoneOverride>
function ObjectRef:get_bone_overrides() end

---@param props ObjectProperties
function ObjectRef:set_properties(props) end

---@return ObjectProperties
function ObjectRef:get_properties() end

---@param observers table<string, boolean>|nil
function ObjectRef:set_observers(observers) end

---@return table<string, boolean>|nil
function ObjectRef:get_observers() end

---@return table<string, boolean>|nil
function ObjectRef:get_effective_observers() end

--- returns true if the current object is a player.
---@return boolean
function ObjectRef:is_player() end

---@return NameTagAttribute? value the attributes of the nametag
function ObjectRef:get_nametag_attributes() end

---@param attributes? NameTagAttribute The attribute of the nametag
function ObjectRef:set_nametag_attributes(attributes) end

---@return string
function ObjectRef:get_guid() end

-- Lua entity only (no-op for other objects)

function ObjectRef:remove() end

---@param vel Vector3
function ObjectRef:set_velocity(vel) end

---@param acc Vector3
function ObjectRef:set_acceleration(acc) end

---@return Vector3?
function ObjectRef:get_acceleration() end

---@param rot Vector3 -- radians
function ObjectRef:set_rotation(rot) end

---@return Vector3? -- radians
function ObjectRef:get_rotation() end

---@param yaw number -- radians
function ObjectRef:set_yaw(yaw) end

---@return number? -- radians
function ObjectRef:get_yaw() end

---@param mod string
function ObjectRef:set_texture_mod(mod) end

---@return string?
function ObjectRef:get_texture_mod() end

---@param start_frame? {x:integer, y:integer}
---@param num_frames? integer
---@param framelength? number
---@param select_x_by_camera? boolean
function ObjectRef:set_sprite(start_frame, num_frames, framelength, select_x_by_camera) end

---@return LuaEntity?
function ObjectRef:get_luaentity() end

---@return string?
function ObjectRef:get_entity_name() end -- Deprecated

-- Player only (no-op for other objects)

---@return string
function ObjectRef:get_player_name() end

---@return Vector3?
function ObjectRef:get_player_velocity() end -- Deprecated

---@param vel Vector3
function ObjectRef:add_player_velocity(vel) end -- Deprecated

---@return Vector3?
function ObjectRef:get_look_dir() end

---@return number?
function ObjectRef:get_look_vertical() end

---@return number?
function ObjectRef:get_look_horizontal() end

---@param radians number
function ObjectRef:set_look_vertical(radians) end

---@param radians number
function ObjectRef:set_look_horizontal(radians) end

---@return number?
function ObjectRef:get_look_pitch() end -- Deprecated

---@return number?
function ObjectRef:get_look_yaw() end -- Deprecated

---@param radians number
function ObjectRef:set_look_pitch(radians) end -- Deprecated

---@param radians number
function ObjectRef:set_look_yaw(radians) end -- Deprecated

---@return integer?
function ObjectRef:get_breath() end

---@param value integer
function ObjectRef:set_breath(value) end

---@param fov number
---@param is_multiplier? boolean
---@param transition_time? number
function ObjectRef:set_fov(fov, is_multiplier, transition_time) end

---@return number fov
---@return boolean is_multiplier
---@return number transition_time
function ObjectRef:get_fov() end

---@param attribute string
---@param value? string|number
function ObjectRef:set_attribute(attribute, value) end -- Deprecated

---@param attribute string
---@return string?
function ObjectRef:get_attribute(attribute) end -- Deprecated

---@return PlayerMetaRef
function ObjectRef:get_meta() end

---@param formspec string
function ObjectRef:set_inventory_formspec(formspec) end

---@return string
function ObjectRef:get_inventory_formspec() end

---@param formspec string
function ObjectRef:set_formspec_prepend(formspec) end

---@return string
function ObjectRef:get_formspec_prepend() end

---@return PlayerControl
function ObjectRef:get_player_control() end

---@return integer
function ObjectRef:get_player_control_bits() end

---@param override_table PlayerPhysicsOverride
function ObjectRef:set_physics_override(override_table) end

---@return PlayerPhysicsOverride
function ObjectRef:get_physics_override() end

---@param def HUDDefinition
---@return integer
function ObjectRef:hud_add(def) end

---@param id integer
function ObjectRef:hud_remove(id) end

---@param id integer
---@param stat string
---@param value any
function ObjectRef:hud_change(id, stat, value) end

---@param id integer
---@return HUDDefinition? value the hud definition
function ObjectRef:hud_get(id) end

---@return table<integer, HUDDefinition>
function ObjectRef:hud_get_all() end

---@param flags HUDFlags
function ObjectRef:hud_set_flags(flags) end

---@return HUDFlags
function ObjectRef:hud_get_flags() end

---@param count integer
function ObjectRef:hud_set_hotbar_itemcount(count) end

---@return integer
function ObjectRef:hud_get_hotbar_itemcount() end

---@param texturename string
function ObjectRef:hud_set_hotbar_image(texturename) end

---@return string
function ObjectRef:hud_get_hotbar_image() end

---@param texturename string
function ObjectRef:hud_set_hotbar_selected_image(texturename) end

---@return string
function ObjectRef:hud_get_hotbar_selected_image() end

---@param modes MinimapMode[]
---@param selected_mode integer
function ObjectRef:set_minimap_modes(modes, selected_mode) end

---@param sky_parameters? PlayerSkyParameters
function ObjectRef:set_sky(sky_parameters) end

---@param base_color ColorSpec
---@param type string
---@param textures string[]
---@param clouds boolean
function ObjectRef:set_sky(base_color, type, textures, clouds) end -- Deprecated overload

---@param as_table? boolean
---@return any
function ObjectRef:get_sky(as_table) end

---@return any
function ObjectRef:get_sky_color() end -- Deprecated

---@param sun_parameters? PlayerSunParameters
function ObjectRef:set_sun(sun_parameters) end

---@return PlayerSunParameters
function ObjectRef:get_sun() end

---@param moon_parameters? PlayerMoonParameters
function ObjectRef:set_moon(moon_parameters) end

---@return PlayerMoonParameters
function ObjectRef:get_moon() end

---@param star_parameters? PlayerStarParameters
function ObjectRef:set_stars(star_parameters) end

---@return PlayerStarParameters
function ObjectRef:get_stars() end

---@param cloud_parameters? PlayerCloudParameters
function ObjectRef:set_clouds(cloud_parameters) end

---@return PlayerCloudParameters
function ObjectRef:get_clouds() end

---@param ratio number?
function ObjectRef:override_day_night_ratio(ratio) end

---@return number?
function ObjectRef:get_day_night_ratio() end

---@param idle {x:number, y:number}
---@param walk {x:number, y:number}
---@param dig {x:number, y:number}
---@param walk_while_dig {x:number, y:number}
---@param frame_speed? number
function ObjectRef:set_local_animation(idle, walk, dig, walk_while_dig, frame_speed) end

---@return {x:number, y:number} idle
---@return {x:number, y:number} walk
---@return {x:number, y:number} dig
---@return {x:number, y:number} walk_while_dig
---@return number frame_speed
function ObjectRef:get_local_animation() end

---@param firstperson Vector3?
---@param thirdperson_back Vector3?
---@param thirdperson_front Vector3?
function ObjectRef:set_eye_offset(firstperson, thirdperson_back, thirdperson_front) end

---@return Vector3 firstperson
---@return Vector3 thirdperson_back
---@return Vector3 thirdperson_front
function ObjectRef:get_eye_offset() end

---@param params PlayerCameraParams
function ObjectRef:set_camera(params) end

---@return PlayerCameraParams
function ObjectRef:get_camera() end

---@param blockpos Vector3
---@return boolean
function ObjectRef:send_mapblock(blockpos) end

---@param light_definition? PlayerLightingDefinition
function ObjectRef:set_lighting(light_definition) end

---@return PlayerLightingDefinition
function ObjectRef:get_lighting() end

---@return nil value
function ObjectRef:respawn() end

---@return PlayerFlags
function ObjectRef:get_flags() end

---@param flags PlayerFlags
function ObjectRef:set_flags(flags) end
