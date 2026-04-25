-- =========================================================
-- MissionFramework - core.lua
-- Core bootstrap and namespace initialization
-- =========================================================

-- Create global namespace once
MissionFramework = MissionFramework or {}

-- Versioning (useful for debugging)
MissionFramework.Version = "0.1.0"

-- Detect DCS environment
MissionFramework.IsDCS = env ~= nil

-- DEV mode detection
MissionFramework.IsDev = not MissionFramework.IsDCS

function MissionFramework.GetVersion()
    if MissionFramework.Build and MissionFramework.Build.Version then
        return MissionFramework.Build.Version
    end
    if MissionFramework.Config and MissionFramework.Config.Version then
        return MissionFramework.Config.Version
    end
    return "unknown"
end

if not env then
    dofile("test/dcs_mock.lua")
end

if MissionFramework.IsDev then
    print("[MF] Running in DEV mode")
end

