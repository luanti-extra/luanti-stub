---@meta

-- Climate API (climate_api) stub for LuaLS
-- Best-effort based on publicly visible usage + ContentDB docs.
-- Notes:
-- - register_weather(name, conditions, effects) is used by other mods (e.g. nether)
-- - docs mention weather names should be unique and typically prefixed like "mymod:awesome_weather"
-- - climate_api has more internal surface area; unknown fields are allowed via table<string, any> union.


---@class ClimateSkyData
---@field base_color ColorString|table|nil  -- often a string color; some APIs accept {r=,g=,b=} too
---@field type string|nil                  -- e.g. "plain", "regular", ...
---@field textures string[]|nil
---@field clouds boolean|nil

---@class ClimateCelestialBodyData
---@field visible boolean|nil
---@field sunrise_visible boolean|nil

---@class ClimateSkyboxDefinition
---@field sky_data ClimateSkyData|nil
---@field sun_data ClimateCelestialBodyData|nil
---@field moon_data ClimateCelestialBodyData|nil
---@field star_data ClimateCelestialBodyData|nil

---@alias ClimateInfluenceResult any
---@alias ClimateInfluenceCallback fun(pos: Vector3): ClimateInfluenceResult

-- Conditions passed to register_weather():
-- Example: { nether_biome = "nether" }
---@alias ClimateInfluenceConditions table<string, any>

-- Effects passed to register_weather():
-- Example: { ["climate_api:skybox"] = someSkyboxDefinitionTable }
---@alias ClimateEffects table<string, any>

---@class ClimateSkyboxModule
---@field add_layer fun(playername: string, layer_name: string, options: ClimateSkyboxDefinition): nil
---@field remove_layer fun(playername: string, layer_name: string): nil
---@field clear_layers fun(playername: string): nil
---@field has_layer fun(playername: string, layer_name: string): boolean

---@class ClimateAPI
---@field skybox ClimateSkyboxModule
---@field register_influence fun(name: string, callback: ClimateInfluenceCallback): nil
---@field register_weather fun(name: string, conditions: ClimateInfluenceConditions, effects: ClimateEffects): nil
---@field influences table<string, ClimateInfluenceCallback>
---@field weathers table<string, any>
---@field effects table<string, any>
---@field environment table<string, any>
---@field util table<string, any>

---@type ClimateAPI|table<string, any>
climate_api = climate_api or {}

---@type ClimateSkyboxModule|table<string, any>
climate_api.skybox = climate_api.skybox or {}
