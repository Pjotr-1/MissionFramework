-- =========================================================
-- MissionFramework - main.lua
-- Entry point
-- =========================================================

local MF = MissionFramework
local Logger = MF.Logger

Logger.Info("=== MissionFramework STARTED ===")
Logger.Info("MissionFramework version: " .. MissionFramework.GetVersion())

if not MF.Config then
    Logger.Error("Config missing")
    return
end

if not MF.FogManager then
    Logger.Error("FogManager missing")
    return
end

-- Start systems
MF.FogManager.Start()

Logger.Info("MissionFramework initialized")