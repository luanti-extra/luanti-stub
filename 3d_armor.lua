---@meta
-- 3d_armor API stubs for LuaLS (Luanti/Minetest)
-- Main reference: https://minetest-mods.github.io/3d_armor/reference/topics/api.html


---@class PlayerMetaRef

-- Callback types (used by register_on_* and also commonly used as per-item callbacks in many 3d_armor setups)
---@alias ArmorOnEquipCallback fun(player: ObjectRef, index: integer, stack: ItemStack)
---@alias ArmorOnUnequipCallback fun(player: ObjectRef, index: integer, stack: ItemStack)
---@alias ArmorOnDamageCallback fun(player: ObjectRef, index: integer, stack: ItemStack)
---@alias ArmorOnDestroyCallback fun(player: ObjectRef, index: integer, stack: ItemStack)
---@alias ArmorOnPunchedCallback fun(player: ObjectRef, hitter: ObjectRef|nil, time_from_last_punch: number|nil, tool_capabilities: table|nil): (boolean|nil)

-- Groups table used by 3d_armor items.
-- Notes:
-- - armor_<element> marks which slot it goes into (head/torso/legs/feet/etc.)
-- - armor_heal / armor_use are core 3d_armor groups
-- - many games/mods also use armor_fire / armor_water / physics_* here
---@class ArmorDefGroups
---@field armor_head? integer
---@field armor_torso? integer
---@field armor_legs? integer
---@field armor_feet? integer
---@field armor_hands? integer
---@field armor_shield? integer
---@field armor_heal? integer
---@field armor_use? integer
---@field armor_fire? integer
---@field armor_water? integer
---@field physics_speed? number
---@field physics_jump? number
---@field physics_gravity? number
---@field [string] any

-- Armor protection groups (damage taken reduction), e.g. { fleshy = 10 }
---@alias ArmorProtectionGroups table<string, number>

-- Tool/weapon damage groups when used to hit, e.g. { cracky = 2, snappy = 1, level = 3 }
---@alias ArmorDamageGroups table<string, number>

-- ArmorDef is the definition table passed to armor:register_armor(name, def)
-- The minetest-mods LDoc lists the "core" fields below; in practice, many 3d_armor installations also accept
-- extra per-item callbacks and visual fields (texture/preview). If your local 3d_armor doesn’t use some of these,
-- they’re harmless in a stub. ([minetest-mods.github.io](https://minetest-mods.github.io/3d_armor/reference/topics/api.html))
---@class ArmorDef
---@field description string Human-readable description.
---@field inventory_image string Item icon texture.
---@field groups ArmorDefGroups Group values (armor slot + heal/use/etc.).
---@field armor_groups ArmorProtectionGroups Groups this armor protects against.
---@field damage_groups ArmorDamageGroups Groups this item is effective against as a tool/weapon.
---@field texture? string Optional: armor texture used on the 3d model (some setups).
---@field preview? string Optional: preview image used by some inventory integrations.
---@field reciprocate_damage? boolean Optional: if true, can damage attacker/tool in some setups.
---@field on_equip? ArmorOnEquipCallback Optional per-item equip callback.
---@field on_unequip? ArmorOnUnequipCallback Optional per-item unequip callback.
---@field on_damage? ArmorOnDamageCallback Optional per-item damage callback.
---@field on_destroy? ArmorOnDestroyCallback Optional per-item destroy callback.
---@field on_punched? ArmorOnPunchedCallback Optional per-item punched callback.

---@class ArmorAPI
local ArmorAPI = {}

-- Registers a new armor item.
---@param name string Armor item technical name (example: "3d_armor:helmet_gold")
---@param def ArmorDef
function ArmorAPI:register_armor(name, def) end

-- Registers a new armor group (custom protection group), with a base value.
---@param group string Group ID
---@param base integer Base armor value
function ArmorAPI:register_armor_group(group, base) end

-- Runs callbacks (internal helper, but exposed).
---@param callback function Function to execute
---@param player ObjectRef
---@param index integer
---@param stack ItemStack
function ArmorAPI:run_callbacks(callback, player, index, stack) end

-- Updates player visuals (model textures, etc).
---@param player ObjectRef
function ArmorAPI:update_player_visuals(player) end

-- Recomputes and applies player armor attributes.
---@param player ObjectRef
function ArmorAPI:set_player_armor(player) end

-- Called when an armored player is punched (applies wear, effects, etc).
---@param player ObjectRef Player wearing the armor
---@param hitter ObjectRef Entity attacking player
---@param time_from_last_punch? number
---@param tool_capabilities? table See Minetest entity damage mechanism
function ArmorAPI:punch(player, hitter, time_from_last_punch, tool_capabilities) end

-- Damages a single equipped armor stack.
---@param player ObjectRef
---@param index integer Armor inventory index
---@param stack ItemStack Armor stack being damaged
---@param use integer Wear amount to add
function ArmorAPI:damage(player, index, stack, use) end

-- Returns a list of equipped armor elements/types.
---@param player ObjectRef
---@return table List of equipped armors
function ArmorAPI:get_weared_armor_elements(player) end

-- Equip an armor ItemStack onto a player; returns leftover stack.
---@param player ObjectRef
---@param itemstack ItemStack
---@return ItemStack leftover
function ArmorAPI:equip(player, itemstack) end

-- Unequip an armor element/type from a player (e.g. "head", "torso", "legs", "feet", "shield"...).
---@param player ObjectRef
---@param armor_element string
function ArmorAPI:unequip(player, armor_element) end

-- Removes all worn armor without triggering callbacks.
---@param player ObjectRef
function ArmorAPI:remove_all(player) end

-- Get player's current skin filename.
---@param name string Player name
---@return string skin_filename
function ArmorAPI:get_player_skin(name) end

-- Trigger skin update.
---@param name string Player name
function ArmorAPI:update_skin(name) end

-- Add a preview image filename for armor inventory UI.
---@param preview string
function ArmorAPI:add_preview(preview) end

-- Get preview image filename for a player name.
---@param name string Player name
---@return string preview_filename
function ArmorAPI:get_preview(name) end

-- Get armor formspec for a player (optionally with listring).
---@param name string Player name
---@param listring? boolean
---@return string formspec
function ArmorAPI:get_armor_formspec(name, listring) end

-- Get armor element for an item name.
---@param item_name string
---@return any element
function ArmorAPI:get_element(item_name) end

-- Serialize armor inventory list.
---@param list table
---@return string
function ArmorAPI:serialize_inventory_list(list) end

-- Deserialize armor inventory list.
---@param list_string string
---@return table
function ArmorAPI:deserialize_inventory_list(list_string) end

-- Load armor inventory for player.
---@param player ObjectRef
---@return boolean ok
function ArmorAPI:load_armor_inventory(player) end

-- Save armor inventory for player (stored in player meta "3d_armor_inventory").
---@param player ObjectRef
function ArmorAPI:save_armor_inventory(player) end

-- DEPRECATED legacy inventory support.
---@param player any
function ArmorAPI:update_inventory(player) end

-- Set armor inventory stack at index.
---@param player ObjectRef
---@param i integer
---@param stack ItemStack
function ArmorAPI:set_inventory_stack(player, i, stack) end

-- Validate player and return (name, inv). Used as: local name, inv = armor:get_valid_player(...)
---@param player ObjectRef
---@param msg string
---@return string|nil player_name
---@return InvRef|nil inv
function ArmorAPI:get_valid_player(player, msg) end

-- Drops an armor item at position.
---@param pos Vector3
---@param stack ItemStack
function ArmorAPI.drop_armor(pos, stack) end

-- Allows selecting skin mod name manually (recognized: "simple_skins", "u_skins", "wardrobe").
---@param mod string
function ArmorAPI.set_skin_mod(mod) end

-- Register callbacks:
---@param func fun(player: ObjectRef, index: integer, stack: ItemStack)
function ArmorAPI:register_on_update(func) end

---@param func ArmorOnEquipCallback
function ArmorAPI:register_on_equip(func) end

---@param func ArmorOnUnequipCallback
function ArmorAPI:register_on_unequip(func) end

---@param func ArmorOnDamageCallback
function ArmorAPI:register_on_damage(func) end

---@param func ArmorOnDestroyCallback
function ArmorAPI:register_on_destroy(func) end

---@type ArmorAPI
armor = ArmorAPI
