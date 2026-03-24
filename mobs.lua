---@meta mobs_redo
-- Stub file for TenPlus1's "Mobs Redo" API (global `mobs` table).
-- Intended for LuaLS / EmmyLua-style annotations.


---@alias EntityName string

---@alias MobType
---| '"monster"'  # Attacks players and often other mobs
---| '"animal"'   # Usually passive / wanders, may retaliate
---| '"npc"'      # Similar to animal; often used for guards/traders
---
---Doc lists these 3 values. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))

---@alias AttackType
---| '"dogfight"' -- melee
---| '"shoot"'    -- ranged only
---| '"explode"'  -- explode in reach
---| '"dogshoot"' -- ranged in view_range, melee in reach
---
---Doc lists these options. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))

---@alias FollowItems ItemString|ItemString[]

---@class Sounds
-- Sound fields are documented as a table of names; distance defaults to ~10. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
---@field random? string
---@field war_cry? string
---@field attack? string
---@field shoot_attack? string
---@field damage? string
---@field death? string
---@field jump? string
---@field explode? string
---@field distance? integer

---@class AnimationDef
-- Animation ranges/speeds. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
---@field stand_start? integer
---@field stand_end? integer
---@field stand_speed? integer
---@field walk_start? integer
---@field walk_end? integer
---@field walk_speed? integer
---@field run_start? integer
---@field run_end? integer
---@field run_speed? integer
---@field fly_start? integer
---@field fly_end? integer
---@field fly_speed? integer
---@field punch_start? integer
---@field punch_end? integer
---@field punch_speed? integer
---@field punch2_start? integer
---@field punch2_end? integer
---@field punch2_speed? integer
---@field die_start? integer
---@field die_end? integer
---@field die_speed? integer
---@field speed_normal? integer -- deprecated compatibility knob (mentioned in docs). ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))

---@class DropDef
-- Drop entry. Docs describe name/chance/min/max. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
---@field name ItemString
---@field chance integer  -- “inverted chance” (ABM-style chance)
---@field min integer
---@field max integer

---@alias ImmuneToEntry { [1]: ItemString, [2]: number }
-- Docs show immune_to entries as { "tool_or_item_name", damage }, where damage can be 0 (immune) or negative (heals). ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))

---@alias ReplaceWhatEntry { [1]: NodeName, [2]: NodeName, [3]: number }
-- Docs show replace_what entries like { "group:grass", "air", 0 } where [3] is y-offset. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))

---@class MobEntity
-- This represents the Lua “self” used by mobs_redo callbacks (on_die, custom_attack, etc.).
-- The real runtime object has many more fields; keeping it loose avoids wrong assumptions.
---@field object? ObjectRef
---@field driver ObjectRef The driver of this mob
---@field player_rotation Vector3
---@field driver_attach_at Vector3
---@field driver_eye_offset Vector3
---@field driver_scale Vector3
local MobEntity = {}

---Sets the yaw on this mob entity.
---@param yaw number The target yaw.
---@param delay number The target delay.
---@return number value the yaw that is set.
function MobEntity:set_yaw(yaw, delay) end

---Sets the animation of the current mob entity.
---@param anim string Name of the animation to set on this mob entity.
---@param force? boolean Should we force it?
function MobEntity:set_animation(anim, force) end

---Sets the line of sight to the specified positions.
---@param pos1 Vector3 The first position.
---@param pos2 Vector3 The second position.
---@return boolean
function MobEntity:line_of_sight(pos1, pos2) end


---Attempts to find somewhere to move to (hence the correction)
---@param override? boolean whether we should override the current object
---@return boolean value true on success
function MobEntity:attempt_flight_correction(override) end


---Are we flying in what we are supposed to?
---@return boolean value true if yes.
function MobEntity:flight_check() end


---Converts yaw to position.
---@param target Vector3 The target vector.
---@param rot? number The target rotation I guess (or delay?)
---@return number value The yaw that is set.
function MobEntity:yaw_to_pos(target, rot) end

---Returns the current velocity of this mob entity.
---@return number? value the velocity.
function MobEntity:get_velocity() end


---Sets the current velocity of this mob entity.
---@param v number the new target velocity.
function MobEntity:set_velocity(v) end


---look for stay_near nodes and move towards them
---@return boolean value true if we tried to move towards a node.
function MobEntity:do_stay_near() end

---Updates the tag of this mob entity.
---@param new_name? string The new name of the mob entity.
function MobEntity:update_tag(new_name) end

---Drop the items for this mob entity after its death.
function MobEntity:item_drop() end

---Plays the sound for the current mob entity object.
---@param sound SoundSpec|string|nil The sound spec to play.
function MobEntity:mob_sound(sound) end



---@alias OnDie fun(self:MobEntity, pos:Vector3):nil
---@alias CustomAttack fun(self:MobEntity, to_attack:ObjectRef):boolean|nil
---@alias OnReplace fun(self:MobEntity, pos:Vector3, oldnode:table, newnode:table):boolean|nil
---@alias OnBlast fun(self:MobEntity, damage:number):(boolean, boolean, any)
---@alias OnSpawn fun(self:MobEntity, pos:Vector3):boolean|nil
---@alias OnBreed fun(self:MobEntity, mate:MobEntity):boolean|nil
---@alias OnFlop fun(self:MobEntity):boolean|nil
---@alias DoPunch fun(self:MobEntity, hitter:ObjectRef, time_from_last_punch:number, tool_capabilities:table, dir:Vector3, damage:number):boolean|nil
---@alias DoCustom fun(self:MobEntity, dtime:number, moveresult:Moveresult):boolean|nil
---@alias OnDeath fun(self:MobEntity, killer:ObjectRef|nil):nil
---@alias OnSound fun(self:MobEntity, sound:table):nil

---@class MobDef
-- “Definition table” for MobsRedo:register_mob(name, def). ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
-- Core
---@field type MobType
---@field hp_min integer
---@field hp_max integer
-- Entity-ish graphics/physics (mirrors minetest.register_entity in many places)
---@field physical? boolean
---@field collisionbox? number[]|table
---@field visual? string
---@field visual_size? {x:number, y:number}
---@field rotate? integer
---@field drawtype? string -- deprecated (“front”/“side”). ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
-- Textures/mesh/blood
---@field textures? string[][]|string[]|table
---@field gotten_texture? string
---@field child_texture? string|string[][]
---@field mesh? string
---@field gotten_mesh? string
---@field blood_amount? integer
---@field blood_texture? string
-- Sound
---@field makes_footstep_sound? boolean
---@field sounds? Sounds
-- Behaviour / movement
---@field follow? FollowItems
---@field view_range? integer
---@field walk_chance? integer
---@field walk_velocity? number
---@field run_velocity? number
---@field stepheight? number
---@field jump? boolean
---@field jump_height? integer
---@field fly? boolean
---@field fly_in? NodeName|NodeName[]
---@field water_damage? number
---@field lava_damage? number
---@field light_damage? number
---@field suffocation? number|boolean|nil can be both number and boolean
---@field fall_damage? boolean
---@field fall_speed? integer
---@field fear_height? integer
---@field floats? integer -- 1=float, 0=sink. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
---@field pathfinding? 0|1|2
-- Callbacks (documented)
---@field on_die? OnDie
---@field on_rightclick? fun(self:MobEntity, clicker:ObjectRef):nil
-- Combat / targeting
---@field passive? boolean
---@field docile_by_day? boolean
---@field attacks_monsters? boolean
---@field group_attack? boolean
---@field owner_loyal? boolean
---@field attack_animals? boolean
---@field specific_attack? EntityName[]
---@field runaway? boolean
---@field damage? number
---@field recovery_time? number
---@field knock_back? integer
---@field immune_to? ImmuneToEntry[]
---@field drops? DropDef[]|fun(self:MobEntity):DropDef[] -- drops-as-function exists in some versions (changelog mentions it). ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field armor? integer
---@field attack_type? AttackType
---@field dogshoot_switch? integer
---@field dogshoot_count_max? integer
---@field dogshoot_count2_max? integer
---@field custom_attack? CustomAttack
---@field double_melee_attack? boolean
---@field on_blast? OnBlast
-- Explode/shoot options
---@field explosion_radius? integer
---@field explosion_damage_radius? integer -- appears in some api.txt copies online. ([git.linux-forks.de](https://git.linux-forks.de/mobs_redo/tree/api.txt?h=origin%2FHEAD&id=1bb95d742cfd50cbb2329f344a008f13809d753c))
---@field explosion_timer? number -- appears in some api.txt copies online. ([git.linux-forks.de](https://git.linux-forks.de/mobs_redo/tree/api.txt?h=origin%2FHEAD&id=1bb95d742cfd50cbb2329f344a008f13809d753c))
---@field arrow? EntityName
---@field shoot_interval? number
---@field shoot_offset? number
---@field reach? integer
-- Eating / node replace
---@field on_replace? OnReplace
---@field replace_what? string[]|ReplaceWhatEntry[]
---@field replace_with? NodeName
---@field replace_rate? integer
---@field replace_offset? number
-- Animation
---@field animation? AnimationDef
-- Note: docs also mention “*_loop” booleans per animation and defaults. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
-- Extra callbacks/fields that are commonly referenced in mobs_redo changelogs / ecosystem,
-- but not fully specified in the 2017 API HTML page:
---@field on_spawn? OnSpawn -- mentioned in changelog in some mirrors. ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field on_breed? OnBreed -- mentioned in changelog. ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field on_grown? fun(self:MobEntity):nil -- mentioned in changelog. ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field do_punch? DoPunch -- mentioned in changelog. ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field on_flop? OnFlop -- mentioned in changelog (swimming support). ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field air_damage? number -- mentioned in changelog (swimming support). ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field on_death? OnDeath
---@field do_custom? DoCustom
---@field on_sound? OnSound
---@class SpawnDef
---@field name EntityName
---@field nodes NodeName[]
---@field neighbors? NodeName[]        -- default {"air"} in docs. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
---@field min_light? integer
---@field max_light? integer
---@field interval? integer           -- ABM interval-like
---@field chance integer             -- ABM chance-like
---@field active_object_count? integer
---@field min_height? integer
---@field max_height? integer
---@field day_toggle? boolean|nil     -- true=day, false=night, nil=any. ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
---@field on_spawn? OnSpawn

---@class ArrowDef
-- Definition table for MobsRedo:register_arrow(name, def). ([antummt.github.io](https://antummt.github.io/mod-mobs_redo/api.html))
---@field visual? string
---@field visual_size? {x:number, y:number}
---@field textures? string[]|string[][]
---@field velocity? number
---@field drop? boolean
---@field tail? integer
---@field hit_player? fun(self:table, player:ObjectRef):nil
---@field hit_mob? fun(self:table, player:ObjectRef):nil
---@field hit_node? fun(self:table, pos:Vector3, node:table):nil

---@class MobsRedo
-- Global `mobs` table (injected by the mobs_redo mod).
---@field mod string
---@field version string
---@field spawning_mobs table<EntityName, table>
---@field translate fun(msgid:string, ...):string
---@field node_snow NodeName
---@field node_dirt NodeName
---@field fallback_node NodeName
---@field mob_class MobEntity
MobsRedo = {}

-- Registration.
---@param name EntityName
---@param def MobDef
function MobsRedo.register_mob(name, def) end

---@param name EntityName
---@param nodes NodeName[]
---@param max_light integer
---@param min_light integer
---@param chance integer
---@param active_object_count integer
---@param max_height integer
---@param day_toggle boolean|nil
function MobsRedo.register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height, day_toggle) end

---@param name EntityName
---@param nodes NodeName[]
---@param neighbors NodeName[]|nil
---@param min_light integer
---@param max_light integer
---@param interval integer
---@param chance integer
---@param active_object_count integer
---@param min_height integer
---@param max_height integer
---@param day_toggle boolean|nil
---@param on_spawn OnSpawn|nil
function MobsRedo.spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn) end

---@param def SpawnDef
function MobsRedo.spawn(def) end

---@param name EntityName
---@param def ArrowDef
function MobsRedo.register_arrow(name, def) end

---@param name EntityName
---@param description string
---@param background string
---@param addegg integer
---@param no_creative boolean|nil
---@param can_spawn_protect boolean|nil
function MobsRedo.register_egg(name, description, background, addegg, no_creative, can_spawn_protect) end

-- Spawn / visibility helpers.
---@param pos Vector3
---@param fallback? NodeName
---@return table
function MobsRedo.node_ok(pos, fallback) end

---@param entity MobEntity
---@param nodename NodeName
---@return boolean
function MobsRedo.is_node_dangerous(entity, nodename) end

---@param entity MobEntity
---@param player_name string
---@return boolean
function MobsRedo.is_invisible(entity, player_name) end

---@param pos Vector3
---@param name EntityName
---@return Vector3|nil
function MobsRedo.can_spawn(pos, name) end

---@param pos Vector3
---@param def {name:EntityName, texture?:string|string[], child?:boolean, owner?:string, nametag?:string, ignore_count?:boolean}
---@return MobEntity|false|nil
function MobsRedo.add_mob(pos, def) end

---@param pos Vector3
---@param node table
---@param name EntityName
---@return boolean|nil
function MobsRedo.spawn_abm_check(pos, node, name) end

-- Combat / interaction helpers.
---@param entity MobEntity
---@param pos Vector3
---@param node_damage_radius integer
---@param entity_radius? integer
---@param texture? string
function MobsRedo.boom(entity, pos, node_damage_radius, entity_radius, texture) end

---@param entity MobEntity|nil
---@param pos Vector3
---@param radius integer
---@param texture? string
function MobsRedo.safe_boom(entity, pos, radius, texture) end

---@deprecated Use MobsRedo.boom
---@param pos Vector3
---@param radius integer
function MobsRedo.explosion(pos, radius) end

---@param entity MobEntity
---@param clicker ObjectRef
function MobsRedo.force_capture(entity, clicker) end

---@param entity MobEntity
---@param clicker ObjectRef
---@param chance_hand integer
---@param chance_net integer
---@param chance_lasso integer
---@param force_take boolean|nil
---@param replacewith ItemString|nil
---@return boolean|ItemStack
function MobsRedo.capture_mob(entity, clicker, chance_hand, chance_net, chance_lasso, force_take, replacewith) end

---@param entity MobEntity
---@param clicker ObjectRef
---@param feed_count integer
---@param breed boolean
---@param tame boolean
---@return boolean accepted
function MobsRedo.feed_tame(entity, clicker, feed_count, breed, tame) end

---@param entity MobEntity
---@param clicker ObjectRef
---@return boolean protected
function MobsRedo.protect(entity, clicker) end

---@param target_entity MobEntity
---@param decrease? boolean
function MobsRedo.remove(target_entity, decrease) end

---@param old_name EntityName
---@param new_name EntityName
function MobsRedo.alias_mob(old_name, new_name) end

-- Riding helpers.
---@param entity MobEntity
---@param player ObjectRef
function MobsRedo.attach(entity, player) end

---@param player ObjectRef
function MobsRedo.detach(player) end

---@param entity MobEntity
---@param moving_anim string
---@param stand_anim string
---@param can_fly boolean
---@param dtime number
function MobsRedo.drive(entity, moving_anim, stand_anim, can_fly, dtime) end

---@param entity MobEntity
---@param driver ObjectRef|nil
---@param speed number
---@param can_shoot boolean
---@param arrow_entity EntityName
---@param move_animation string
---@param stand_animation string
function MobsRedo.fly(entity, driver, speed, can_shoot, arrow_entity, move_animation, stand_animation) end

-- Compatibility wrappers around real `MobEntity` methods.
---@param entity MobEntity
---@param pos1 Vector3
---@param pos2 Vector3
---@return boolean
function MobsRedo.line_of_sight(entity, pos1, pos2) end

---@param entity MobEntity
---@param anim string
---@param force? boolean
function MobsRedo.set_animation(entity, anim, force) end

---@param entity MobEntity
---@param yaw number
---@param delay number
function MobsRedo.yaw(entity, yaw, delay) end

---@param entity MobEntity
---@param target Vector3
---@param rot? number
---@return number
function MobsRedo.yaw_to_pos(entity, target, rot) end

---@param entity MobEntity
---@param w? number
---@param h? number
---@param perma? boolean
function MobsRedo.scale_mob(entity, w, h, perma) end

-- Misc helpers.
---@param name string
---@return boolean
function MobsRedo.is_creative(name) end

---@param target_entity EntityDefinition
function MobsRedo.compatibility_check(target_entity) end

---@param pos Vector3
---@param amount integer
---@param texture string
---@param min_size? number
---@param max_size? number
---@param radius? number
---@param gravity? number
---@param glow? number
---@param fall? boolean
function MobsRedo.effect(pos, amount, texture, min_size, max_size, radius, gravity, glow, fall) end



mobs = MobsRedo

