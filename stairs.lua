---@meta
-- Minetest Game "stairs" API stub for LuaLS (EmmyLua annotations).
-- Notes:
-- - `stairs` is provided by the "stairs" mod (MTG or a compatible replacement).
-- - API details (especially extra features) may vary between implementations.
--   Example: "Stairs Redo" is a drop-in replacement that adds extra shapes. ([content.luanti.org](https://content.luanti.org/packages/TenPlus1/stairs/))


---@alias TileDef string|table<string, any>|any         -- MT tile definition can be string or a table


---@class StairsAPI
stairs = {}


-- Registers a normal stair: "stairs:stair_<subname>"
---@param subname string
---@param recipeitem? NodeName        -- may be nil in some APIs ([scribd.com](https://www.scribd.com/document/857159478/game-api))
---@param groups? table<string, integer>
---@param images? TileDef[]|TileDef
---@param description? string
---@param sounds? SoundSpec
---@param worldaligntex? boolean      -- if true, textures are world-aligned ([scribd.com](https://www.scribd.com/document/857159478/game-api))
function stairs.register_stair(subname, recipeitem, groups, images, description, sounds, worldaligntex) end

-- Registers a slab: "stairs:slab_<subname>"
---@param subname string
---@param recipeitem? NodeName
---@param groups? table<string, integer>
---@param images? TileDef[]|TileDef
---@param description? string
---@param sounds? SoundSpec
---@param worldaligntex? boolean
function stairs.register_slab(subname, recipeitem, groups, images, description, sounds, worldaligntex) end

-- Registers an inner corner stair: "stairs:stair_inner_<subname>"
---@param subname string
---@param recipeitem? NodeName
---@param groups? table<string, integer>
---@param images? TileDef[]|TileDef
---@param description? string
---@param sounds? SoundSpec
---@param worldaligntex? boolean
---@param full_description? string    -- overrides description building; useful for translation ([scribd.com](https://www.scribd.com/document/857159478/game-api))
function stairs.register_stair_inner(subname, recipeitem, groups, images, description, sounds, worldaligntex,
                                     full_description)
end

-- Registers an outer corner stair: "stairs:stair_outer_<subname>"
---@param subname string
---@param recipeitem? NodeName
---@param groups? table<string, integer>
---@param images? TileDef[]|TileDef
---@param description? string
---@param sounds? SoundSpec
---@param worldaligntex? boolean
---@param full_description? string
function stairs.register_stair_outer(subname, recipeitem, groups, images, description, sounds, worldaligntex,
                                     full_description)
end

-- Convenience wrapper registering stair + slab (+ inner/outer in implementations that support them)
---@param subname string
---@param recipeitem? NodeName
---@param groups? table<string, integer>
---@param images? TileDef[]|TileDef
---@param desc_stair? string
---@param desc_slab? string
---@param sounds? SoundSpec
---@param worldaligntex? boolean
---@param desc_stair_inner? string
---@param desc_stair_outer? string
function stairs.register_stair_and_slab(
    subname,
    recipeitem,
    groups,
    images,
    desc_stair,
    desc_slab,
    sounds,
    worldaligntex,
    desc_stair_inner,
    desc_stair_outer
)
end
