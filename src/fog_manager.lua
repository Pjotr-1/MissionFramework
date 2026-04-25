-- =========================================================
-- MissionFramework - fog_manager.lua
-- Dynamic fog controller
-- =========================================================

MissionFramework = MissionFramework or {}
MissionFramework.FogManager = MissionFramework.FogManager or {}

local MF = MissionFramework

---@type MissionFrameworkConfig
local Config = MF.Config

---@type MissionFrameworkRNG
local RNG = MF.RNG

---@class MissionFrameworkFogManager
---@field running boolean
---@field currentVisibility number
---@field currentThickness number
---@field startVisibility number
---@field startThickness number
---@field targetVisibility number
---@field targetThickness number
---@field startTime number
local FogManager = MF.FogManager

if not Config then
    error("[MF] Config missing - load order error")
end

---Apply fog values using DCS API
---@param visibility number
---@param thickness number
local function applyFog(visibility, thickness)
    if world and world.weather then
        if world.weather.setFogVisibilityDistance then
            world.weather.setFogVisibilityDistance(visibility)
        end
        if world.weather.setFogThickness then
            world.weather.setFogThickness(thickness)
        end
    end
end

---Get initial fog visibility
---@return number
local function getInitialVisibility()
    if world and world.weather and world.weather.getFogVisibilityDistance then
        local v = world.weather.getFogVisibilityDistance()
        if v and v > 0 then return v end
    end
    return Config.Fog.fallbackVisibility
end

---Get initial fog thickness
---@return number
local function getInitialThickness()
    if world and world.weather and world.weather.getFogThickness then
        local t = world.weather.getFogThickness()
        if t and t > 0 then return t end
    end
    return Config.Fog.fallbackThickness
end

---Start a new fog transition period
function FogManager.StartNewPeriod()
    FogManager.startVisibility = FogManager.currentVisibility
    FogManager.startThickness = FogManager.currentThickness

    FogManager.targetVisibility = RNG.RandomInt(
        Config.Fog.visibility.min,
        Config.Fog.visibility.max
    )

    FogManager.targetThickness = RNG.RandomInt(
        Config.Fog.thickness.min,
        Config.Fog.thickness.max
    )

    FogManager.startTime = timer.getTime()
end

---Update fog values over time (called by scheduler)
---@return number|nil Next update time
function FogManager.Update()
    if not FogManager.running then return nil end

    local now = timer.getTime()
    local duration = Config.Fog.periodSeconds
    local t = (now - FogManager.startTime) / duration

    if t >= 1 then
        FogManager.currentVisibility = FogManager.targetVisibility
        FogManager.currentThickness = FogManager.targetThickness

        applyFog(FogManager.currentVisibility, FogManager.currentThickness)

        FogManager.StartNewPeriod()
        return timer.getTime() + 1
    end

    local vis = math.floor(
        FogManager.startVisibility +
        (FogManager.targetVisibility - FogManager.startVisibility) * t
    )

    local thick = math.floor(
        FogManager.startThickness +
        (FogManager.targetThickness - FogManager.startThickness) * t
    )

    FogManager.currentVisibility = vis
    FogManager.currentThickness = thick

    applyFog(vis, thick)

    return timer.getTime() + 1
end

---Start fog system
function FogManager.Start()
    if not Config.Fog.enabled then return end

    FogManager.currentVisibility = getInitialVisibility()
    FogManager.currentThickness = getInitialThickness()

    FogManager.running = true

    FogManager.StartNewPeriod()

    timer.scheduleFunction(function()
        return FogManager.Update()
    end, nil, timer.getTime() + 1)
end