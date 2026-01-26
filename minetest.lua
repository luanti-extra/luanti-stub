---@meta
--- DO NOT DIRECTLY USE THIS FILE!
--- It is intended to be used with VS Code's Lua language server as a library.
--- Nothing in here is implemented.


---@alias ObjectRef unknown ObjectRef has not yet been defined in this file
---@alias NoiseParams unknown NoiseParams has not yet been defined in this file
---@class VoxelManip VoxelManip has not yet been defined in this file
---@alias Raycast unknown Raycast has not yet been defined in this file
---@alias LSystemTreeDefinition table LSystemTreeDefinition has not yet been defined in this file

---@alias mapgen_aliases
---|"mapgen_stone"
---|"mapgen_river_water_source"
---|"mapgen_water_source"
---|"mapgen_lava_source"
---|"mapgen_dirt"
---|"mapgen_dirt_with_grass"
---|"mapgen_sand"
---|"mapgen_gravel"
---|"mapgen_desert_stone"
---|"mapgen_desert_sand"
---|"mapgen_dirt_with_snow"
---|"mapgen_snowblock"
---|"mapgen_snow"
---|"mapgen_ice"
---|"mapgen_tree"
---|"mapgen_leaves"
---|"mapgen_apple"
---|"mapgen_jungletree"
---|"mapgen_jungleleaves"
---|"mapgen_junglegrass"
---|"mapgen_pine_tree"
---|"mapgen_pine_needles"
---|"mapgen_cobble"
---|"mapgen_stair_cobble"
---|"mapgen_mossycobble"
---|"mapgen_stair_desert_stone"

--- The Minetest namespace for **5.5.1**, based entirely on lua_api.txt, with formatting changes.
minetest = {
    ---@return string modname The currently loading mod's name.
    ---returns the currently loading mod's name, when loading a mod.
    get_current_modname = function() end,

    ---@param modname string
    ---@return string|nil modpath Returns nil if the mod is not enabled or does not exist (not installed).
    --- returns the directory path for a mod, e.g. `"/home/user/.minetest/usermods/modname"`.
    --- * Returns nil if the mod is not enabled or does not exist (not installed).
    --- * Works regardless of whether the mod has been loaded yet.
    --- * Useful for loading additional .lua modules or static data from a mod, or checking if a mod is enabled.
    get_modpath = function(modname) end,

    ---@return string[] modnames
    --- returns a list of enabled mods, sorted alphabetically.
    --- * Does not include disabled mods, even if they are installed.
    get_modnames = function() end,

    ---@return string worldpath e.g. `"/home/user/.minetest/world"`
    --- Useful for storing custom data
    get_worldpath = function() end,

    ---@return boolean
    is_singleplayer = function() end,

    --- Table containing API feature flags
    features = {
        -- I was able to conveniently copy-paste this from lua_api.txt. enjoy

        glasslike_framed = true,        -- 0.4.7
        nodebox_as_selectionbox = true, -- 0.4.7
        get_all_craft_recipes_works = true, -- 0.4.7
        -- The transparency channel of textures can optionally be used on
        -- nodes (0.4.7)
        use_texture_alpha = true,
        -- Tree and grass ABMs are no longer done from C++ (0.4.8)
        no_legacy_abms = true,
        -- Texture grouping is possible using parentheses (0.4.11)
        texture_names_parens = true,
        -- Unique Area ID for AreaStore:insert_area (0.4.14)
        area_store_custom_ids = true,
        -- add_entity supports passing initial staticdata to on_activate
        -- (0.4.16)
        add_entity_with_staticdata = true,
        -- Chat messages are no longer predicted (0.4.16)
        no_chat_message_prediction = true,
        -- The transparency channel of textures can optionally be used on
        -- objects (ie: players and lua entities) (5.0.0)
        object_use_texture_alpha = true,
        -- Object selectionbox is settable independently from collisionbox
        -- (5.0.0)
        object_independent_selectionbox = true,
        -- Specifies whether binary data can be uploaded or downloaded using
        -- the HTTP API (5.1.0)
        httpfetch_binary_data = true,
        -- Whether formspec_version[<version>] may be used (5.1.0)
        formspec_version_element = true,
        -- Whether AreaStore's IDs are kept on save/load (5.1.0)
        area_store_persistent_ids = true,
        -- Whether minetest.find_path is functional (5.2.0)
        pathfinder_works = true,
        -- Whether Collision info is available to an objects' on_step (5.3.0)
        object_step_has_moveresult = true,
        -- Whether get_velocity() and add_velocity() can be used on players (5.4.0)
        direct_velocity_on_players = true,
        -- nodedef's use_texture_alpha accepts new string modes (5.4.0)
        use_texture_alpha_string_modes = true,
        -- degrotate param2 rotates in units of 1.5° instead of 2°
        -- thus changing the range of values from 0-179 to 0-240 (5.5.0)
        degrotate_240_steps = true,
        -- ABM supports min_y and max_y fields in definition (5.5.0)
        abm_min_max_y = true,
        -- dynamic_add_media supports passing a table with options (5.5.0)
        dynamic_add_media_table = true,
    },

    ---@param arg string|table<string,boolean>
    ---@return boolean, table<string,boolean> missing_features
    has_feature = function(arg) end,

    ---@param player_name string
    ---@return PlayerInformationTable?
    get_player_information = function(player_name) end,

    ---@param path string
    ---@return boolean success
    --- Creates a directory specified by `path`, creating parent directories
    --- if they don't exist.
    mkdir = function(path) end,

    ---@param path string
    ---@param recursive boolean
    ---@return boolean success
    --- Removes a directory specified by `path`.
    --- * If `recursive` is set to `true`, the directory is recursively removed.
    --- <br/>Otherwise, the directory will only be removed if it is empty.
    rmdir = function(path, recursive) end,

    ---@param source string
    ---@param destination string
    ---@return boolean success
    --- Copies a directory specified by `path` to `destination`
    --- * Any files in `destination` will be overwritten if they already exist.
    cpdir = function(source, destination) end,

    ---@param source string
    ---@param destination string
    ---@return boolean success
    --- Moves a directory specified by `path` to `destination`
    --- * If the `destination` is a non-empty directory, then the move will fail.
    mvdir = function(source, destination) end,

    ---@param path string
    ---@param is_dir boolean|nil?
    --- * `is_dir` is one of:
    ---   * `nil`: return all entries,
    ---   * `true`: return only subdirectory names, or
    ---   * `false`: return only file names.
    get_dir_list = function(path, is_dir) end,

    ---@param path string
    ---@param content unknown
    ---@return boolean success
    --- Replaces contents of file at path with new contents in a safe (atomic)
    --- way. Use this instead of below code when writing e.g. database files:
    --- ```
    --- local f = io.open(path, "wb"); f:write(content); f:close()
    --- ```
    safe_file_write = function(path, content) end,

    ---@return GetVersionTable
    --- Use this for informational purposes only. The information in the returned
    --- table does not represent the capabilities of the engine, nor is it
    --- reliable or verifiable. Compatible forks will have a different name and
    --- version entirely. To check for the presence of engine features, test
    --- whether the functions exported by the wanted features exist. For example:
    --- ```
    --- if minetest.check_for_falling then ... end
    --- ```
    get_version = function() end,

    ---@param data string data to hash
    ---@param raw boolean return raw bytes instead of hex digits; default: false
    ---@return string # the sha1 hash of `data`
    sha1 = function(data, raw) end,

    --- Converts a ColorSpec to a ColorString.
    --- If the ColorSpec is invalid, returns `nil`.
    ---@todo type later
    ---@return ColorString colorstring [ColorString](https://...)
    colorspec_to_colorstring = function(colorspec) end,

    --- Converts a ColorSpec to a rawstring of four bytes in an RGBA layout,
    --- returned as a string
    ---@todo type colorspec later
    ---@return string
    colorspec_to_bytes = function(colorspec) end,

    ---@param width integer Width of the image
    ---@param height integer Height of the image
    ---@param data unknown[]|string Image data, one of:
    ---|| * array table of ColorSpec, length must be width\*height
    ---|| * string with raw RGBA pixels, length must be width\*height\*4
    ---@param compression integer Optional zlib compression level, number in range 0 to 9.
    --- The data is one-dimensional, starting in the upper left corner of the image
    --- and laid out in scanlines going from left to right, then top to bottom.
    ---
    --- Please note that it's not safe to use string.char to generate raw data,
    --- use `colorspec_to_bytes` to generate raw RGBA values in a predictable way.
    ---
    --- The resulting PNG image is always 32-bit. Palettes are not supported at the moment.
    --- You may use this to procedurally generate textures during server init.
    encode_png = function(width, height, data, compression) end,

    --------------
    -- Logging  --
    --------------

    ---@param ... any
    --- Equivalent to `minetest.log(table.concat({...}, "\t"))`
    debug = function(...) end,

    ---@param level "none"|"error"|"warning"|"action"|"info"|"verbose" default: "none"
    log = function(level, text) end,

    ----------------------------
    -- Registration functions --
    ----------------------------

    ---@param name string in the format `namespace:name`, i.e. `default:dirt`
    ---@param definition NodeDefinition
    register_node = function(name, definition) end,

    ---@param name string in the format `namespace:name`, i.e. `default:stick`
    ---@param definition ItemDefinition
    register_craftitem = function(name, definition) end,

    ---@param name string in the format `namespace:name`, i.e. `zr_stone:pick`
    ---@param definition ItemDefinition
    register_tool = function(name, definition) end,

    ---@param name string in the format `namespace:name`, i.e. `default:mese`.
    ---@param redefinition ItemDefinition|NodeDefinition
    --- Overrides fields of an item registered with register_node/tool/craftitem.
    ---
    --- **Note:** Item must already be defined, (opt)depend on the mod defining it.
    ---
    --- Example:
    --- ```
    --- minetest.override_item("default:mese",
    ---   {light_source=minetest.LIGHT_MAX})
    --- ```
    override_item = function(name, redefinition) end,

    ---@param name string
    --- Unregisters the item from the engine, and deletes the entry with key
    --- `name` from `minetest.registered_items` and from the associated item table
    --- according to its nature: `minetest.registered_nodes`, etc.
    unregister_item = function(name) end,

    ---@param name string in the format `namespace:name`, i.e. `zr_stone:pick`
    ---@param definition unknown
    register_entity = function(name, definition) end,

    ---@param definition unknown
    register_abm = function(definition) end,

    ---@param definition unknown
    register_lbm = function(definition) end,

    ---@param alias string|mapgen_aliases
    ---@param original_name string
    --- Also use this to set the 'mapgen aliases' needed in a game for the core mapgens.
    --- See [Mapgen aliases](https://github.com/minetest/minetest/blob/5.5.1/doc/lua_api.txt#L336).
    register_alias = function(alias, original_name) end,

    ---@param alias string|mapgen_aliases
    ---@param original_name string
    register_alias_force = function(alias, original_name) end,

    ---@param definition unknown
    ---@return integer handle
    --- Returns an integer object handle uniquely identifying the registered
    --- ore on success.
    --- * The order of ore registrations determines the order of ore generation.
    register_ore = function(definition) end,

    ---@param definition unknown
    ---@return integer handle
    --- Returns an integer object handle uniquely identifying the registered
    --- biome on success. To get the biome ID, use `minetest.get_biome_id`.
    register_biome = function(definition) end,

    ---@param name string
    --- Unregisters the biome from the engine, and deletes the entry with key
    --- `name` from `minetest.registered_biomes`
    unregister_biome = function(name) end,

    ---@param definition unknown
    ---@return integer handle
    --- Returns an integer object handle uniquely identifying the registered
    ---   decoration on success. To get the decoration ID, use
    ---   `minetest.get_decoration_id`.
    --- * The order of decoration registrations determines the order of decoration
    ---   generation.
    register_decoration = function(definition) end,

    ---@param definition unknown
    ---@return integer handle
    --- Returns an integer object handle uniquely identifying the registered
    --- schematic on success.
    --- * If the schematic is loaded from a file, the `name` field is set to the
    ---   filename.
    --- * If the function is called when loading the mod, and `name` is a relative
    ---   path, then the current mod path will be prepended to the schematic
    ---   filename.
    register_schematic = function(definition) end,

    --- Clears all biomes currently registered.
    --- * **Warning:** Clearing and re-registering biomes alters the biome to biome ID
    ---   correspondences, so any decorations or ores using the 'biomes' field must
    ---   afterwards be cleared and re-registered.
    clear_registered_biomes = function() end,

    --- Clears all decorations currently registered.
    clear_registered_decorations = function() end,

    --- Clears all ores currently registered.
    clear_registered_ores = function() end,

    ---Clears all schematics currently registered.
    clear_registered_schematics = function() end,

    -----------------------------
    -- Registration / Gameplay --
    -----------------------------

    ---@param recipe unknown
    --- Check recipe table syntax for different types.
    register_craft = function(recipe) end,

    ---@param recipe unknown
    ---@return boolean
    --- Will erase existing craft based either on output item or on input recipe.
    --- * Specify either output or input only. If you specify both, input will be
    ---   ignored. For input use the same recipe table syntax as for
    ---   `minetest.register_craft(recipe)`. For output specify only the item,
    ---   without a quantity.
    --- * Returns false if no erase candidate could be found, otherwise returns true.
    --- * **Warning**! The type field ("shaped", "cooking" or any other) will be
    ---   ignored if the recipe contains output. Erasing is then done independently
    ---   from the crafting method.
    clear_craft = function(recipe) end,

    ---@param cmd string
    ---@param definition unknown
    register_chatcommand = function(cmd, definition) end,

    ---@param name string
    ---@param redefinition unknown
    --- Overrides fields of a chatcommand registered with `register_chatcommand`.
    override_chatcommand = function(name, redefinition) end,

    ---@param name string
    --- Unregisters a chatcommands registered with `register_chatcommand`.
    unregister_chatcommand = function(name) end,

    ---@param name string
    ---@param definition string|unknown
    --- If `definition` is a description, the priv will be granted to singleplayer and admin by default.
    --- * To allow players with `basic_privs` to grant, see the `basic_privs` minetest.conf setting.
    register_privilege = function(name, definition) end,

    ---@param definition unknown
    --- Registers an auth handler that overrides the builtin one.
    --- * This function can be called by a single mod once only.
    register_authentication_handler = function(definition) end,

    ----------------------------------------------------------
    -- Registraton / Global callback registration functions --
    ----------------------------------------------------------

    ---@param handler fun(dtime:number)
    --- Called every server step, usually interval of 0.1s
    register_globalstep = function(handler) end,

    ---@param handler fun()
    --- Called after mods have finished loading and before the media is cached
    --- or the aliases handled.
    register_on_mods_loaded = function(handler) end,

    ---@param handler fun()
    --- Called before server shutdown
    --- * **Warning**: If the server terminates abnormally (i.e. crashes), the
    --- registered callbacks **will likely not be run**. Data should be saved at
    --- semi-frequent intervals as well as on server shutdown.
    register_on_shutdown = function(handler) end,

    ---@param handler fun(pos, newnode, placer, oldnode, itemstack, pointed_thing): boolean?
    --- Called when a node has been placed
    --- * If return `true` no item is taken from `itemstack`
    --- * `placer` may be any valid ObjectRef or nil.
    --- * **Not recommended**; use `on_construct` or `after_place_node` in node
    --- definition whenever possible.
    ---@deprecated use `on_construct` or `after_place_node` in node definition whenever possible.
    register_on_placenode = function(handler) end,

    ---@param handler fun(pos, oldnode, digger)
    --- Called when a node has been dug.
    --- * **Not recommended**; use `on_destruct` or `after_dig_node` in node
    --- definition whenever possible.
    ---@deprecated use `on_destruct` or `after_dig_node` in node definition whenever possible.
    register_on_dignode = function(handler) end,

    ---@param handler fun(pos, node, puncher, pointed_thing)
    --- Called when a node is punched.
    register_on_punchnode = function(handler) end,

    ---@param handler fun(minp, maxp, blockseed)
    --- Called after generating a piece of world. Modifying nodes inside the area
    --- is a bit faster than usually.
    register_on_generated = function(handler) end,

    ---@param handler fun(player: unknown)
    register_on_newplayer = function(handler) end,

    ---@param handler fun(player: unknown, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    --- Called when a player is punched
    --- * Note: This callback is invoked even if the punched player is dead.
    --- * `player`: ObjectRef - Player that was punched
    --- * `hitter`: ObjectRef - Player that hit
    --- * `time_from_last_punch`: Meant for disallowing spamming of clicks
    ---   (can be nil).
    --- * `tool_capabilities`: Capability table of used item (can be nil)
    --- * `dir`: Unit vector of direction of punch. Always defined. Points from
    ---   the puncher to the punched.
    --- * `damage`: Number that represents the damage calculated by the engine
    --- * should return `true` to prevent the default damage mechanism
    register_on_punchplayer = function(handler) end,

    ---@param handler fun(player: unknown, clicker: unknown)
    --- Called when the 'place/use' key was used while pointing a player
    --- (not neccessarily an actual rightclick)
    --- * `player`: ObjectRef - Player that is acted upon
    --- * `clicker`: ObjectRef - Object that acted upon `player`, may or may not be a player
    register_on_rightclickplayer = function(handler) end,

    ---@alias PlayerHPChangeReason {type: "set_hp"|"punch"|"fall"|"node_damage"|"drown"|"respawn", from: "mod"|"engine", object: ObjectRef?, node: string?}
    ---@param handler fun(player, hp_change, reason): number?
    ---@param modifier boolean when true, the function should return the actual `hp_change`.
    --- * Called when the player gets damaged or healed
    --- * `player`: ObjectRef of the player
    --- * `hp_change`: the amount of change. Negative when it is damage.
    --- * `reason`: a PlayerHPChangeReason table.
    ---     * The `type` field will have one of the following values:
    ---         * `set_hp`: A mod or the engine called `set_hp` without
    ---                     giving a type - use this for custom damage types.
    ---         * `punch`: Was punched. `reason.object` will hold the puncher, or nil if none.
    ---         * `fall`
    ---         * `node_damage`: `damage_per_second` from a neighbouring node.
    ---                          `reason.node` will hold the node name or nil.
    ---         * `drown`
    ---         * `respawn`
    ---     * Any of the above types may have additional fields from mods.
    ---     * `reason.from` will be `mod` or `engine`.
    --- * **Note:** modifiers only get a temporary `hp_change` that can be modified by later modifiers.
    --- * Modifiers can return true as a second argument to stop the execution of further functions.
    --- * Non-modifiers receive the final HP change calculated by the modifiers.
    register_on_player_hpchange = function(handler, modifier) end,

    ---@param handler fun(player: ObjectRef, reason: PlayerHPChangeReason)
    --- Called when a player dies
    register_on_dieplayer = function(handler) end,

    ---@param handler fun(player: ObjectRef): boolean?
    --- Called when a player is to be respawned
    --- * Called _before_ repositioning of player occurs
    --- * return true in func to disable regular player placement
    register_on_respawnplayer = function(handler) end,

    ---@param handler fun(name: string, ip: string)
    --- Called before a player joins the server.
    --- * `name`: Name of the player
    --- * `ip`: IP of the player
    register_on_prejoinplayer = function(handler) end,

    ---@param handler fun(player: ObjectRef, last_login)
    --- Called when a player joins the game
    --- * `last_login`: The timestamp of the previous login, or nil if player is new
    register_on_joinplayer = function(handler) end,

    ---@param handler fun(player: ObjectRef, timed_out: boolean)
    --- Called when a player leaves the game
    --- * `timed_out`: True for timeout, false for other reasons.
    register_on_leaveplayer = function(handler) end,

    ---@param handler fun(name: string, ip: string, is_success: boolean)
    --- Called when a client attempts to log into an account.
    --- `name`: The name of the account being authenticated.
    --- * `ip`: The IP address of the client
    --- * `is_success`: Whether the client was successfully authenticated
    --- * For newly registered accounts, `is_success` will always be true
    register_on_authplayer = function(handler) end,

    ---@deprecated use `minetest.register_on_authplayer(name, ip, is_success)` instead.
    ---@param handler fun(name: string, ip: string)
    register_on_auth_fail = function(handler) end,

    ---@param handler fun(player: ObjectRef, cheat: "moved_too_fast"|"interacted_too_far"|"interacted_with_self"|"interacted_while_dead"|"finished_unknown_dig"|"dug_unbreakable"|"dug_too_fast")
    --- Called when a player cheats
    register_on_cheat = function(handler) end,

    ---@param handler fun(name: string, message: string)
    --- Called always when a player says something.
    ---
    --- Return `true` to mark the message as handled, which means that it will
    --- not be sent to other players.
    register_on_chat_message = function(handler) end,

    ---@param handler fun(player_name: string, command: string, params: unknown[])
    --- Called always when a chatcommand is triggered, before `minetest.registered_chatcommands`
    --- is checked to see if the command exists, but after the input is parsed.
    ---
    --- Return `true` to mark the command as handled, which means that the default
    --- handlers will be prevented.
    register_on_chatcommand = function(handler) end,

    ---@param handler fun(player, formname, fields)
    --- Called when the server received input from `player` in a formspec with
    --- the given `formname`. Specifically, this is called on any of the
    --- following events:
    ---   * a button was pressed,
    ---   * Enter was pressed while the focus was on a text field
    ---   * a checkbox was toggled,
    ---   * something was selected in a dropdown list,
    ---   * a different tab was selected,
    ---   * selection was changed in a textlist or table,
    ---   * an entry was double-clicked in a textlist or table,
    ---   * a scrollbar was moved, or
    ---   * the form was actively closed by the player.
    --- ---
    --- * Fields are sent for formspec elements which define a field. `fields`
    ---   is a table containing each formspecs element value (as string), with
    ---   the `name` parameter as index for each. The value depends on the
    ---   formspec element type:
    ---   * `animated_image`: Returns the index of the current frame.
    ---   * `button` and variants: If pressed, contains the user-facing button
    ---     text as value. If not pressed, is `nil`
    ---   * `field`, `textarea` and variants: Text in the field
    ---   * `dropdown`: Either the index or value, depending on the `index event`
    ---     dropdown argument.
    ---   * `tabheader`: Tab index, starting with `"1"` (only if tab changed)
    ---   * `checkbox`: `"true"` if checked, `"false"` if unchecked
    ---   * `textlist`: See `minetest.explode_textlist_event`
    ---   * `table`: See `minetest.explode_table_event`
    ---   * `scrollbar`: See `minetest.explode_scrollbar_event`
    ---   * Special case: `["quit"]="true"` is sent when the user actively
    ---     closed the form by mouse click, keypress or through a button_exit[]
    ---     element.
    ---   * Special case: `["key_enter"]="true"` is sent when the user pressed
    ---     the Enter key and the focus was either nowhere (causing the formspec
    ---     to be closed) or on a button. If the focus was on a text field,
    ---     additionally, the index `key_enter_field` contains the name of the
    ---     text field. See also: `field_close_on_enter`.
    --- * Newest functions are called first
    --- * If function returns `true`, remaining functions are not called
    register_on_player_receive_fields = function(handler) end,

    ---@param handler fun(itemstack, player, old_craft_grid, craft_inv)
    --- Called when `player` crafts something
    --- * `itemstack` is the output
    --- * `old_craft_grid` contains the recipe (Note: the one in the inventory is
    ---   cleared).
    --- * `craft_inv` is the inventory with the crafting grid
    --- * Return either an `ItemStack`, to replace the output, or `nil`, to not
    ---   modify it.
    register_on_craft = function(handler) end,

    ---@param handler fun(itemstack, player, old_craft_grid, craft_inv)
    --- The same as before, except that it is called before the player crafts, to
    --- make craft prediction, and it should not change anything.
    register_craft_predict = function(handler) end,

    ---@param handler fun(player, action, inventory, inventory_info)
    --- Determines how much of a stack may be taken, put or moved to a
    ---   player inventory.
    --- * `player` (type `ObjectRef`) is the player who modified the inventory
    ---   `inventory` (type `InvRef`).
    --- * List of possible `action` (string) values and their
    ---   `inventory_info` (table) contents:
    ---     * `move`: `{from_list=string, to_list=string, from_index=number, to_index=number, count=number}`
    ---     * `put`:  `{listname=string, index=number, stack=ItemStack}`
    ---     * `take`: Same as `put`
    --- * Return a numeric value to limit the amount of items to be taken, put or
    ---   moved. A value of `-1` for `take` will make the source stack infinite.
    register_allow_player_inventory_action = function(handler) end,

    ---@param handler fun(player, action, inventory, inventory_info)
    --- Called after a take, put or move event from/to/in a player inventory
    --- * Function arguments: see `minetest.register_allow_player_inventory_action`
    --- * Does not accept or handle any return value.
    register_on_player_inventory_action = function(handler) end,

    ---@param handler fun(pos: Vector3, name: string)
    --- Called by `builtin` and mods when a player violates protection at a
    --- position (eg, digs a node or punches a protected entity).
    --- * The registered functions can be called using
    ---   `minetest.record_protection_violation`.
    --- * The provided function should check that the position is protected by the
    ---   mod calling this function before it prints a message, if it does, to
    ---   allow for multiple protection mods.
    register_on_protection_violation = function(handler) end,

    ---@param handler fun(hp_change: number, replace_with_item, itemstack, user, pointed_thing)
    --- Called when an item is eaten, by `minetest.item_eat`
    --- * Return `itemstack` to cancel the default item eat response (i.e.: hp increase).
    register_on_item_eat = function(handler) end,

    ---@param handler fun(name: string, granter: string, priv: string)
    --- Called when `granter` grants the priv `priv` to `name`.
    --- * Note that the callback will be called twice if it's done by a player,
    ---   once with granter being the player name, and again with granter being nil.
    register_on_priv_grant = function(handler) end,

    ---@param handler fun(name: string, revoker: string, priv: string)
    --- Called when `revoker` revokes the priv `priv` from `name`.
    --- * Note that the callback will be called twice if it's done by a player,
    ---   once with revoker being the player name, and again with revoker being nil.
    register_on_priv_revoke = function(handler) end,

    ---@param handler fun(name: string, ip: string)
    --- Called when `name` user connects with `ip`.
    --- * Return `true` to by pass the player limit
    register_can_bypass_userlimit = function(handler) end,

    ---@param handler fun(channel_name: string, sender: string, message: string)
    --- Called when an incoming mod channel message is received
    --- * You should have joined some channels to receive events.
    --- * If message comes from a server mod, `sender` field is an empty string.
    register_on_modchannel_message = function(handler) end,

    ---@alias ItemStack unknown TODO: document ItemStack
    ---@param handler fun(pos_list: Vector3[], node_list: ItemStack[])
    --- Called after liquid nodes (`liquidtype ~= "none"`) are modified by the
    ---   engine's liquid transformation process.
    --- * `pos_list` is an array of all modified positions.
    --- * `node_list` is an array of the old node that was previously at the position
    ---   with the corresponding index in pos_list.
    register_on_liquid_transformed = function(handler) end,


    ---------------------
    -- Setting-related --
    ---------------------

    ---@type table<string, any>
    --- Settings object containing all of the settings from the
    --- main config file (`minetest.conf`).
    settings = {},

    ---@param name string The name of the setting to get.
    --- Loads a setting from the main settings and
    --- parses it as a position (in the format `(1,2,3)`). Returns a position or nil.
    ---@return Vector3
    setting_get_pos = function(name) end,

    ---@param str string
    ---@param delim? string String separating the privs. Defaults to `","`.
    ---@return table<string, boolean> privs A table of privs.
    --- Converts string representation of privs into table form
    string_to_privs = function(str, delim) end,

    ---@param privs table<string, boolean>
    ---@param delim? string String to delimit privs. Defaults to `","`.
    ---@return string
    --- Returns the string representation of `privs`
    privs_to_string = function(privs, delim) end,

    ---@param name string The name of the player.
    --- * *Calls the authentication handler.*
    ---@return table<string, boolean>
    get_player_privs = function(name) end,

    ---@param player_or_name string|ObjectRef Either a Player object or the name of a player.
    ---@param ... string|table<string, boolean> Either a list of strings, e.g. `"priva", "privb"` or a table, e.g. `{ priva = true, privb = true }`.
    ---@return boolean, table<string, boolean> missing_privs
    check_player_privs = function(player_or_name, ...) end,

    ---@param name string
    ---@param entry unknown
    ---@param password string
    --- Returns true if the "password entry" for a player with name matches given
    ---   password, false otherwise.
    --- * The "password entry" is the password representation generated by the
    ---   engine as returned as part of a `get_auth()` call on the auth handler.
    --- * **Only** use this function for making it possible to log in via password from
    ---   external protocols such as IRC, other uses are frowned upon.
    ---@return boolean
    ---@deprecated Only use this function for making it possible to log in via password from external protocols such as IRC, other uses are frowned upon.
    check_password_entry = function(name, entry, password) end,

    ---@param name string
    ---@param raw_password string
    --- Convert a name-password pair to a password hash that Minetest can use.
    --- * The returned value alone is not a good basis for password checks based
    ---   on comparing the password hash in the database with the password hash
    ---   from the function, with an externally provided password, as the hash
    ---   in the db might use the new SRP verifier format.
    --- * For this purpose, use `minetest.check_password_entry` instead.
    ---@return string
    get_password_hash = function(name, raw_password) end,

    ---@param name string
    --- returns an IP address string for the player `name`.
    --- * The player needs to be online for this to be successful.
    get_player_ip = function(name) end,

    --- Return the currently active auth handler
    --- * See the [Authentication handler definition](https://github.com/minetest/minetest/blob/5.5.1/doc/lua_api.txt#L8828)
    --- * Use this to e.g. get the authentication data for a player:
    --- ```
    --- local auth_data = minetest.get_auth_handler().get_auth(playername)
    --- ```
    ---@return unknown authentication_handler
    get_auth_handler = function() end,

    ---@param name? string if omitted, all auth data should be considered modified
    --- Must be called by the authentication handler for privilege changes.
    notify_authentication_modified = function(name) end,

    ---@param name string
    ---@param password_hash string
    --- Set password hash of player `name`.
    --- * *Calls the authentication handler.*
    set_player_password = function(name, password_hash) end,

    ---@param name string
    ---@param privs table<string, boolean>
    --- Set privileges of player `name`.
    --- * *Calls the authentication handler.*
    set_player_privs = function(name, privs) end,

    --- See `reload()` in authentication handler definition
    --- * *Calls the authentication handler.*
    auth_reload = function() end,

    ----------
    -- Chat --
    ----------

    ---@param text string
    chat_send_all = function(text) end,

    ---@param name string
    ---@param text string
    chat_send_player = function(name, text) end,

    ---@param name string
    ---@param message string
    --- Used by the server to format a chat message, based on the setting `chat_message_format`.
    ---   Refer to the documentation of the setting for a list of valid placeholders.
    --- * Takes player name and message, and returns the formatted string to be sent to players.
    --- * Can be redefined by mods if required, for things like colored names or messages.
    --- * **Only** the first occurrence of each placeholder will be replaced.
    format_chat_message = function(name, message) end,

    ------------------------
    -- Environment access --
    ------------------------
    ---@alias NodeWithMetadata {name: string, param1: number?, param2: number?, [string]: any}
    ---@param pos Vector3
    ---@param node NodeWithMetadata
    --- Set node at position `pos`
    --- * If param1 or param2 is omitted, it's set to `0`.
    --- ```
    --- minetest.set_node({x=0, y=10, z=0}, {name="default:wood"})`
    --- ```
    set_node = function(pos, node) end,
    add_node = minetest.set_node, -- alias to `minetest.set_node`

    ---@param pos Vector3[]
    ---@param node NodeWithMetadata
    --- Set node on all positions set in the first argument.
    --- * For node specification or position syntax see `minetest.set_node` call
    --- * Faster than set_node due to single call, but still considerably slower
    ---   than Lua Voxel Manipulators (LVM) for large numbers of nodes.
    ---   Unlike LVMs, this will call node callbacks. It also allows setting nodes
    ---   in spread out positions which would cause LVMs to waste memory.
    ---   For setting a cube, this is 1.3x faster than set_node whereas LVM is 20
    ---   times faster.
    --- ```
    --- minetest.bulk_set_node({{x=0, y=1, z=1}, {x=1, y=2, z=2}}, {name="default:stone"})`
    --- ```
    bulk_set_node = function(pos, node) end,

    ---@param pos Vector3
    ---@param node NodeWithMetadata
    --- Set node at position, but don't remove metadata
    swap_node = function(pos, node) end,

    ---@param pos Vector3
    --- By default it does the same as `minetest.set_node(pos, {name="air"})`
    remove_node = function(pos) end,

    ---@param pos Vector3
    --- Returns the node at the given position as table in the format
    --- `{name="node_name", param1=0, param2=0}`,
    --- returns `{name="ignore", param1=0, param2=0}` for unloaded areas.
    ---@return NodeWithMetadata
    get_node = function(pos) end,

    ---@param pos Vector3
    --- Same as `get_node` but returns `nil` for unloaded areas.
    get_node_or_nil = function(pos) end,

    ---@param pos Vector3 The position where to measure the light.
    ---@param timeofday number|nil `nil` for current time, `0` for night, `0.5` for day
    --- Gets the light value at the given position. Note that the light value
    --- "inside" the node at the given position is returned, so you usually want
    --- to get the light value of a neighbor.
    --- * `nil` is returned e.g. when the map isn't loaded at `pos`
    ---@return number|nil light_level A number between `0` and `15` or `nil`
    get_node_light = function(pos, timeofday) end,

    ---@param pos Vector3 The position of the node
    ---@param timeofday number|nil? `nil` for current time, `0` for night, `0.5` for day
    --- Figures out the sunlight (or moonlight) value at pos at the given time of
    --- day.
    --- This function tests 203 nodes in the worst case, which happens very
    --- unlikely
    ---@return number|nil light_level A number between `0` and `15` or `nil`
    get_natural_light = function(pos, timeofday) end,

    ---@param param1 number The param1 value of a `paramtype= "light"` node.
    --- Calculates the artificial light (light from e.g. torches) value from the
    --- `param1` value.
    --- * Currently it's the same as `math.floor(param1 / 16)`, except that it
    --- ensures compatibility.
    ---@return number light_level A number between `0` and `15`
    get_artificial_light = function(param1) end,

    ---@param pos Vector3
    ---@param node NodeWithMetadata --TODO: does this need to be a string?
    --- Place node with the same effects that a player would cause
    place_node = function(pos, node) end,

    ---@param pos Vector3
    --- Dig node with the same effects that a player would cause
    ---@return boolean # `true` if successful, `false` on failure (e.g. protected location)
    dig_node = function(pos) end,

    ---@param pos Vector3
    --- Punch node with the same effects that a player would cause
    punch_node = function(pos) end,

    ---@param pos Vector3
    --- Change node into falling node
    ---@return boolean, ObjectRef? spawned_entity `true` and the ObjectRef of the spawned entity if successful, `false` on failure
    spawn_falling_node = function(pos) end,

    ---@param pos1 Vector3
    ---@param pos2 Vector3
    --- Get a table of positions of nodes that have metadata within a region {pos1, pos2}.
    ---@return table<Vector3, NodeWithMetadata> --TODO: does this actually return a table, or just an array?
    find_nodes_with_meta = function(pos1, pos2) end,

    ---@param pos Vector3
    --- Get a `NodeMetaRef` at that position
    ---@todo return NodeMetaRef
    get_meta = function(pos) end,

    ---@param pos Vector3
    ---@param name string
    ---@param staticdata? table<string, any> --TODO: check this
    --- Spawn Lua-defined entity at position.
    ---@return ObjectRef|nil # `nil` if failed
    add_entity = function(pos, name, staticdata) end,

    ---@param pos Vector3
    ---@param item string (assuming an itemstring)
    --- Spawn item
    ---@return ObjectRef|nil
    add_item = function(pos, item) end,

    ---@param name string
    --- Get an `ObjectRef` to a player
    ---@return ObjectRef player
    get_player_by_name = function(name) end,

    ---@param pos Vector3
    ---@param radius number using an euclidean metric
    ---@return ObjectRef[]
    get_objects_inside_radius = function(pos, radius) end,

    ---@param pos1 Vector3 min position of the area to search
    ---@param pos2 Vector3 max position of the area to search
    ---@return ObjectRef[]
    get_objects_in_area = function(pos1, pos2) end,

    ---@param timeofday number between `0` and `1`; `0` for midnight, `0.5` for midday
    set_timeofday = function(timeofday) end,

    ---@return number timeofday between `0` and `1`; `0` for midnight, `0.5` for midday
    get_timeofday = function() end,

    ---@return number gametime the time, in seconds, since the world was created.
    get_gametime = function() end,

    ---@return number days the number of days elapsed since world was created.
    --- * accounts for time changes.
    get_day_count = function() end,

    ---@param pos Vector3
    ---@param radius number using a maximum metric
    ---@param nodenames string|string[]
    ---@param search_center boolean? default: `false`. If true `pos` is also checked for the nodes
    ---@return Vector3|nil pos
    find_node_near = function(pos, radius, nodenames, search_center) end,

    ---@param pos1 Vector3 min position of the area to search
    ---@param pos2 Vector3 max position of the area to search
    ---@param nodenames string|string[]
    --- * If `grouped` is true the return value is a table indexed by node name
    ---   which contains lists of positions.
    --- * If `grouped` is false or absent the return values are as follows:
    ---   first value: Table with all node positions
    ---   second value: Table with the count of each node with the node name
    ---   as index
    --- * Area volume is limited to 4,096,000 nodes
    ---@return Vector3[]|table<string, Vector3[]>, table<string, integer>?
    find_nodes_in_area = function(pos1, pos2, nodenames, grouped) end,

    ---@param pos1 Vector3
    ---@param pos2 Vector3
    ---@param nodenames string|string[]
    --- * Area volume is limited to 4,096,000 nodes
    ---@return Vector3[] # All node positions with a node air above
    find_nodes_in_area_under_air = function(pos1, pos2, nodenames) end,

    ---@todo document PerlinNoiseParams and perlin noise a bit further
    ---@param noiseparams NoiseParams
    --- Return world-specific perlin noise.
    --- * The actual seed used is the noiseparams seed plus the world seed.
    ---@return unknown # probably a number, but not sure
    ---@diagnostic disable-next-line: duplicate-index
    get_perlin = function(noiseparams) end,

    ---@deprecated use `minetest.get_perlin(noiseparams)` instead.
    --- Return world-specific perlin noise.
    ---@diagnostic disable-next-line: duplicate-index
    get_perlin = function(seeddiff, octaves, persistence, spread) end,

    ---@param pos1 Vector3?
    ---@param pos2 Vector3?
    --- Return voxel manipulator object.
    --- * Loads the manipulator from the map if positions are passed.
    ---@todo document voxel_manip
    get_voxel_manip = function(pos1, pos2) end,

    ---@param flags unknown
    ---@param deco_ids? string[] List of IDs of decorations which notification is requested for.
    ---@param custom_ids? string[]
    --- Set the types of on-generate notifications that should be collected.
    --- * `flags` is a flag field with the available flags:
    ---   * dungeon
    ---   * temple
    ---   * cave_begin
    ---   * cave_end
    ---   * large_cave_begin
    ---   * large_cave_end
    ---   * decoration
    set_gen_notify = function(flags, deco_ids, custom_ids) end,

    ---@return string, string[]
    get_gen_notify = function() end,

    ---@param decoration_name string
    ---@return integer|nil the decoration ID number for the provided decoration name string, or `nil` on failure.
    get_decoration_id = function(decoration_name) end,

    ---@param objectname string
    --- Return requested mapgen object if available (see [Mapgen objects](https://github.com/minetest/minetest/blob/5.5.1/doc/lua_api.txt#L4366)).
    ---@return table<string, any> mapgen_object
    get_mapgen_object = function(objectname) end,

    ---@param pos Vector3
    ---@return number|nil heat The heat at the position, or `nil` on failure.
    get_heat = function(pos) end,

    ---@param pos Vector3
    ---@return number|nil humidity The humidity at the position, or `nil` on failure.
    get_humidity = function(pos) end,

    ---@param pos Vector3
    --- Returns a table containing:
    ---   * `biome` the biome id of the biome at that position
    ---   * `heat` the heat at the position
    ---   * `humidity` the humidity at the position
    ---@return {biome: integer, heat: number, humidity: number}
    get_biome_data = function(pos) end,

    ---@param biome_name string
    ---@return number biome_id the biome id, as used in the biomemap Mapgen object and returned
    --- by `minetest.get_biome_data(pos)`, for a given biome_name string.
    get_biome_id = function(biome_name) end,

    ---@param biome_id integer
    --- * If no biomes have been registered, such as in mgv6, returns `default`.
    ---@return string biome_name the biome name string for the provided biome id, or `nil` on failure.
    get_biome_name = function(biome_id) end,

    ---@deprecated use `minetest.get_mapgen_setting(name)` instead.
    ---@return {mgname: string, seed: number, chunksize: integer, water_level: integer, flags: unknown}
    get_mapgen_params = function() end,

    ---@deprecateduse `minetest.set_mapgen_setting(name, value, override)` instead.
    ---@param params {mgname: string, seed: number, chunksize: integer, water_level: integer, flags: unknown}
    --- Set map generation parameters.
    --- * Function cannot be called after the registration period; only
    ---   initialization and `on_mapgen_init`.
    --- * Takes a table as an argument with the fields:
    ---     * `mgname`
    ---     * `seed`
    ---     * `chunksize`
    ---     * `water_level`
    ---     * `flags`
    --- * Leave field unset to leave that parameter unchanged.
    --- * `flags` contains a comma-delimited string of flags to set, or if the
    ---   prefix `"no"` is attached, clears instead.
    --- * `flags` is in the same format and has the same options as `mg_flags` in
    ---   `minetest.conf`.
    set_mapgen_params = function(params) end,

    ---@param name string
    --- Gets the *active* mapgen setting (or nil if none exists) in string
    --- format with the following order of precedence:
    ---   1) Settings loaded from map_meta.txt or overrides set during mod
    ---      execution.
    ---   2) Settings set by mods without a metafile override
    ---   3) Settings explicitly set in the user config file, minetest.conf
    ---   4) Settings set as the user config default
    ---@return any
    get_mapgen_setting = function(name) end,

    ---@param name string
    --- Same as above, but returns the value as a NoiseParams table if the
    --- setting `name` exists and is a valid NoiseParams.
    ---@return NoiseParams
    get_mapgen_setting_noiseparams = function(name) end,

    ---@param name string
    ---@param value any
    ---@param override_meta boolean? an optional boolean (default: `false`). If this is set to true, the setting will become the active setting regardless of the map metafile contents.
    --- Sets a mapgen param to `value`, and will take effect if the corresponding mapgen setting is not already present in map_meta.txt.
    --- * Note: to set the seed, use `"seed"`, not `"fixed_map_seed"`.
    set_mapgen_setting = function(name, value, override_meta) end,

    ---@param name string
    ---@param value NoiseParams
    ---@param override_meta boolean? an optional boolean (default: `false`). If this is set to true, the setting will become the active setting regardless of the map metafile contents.
    --- Same as `set_mapgen_setting`, except the value is a NoiseParams table.
    set_mapgen_setting_noiseparams = function(name, value, override_meta) end,

    ---@param name string
    ---@param noiseparams NoiseParams
    ---@param set_default any
    set_noiseparams = function(name, noiseparams, set_default) end,

    ---@param name string
    --- Returns a table of the noiseparams for name.
    ---@return NoiseParams
    get_noise_params = function(name) end,

    ---@param vm VoxelManip
    ---@param pos1 Vector3?
    ---@param pos2 Vector3?
    --- Generate all registered decorations within the VoxelManip `vm` and in the
    ---   area from `pos1` to `pos2`.
    --- * `pos1` and `pos2` are optional and default to mapchunk minp and maxp.
    generate_ores = function(vm, pos1, pos2) end,

    ---@param options {mode: "full"|"quick"}?
    --- Clear all objects in the environment
    --- * Takes an optional table as an argument with the field `mode`.
    ---   * mode = `"full"` : Load and go through every mapblock, clearing
    ---                       objects (default).
    ---   * mode = `"quick"`: Clear objects immediately in loaded mapblocks,
    ---                       clear objects in unloaded mapblocks only when the
    ---                       mapblocks are next activated.
    clear_objects = function(options) end,

    ---@param pos1 Vector3
    ---@param pos2 Vector3?
    --- Load the mapblocks containing the area from `pos1` to `pos2`.
    ---   `pos2` defaults to `pos1` if not specified.
    --- * This function does not trigger map generation.
    load_area = function(pos1, pos2) end,

    ---@alias EMERGE_ENUM integer
    ---@type EMERGE_ENUM
    EMERGE_CANCELLED = -1,
    ---@type EMERGE_ENUM
    EMERGE_ERRORED = -2,
    ---@type EMERGE_ENUM
    EMERGE_FROM_MEMORY = -3,
    ---@type EMERGE_ENUM
    EMERGE_FROM_DISK = -4,
    ---@type EMERGE_ENUM
    EMERGE_GENERATED = -5,

    ---@param pos1 Vector3
    ---@param pos2 Vector3
    ---@param callback fun(blockpos: Vector3, action: EMERGE_ENUM, calls_remaining: integer, param: any)?
    ---@param param any? user-defined parameter passed to `callback`
    --- Load the mapblocks containing the area from `pos1` to `pos2`.
    --- Queue all blocks in the area from `pos1` to `pos2`, inclusive, to be
    ---   asynchronously fetched from memory, loaded from disk, or if inexistent,
    ---   generates them.
    --- * If `callback` is a valid Lua function, this will be called for each block
    ---   emerged.
    --- * The function signature of callback is:
    ---   `function EmergeAreaCallback(blockpos, action, calls_remaining, param)`
    ---     * `blockpos` is the *block* coordinates of the block that had been
    ---       emerged.
    ---     * `action` could be one of the following constant values:
    ---         * `minetest.EMERGE_CANCELLED`
    ---         * `minetest.EMERGE_ERRORED`
    ---         * `minetest.EMERGE_FROM_MEMORY`
    ---         * `minetest.EMERGE_FROM_DISK`
    ---         * `minetest.EMERGE_GENERATED`
    ---     * `calls_remaining` is the number of callbacks to be expected after
    ---       this one.
    ---     * `param` is the user-defined parameter passed to emerge_area (or
    ---       nil if the parameter was absent).
    emerge_area = function(pos1, pos2, callback, param) end,

    ---@param pos1 Vector3
    ---@param pos2 Vector3
    --- delete all mapblocks in the area from pos1 to pos2, inclusive
    delete_area = function(pos1, pos2) end,

    ---@param pos1 Vector3 First position
    ---@param pos2 Vector3 Second position
    --- Checks if there is anything other than air between pos1 and pos2.
    --- * Returns false if something is blocking the sight.
    --- * Returns the position of the blocking node when `false`
    ---@return boolean, Vector3?
    line_of_sight = function(pos1, pos2) end,

    ---@param pos1 Vector3 start of the ray
    ---@param pos2 Vector3 end of the ray
    ---@param objects boolean if false, only nodes will be returned. Default is `true`.
    ---@param liquids boolean if false, liquid nodes (`liquidtype ~= "none"`) won't be returned. Default is `false`.
    --- Creates a `Raycast` object.
    ---@return Raycast
    raycast = function(pos1, pos2, objects, liquids) end,

    ---@param pos1 Vector3 start position
    ---@param pos2 Vector3 end position
    ---@param searchdistance number maximum distance from the search positions to search in.<br/>In detail: Path must be completely inside a cuboid. The minimum `searchdistance` of 1 will confine search between `pos1` and `pos2`. Larger values will increase the size of this cuboid in all directions
    ---@param max_jump number maximum height difference to consider walkable
    ---@param max_drop number maximum height difference to consider droppable
    ---@param algorithm "A*_noprefetch"|"A*"|"Dijkstra" Difference between `"A*"` and `"A*_noprefetch"` is that `"A*"` will pre-calculate the cost-data, the other will calculate it on-the-fly
    --- * returns table containing path that can be walked on
    --- * returns a table of 3D points representing a path from `pos1` to `pos2` or
    ---   `nil` on failure.
    --- * Reasons for failure:
    ---     * No path exists at all
    ---     * No path exists within `searchdistance` (see below)
    ---     * Start or end pos is buried in land
    ---@return Vector3[]|nil
    find_path = function(pos1, pos2, searchdistance, max_jump, max_drop, algorithm) end,

    ---@param pos Vector3
    ---@param treedef LSystemTreeDefinition
    --- spawns L-system tree at given `pos` with definition in `treedef` table
    spawn_tree = function(pos, treedef) end,

    ---@param pos Vector3
    --- add node to liquid flow update queue
    transforming_liquid_add = function(pos) end,

    ---@param pos Vector3
    --- get max available level for leveled node
    get_node_max_level = function(pos) end,

    ---@param pos Vector3
    --- get level of leveled node (water, snow)
    get_node_level = function(pos) end,

    ---@param pos Vector3
    ---@param level integer
    --- set level of leveled node, default `level` equals `1`
    --- * if `totallevel > maxlevel`, returns rest (`total-max`)
    --- * `level` must be between -127 and 127
    ---@return integer?
    set_node_level = function(pos, level) end,

    ---@param pos Vector3
    ---@param level integer
    --- increase level of leveled node by level, default `level` equals `1`
    --- * if `totallevel > maxlevel`, returns rest (`total-max`)
    --- * `level` must be between -127 and 127
    add_node_level = function(pos, level) end,

    ---@param pos1 Vector3
    ---@param pos2 Vector3
    --- resets the light in a cuboid-shaped part of
    ---   the map and removes lighting bugs.
    --- * Loads the area if it is not loaded.
    --- * `pos1` is the corner of the cuboid with the least coordinates
    ---   (in node coordinates), inclusive.
    --- * `pos2` is the opposite corner of the cuboid, inclusive.
    --- * The actual updated cuboid might be larger than the specified one,
    ---   because only whole map blocks can be updated.
    ---   The actual updated area consists of those map blocks that intersect
    ---   with the given cuboid.
    --- * However, the neighborhood of the updated area might change
    ---   as well, as light can spread out of the cuboid, also light
    ---   might be removed.
    ---@return boolean # `false` if the area is not fully generated, `true` otherwise
    fix_light = function(pos1, pos2) end,

    ---@param pos Vector3
    --- causes an unsupported `group:falling_node` node to fall and causes an
    ---   unattached `group:attached_node` node to fall.
    --- * does not spread these updates to neighbours.
    check_single_for_falling = function(pos) end,

    ---@param pos Vector3
    --- causes an unsupported `group:falling_node` node to fall and causes an
    ---   unattached `group:attached_node` node to fall.
    --- * spread these updates to neighbours and can cause a cascade
    ---   of nodes to fall.
    check_for_falling = function(pos) end,

    ---@param x number
    ---@param z number
    --- Returns a player spawn y co-ordinate for the provided (x, z)
    ---   co-ordinates, or `nil` for an unsuitable spawn point.
    --- * For most mapgens a 'suitable spawn point' is one with y between
    ---   `water_level` and `water_level + 16`, and in mgv7 well away from rivers,
    ---   so `nil` will be returned for many (x, z) co-ordinates.
    --- * The spawn level returned is for a player spawn in unmodified terrain.
    --- * The spawn level is intentionally above terrain level to cope with
    ---   full-node biome 'dust' nodes.
    ---@return number|nil y
    get_spawn_level = function(x, z) end,

    ------------------
    -- Mod channels --
    ------------------

    ---@param channel_name string
    --- Server joins channel `channel_name`, and creates it if necessary. You
    --- should listen for incoming messages with
    --- `minetest.register_on_modchannel_message`
    mod_channel_join = function(channel_name) end,


}

---Get a NodeTimerRef for a node position.
---@param pos Vector3
---@return NodeTimerRef
function minetest.get_node_timer(pos) end


core = minetest

----------------------------
--#region Response tables --
----------------------------

---@class PlayerInformationTable
--- The response type of `minetest.get_player_information`
local PlayerInformationTable = {
    ---@type string
    address = "127.0.0.1", -- IP address of client
    ---@type 4|6
    ip_version = 4,        -- IPv4 / IPv6
    ---@type integer
    connection_uptime = 200, -- seconds since client connected
    ---@type integer
    protocol_version = 32, -- protocol version used by client
    ---@type integer
    formspec_version = 2,  -- supported formspec version
    ---@type string
    lang_code = "fr",      -- Language code used for translation

    ---@type number?
    min_rtt = 0.01,  -- minimum round trip time (can be missing if no stats have been collected yet)
    ---@type number?
    max_rtt = 0.2,   -- maximum round trip time (can be missing if no stats have been collected yet)
    ---@type number?
    avg_rtt = 0.02,  -- average round trip time (can be missing if no stats have been collected yet)
    ---@type number?
    min_jitter = 0.01, -- minimum packet time jitter (can be missing if no stats have been collected yet)
    ---@type number?
    max_jitter = 0.5, -- maximum packet time jitter (can be missing if no stats have been collected yet)
    ---@type number?
    avg_jitter = 0.03, -- average packet time jitter (can be missing if no stats have been collected yet)

    ---@deprecated  Available in a debug build only!!! DO NOT USE IN MODS
    ser_vers = 26,           -- serialization version used by client (available in a debug build only!!! DO NOT USE IN MODS)
    ---@deprecated  Available in a debug build only!!! DO NOT USE IN MODS
    major = 0,               -- major version number (available in a debug build only!!! DO NOT USE IN MODS)
    ---@deprecated  Available in a debug build only!!! DO NOT USE IN MODS
    minor = 4,               -- minor version number (available in a debug build only!!! DO NOT USE IN MODS)
    ---@deprecated  Available in a debug build only!!! DO NOT USE IN MODS
    patch = 10,              -- patch version number (available in a debug build only!!! DO NOT USE IN MODS)
    ---@deprecated  Available in a debug build only!!! DO NOT USE IN MODS
    vers_string = "0.4.9-git", -- full version string (available in a debug build only!!! DO NOT USE IN MODS)
    ---@deprecated  Available in a debug build only!!! DO NOT USE IN MODS
    state = "Active"         -- current client state (available in a debug build only!!! DO NOT USE IN MODS)
}
---@class GetVersionTable
--- The response type of `minetest.get_version`
local GetVersionTable = {
    ---@type string
    project = "Minetest",            -- Name of the project, eg, "Minetest"
    ---@type string
    string = "5.5.1",                -- Simple version, eg, "1.2.3-dev"
    ---@type string?
    hash = "5.5.1-dev-44c2e33c-dirty", -- Full git version (only set if available)
}
--#endregion

----------------------------
--#region Class reference --
----------------------------

-- Put some classes
--#endregion
