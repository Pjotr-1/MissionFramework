-- =========================================================
-- MissionFramework - config.lua
-- Global configuration
-- =========================================================

---@class MissionFrameworkFogRange
---@field min number
---@field max number

---@class MissionFrameworkFogConfig
---@field enabled boolean
---@field periodSeconds number
---@field visibility MissionFrameworkFogRange
---@field thickness MissionFrameworkFogRange
---@field fallbackVisibility number
---@field fallbackThickness number

---@class MissionFrameworkMissionConfig
---@field Name string

---@class MissionFrameworkConfig
---@field Debug boolean
---@field Mission MissionFrameworkMissionConfig
---@field Fog MissionFrameworkFogConfig

MissionFramework = MissionFramework or {}

---@type MissionFrameworkConfig
MissionFramework.Config = {
    Version = "0.1.0",
    Debug = true,

    Mission = {
        Name = "BEIRUT-1"
    },

    Fog = {
        enabled = true,
        periodSeconds = 10,

        visibility = {
            min = 500,
            max = 2500
        },

        thickness = {
            min = 1200,
            max = 3500
        },

        fallbackVisibility = 12000,
        fallbackThickness = 800
    }
}