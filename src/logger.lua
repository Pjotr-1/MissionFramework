-- =========================================================
-- MissionFramework - logger.lua
-- Central logging system
-- =========================================================

MissionFramework = MissionFramework or {}
MissionFramework.Logger = MissionFramework.Logger or {}

local Logger = MissionFramework.Logger

-- Internal helper
local function output(message)
    if env and env.info then
        env.info(message)
    else
        print(message)
    end
end

function Logger.Info(msg)
    output("[MF] " .. tostring(msg))
end

function Logger.Warn(msg)
    output("[MF][WARN] " .. tostring(msg))
end

function Logger.Error(msg)
    output("[MF][ERROR] " .. tostring(msg))
end