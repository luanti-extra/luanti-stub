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
function MobEntity:line_of_sight(pos1, pos2) end


---Attempts to find somewhere to move to (hence the correction)
---@param override boolean whether we should override the current object
---@return boolean value true on success
function MobEntity:attempt_flight_correction(override) end


---Are we flying in what we are supposed to?
---@return boolean value true if yes.
function MobEntity:flight_check() end


---Converts yaw to position.
---@param target Vector3 The target vector.
---@param rot number The target rotation I guess (or delay?)
---@return number value The yaw that is set.
function MobEntity:yaw_to_pos(target, rot) end

---Returns the current velocity of this mob entity.
---@return number value the velocity.
function MobEntity:get_velocity() end


---Sets the current velocity of this mob entity.
---@param v number the new target velocity.
function MobEntity:set_velocity(v) end


---look for stay_near nodes and move towards them
---@return boolean value true if we tried to move towards a node.
function MobEntity:do_stay_near() end

---Updates the tag of this mob entity.
---@param new_name string The new name of the mob entity.
function MobEntity:update_tag(new_name) end

---Drop the items for this mob entity after its death.
function MobEntity:item_drop() end

---Plays the sound for the current mob entity object.
---@param sound SoundSpec The sound spec to play.
function MobEntity:mob_sound(sound) end



---@alias OnDie fun(self:MobEntity, pos:Vector3):nil
---@alias CustomAttack fun(self:MobEntity, to_attack:ObjectRef):nil
---@alias OnReplace fun(self:MobEntity, pos:Vector3, oldnode:table, newnode:table):boolean|nil
---@alias OnBlast fun(object:ObjectRef, damage:number):(boolean, boolean, any)
---@alias OnSpawn fun(self:MobEntity, pos:Vector3):nil

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
---@field on_breed? fun(self:MobEntity, parent1:MobEntity, parent2:MobEntity):nil -- mentioned in changelog. ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field on_grown? fun(self:MobEntity):nil -- mentioned in changelog. ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field do_punch? fun(self:MobEntity, hitter:ObjectRef, time_from_last_punch:number, tool_capabilities:table, dir:Vector3, damage:number):nil -- mentioned in changelog. ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field on_flop? fun(self:MobEntity):nil -- mentioned in changelog (swimming support). ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
---@field air_damage? number -- mentioned in changelog (swimming support). ([notabug.org](https://notabug.org/OgelGames/mobs_redo))
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
---@field on_spawn? fun(self:MobEntity, pos:Vector3):nil

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

---@class MobsRedoAPI
-- Global `mobs` table (injected by the mobs_redo mod).
---@field mod? string -- Many mods check `MobsRedo.mod == "redo"` when multiple mob APIs exist.
MobsRedo = {}

-- Register a mob entity.
---@param name EntityName
---@param def MobDef
---@return nil
function MobsRedo.register_mob(name, def) end

-- Register a “classic” spawn (wrapper around spawn_specific in docs).
---@param name EntityName
---@param nodes NodeName[]
---@param max_light integer
---@param min_light integer
---@param chance integer
---@param active_object_count integer
---@param max_height integer
---@param day_toggle boolean|nil
---@return nil
function MobsRedo.register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height, day_toggle) end

-- Register a detailed spawn definition (ABM-style).
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
---@param on_spawn fun(self:MobEntity, pos:Vector3):nil
---@return nil
function MobsRedo.spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn) end

-- Table-form spawner registration (fields map to spawn_specific params).
---@param def SpawnDef
---@return nil
function MobsRedo.spawn(def) end

-- Register an arrow entity used by ranged mobs.
---@param name EntityName
---@param def ArrowDef
---@return nil
function MobsRedo.register_arrow(name, def) end

-- Register a spawn egg item for a mob.
---@param name EntityName
---@param description string
---@param background string
---@param addegg integer
---@param no_creative boolean|nil
---@return nil
function MobsRedo.register_egg(name, description, background, addegg, no_creative) end

-- Explosion helpers.
---@param entity MobEntity
---@param pos Vector3
---@param radius integer
---@return nil
function MobsRedo.boom(entity, pos, radius) end

---@deprecated Use MobsRedo:boom
---@param pos Vector3
---@param radius integer
---@return nil
function MobsRedo.explosion(pos, radius) end

-- Capture / tame helpers (typically called inside on_rightclick).
---@param entity MobEntity
---@param clicker ObjectRef
---@param chance_hand integer
---@param chance_net integer
---@param chance_lasso integer
---@param force_take boolean|nil
---@param replacewith ItemString|nil
---@return nil
function MobsRedo.capture_mob(entity, clicker, chance_hand, chance_net, chance_lasso, force_take, replacewith) end

---@param entity MobEntity
---@param clicker ObjectRef
---@param feed_count integer
---@param breed boolean
---@param tame boolean
---@return boolean accepted
function MobsRedo.feed_tame(entity, clicker, feed_count, breed, tame) end

---@param self MobEntity
---@param clicker ObjectRef
---@return boolean protected
function MobsRedo:protect(self, clicker) end

-- Riding helpers.
---@param entity MobEntity
---@param player ObjectRef
---@return nil
function MobsRedo.attach(entity, player) end

---@param player ObjectRef The player to detach from the mob
---@return nil
function MobsRedo.detach(player) end

---@param entity MobEntity The mob entity to fly
---@param moving_anim string The moving animation
---@param stand_anim string The standing animation
---@param can_fly boolean Can it fly
---@param dtime number The time
---@return nil
function MobsRedo.drive(entity, moving_anim, stand_anim, can_fly, dtime) end

---@param self MobEntity
---@param dtime number
---@param speed number
---@param can_shoot boolean
---@param arrow_entity EntityName
---@param move_animation string
---@param stand_animation string
---@return nil
function MobsRedo:fly(self, dtime, speed, can_shoot, arrow_entity, move_animation, stand_animation) end


---@param yaw number the targt yaw to set
---@param delay number the target delay
function MobsRedo:set_yaw(yaw, delay) end

---@param entity MobEntity
---@param anim string the name of the animation
---@param force? boolean should the animation be forced?
---@return nil
function MobsRedo.set_animation(entity, anim, force) end

-- Extra API functions mentioned in some changelogs/mirrors (signatures not fully specified in the 2017 HTML docs):
---@param self MobEntity
---@param clicker ObjectRef
---@return nil
function MobsRedo:force_capture(clicker) end

---@param velocity number|Vector3 The target velocity to set
---@return nil
function MobsRedo:set_velocity(velocity) end

---@return Vector3? value returns the velocity of this mob; or nil if not available
function MobsRedo:get_velocity() end

--- Sets the line of sight for the specified mob entity.
---@param entity MobEntity
---@param pos1 Vector3
---@param pos2 Vector3
---@return boolean
function MobsRedo.line_of_sight(entity, pos1, pos2) end

---@param target_entity EntityDefinition The target entity definition
function MobsRedo.compatibility_check(target_entity) end

---Sets the yaw of the target entity
---@param entity MobEntity The target mob entity to set the yaw on
---@param yaw number The target yaw
---@param delay number The delay to set the yaw parameter
function MobsRedo.yaw(entity, yaw, delay) end


---@param w? number the width scale
---@param h? number the height scale
---@param perma? boolean should the changes be permanent?
---@return nil
function MobsRedo:scale_mob(w, h, perma) end


---Particle helper used by many mobs_redo-based MobsRedo.
---Matches calls like: MobsRedo:effect(pos, 30, "nether_particle.png", 0.1, 2, 3, 5)
---@param pos Vector3 The position of the effect
---@param amount integer The amount of the effect
---@param texture string The texture used for the effect
---@param min_size? number The minimum size for the effect
---@param max_size? number The maximum size for the effect
---@param radius? number The radius of the effect
---@param gravity? number The gravity applied to it
---@param glow? number The glow for the effect
---@param fall? boolean Should the effect be falling or not
function MobsRedo.effect(pos, amount, texture, min_size, max_size, radius, gravity, glow, fall) end


---Removes the mob and decreases the counter
---@param target_entity MobEntity The target mob entity.
---@param decrease? boolean Whether we should decrease the counter or not.
function MobsRedo.remove(target_entity, decrease) end



mobs = MobsRedo

