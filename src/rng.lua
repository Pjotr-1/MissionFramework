-- =========================================================
-- MissionFramework - rng.lua
-- Deterministic RNG (sandbox-safe)
-- =========================================================

MissionFramework = MissionFramework or {}
MissionFramework.RNG = MissionFramework.RNG or {}

---@class MissionFrameworkRNG
---@field seed number
local RNG = MissionFramework.RNG

-- Initialize seed using DCS-safe timers
RNG.seed = (timer and timer.getAbsTime() or 1) +
           math.floor((timer and timer.getTime() or 0) * 1000)

---Returns a random float in range [0,1)
---@return number
function RNG.Random()
    RNG.seed = (1103515245 * RNG.seed + 12345) % 2147483648
    return RNG.seed / 2147483648
end

---Returns a random integer in range [minValue, maxValue]
---@param minValue number
---@param maxValue number
---@return number
function RNG.RandomInt(minValue, maxValue)
    return minValue + math.floor(RNG.Random() * (maxValue - minValue + 1))
end

---Returns a random float in range [minValue, maxValue]
---@param minValue number
---@param maxValue number
---@return number
function RNG.RandomFloat(minValue, maxValue)
    return minValue + RNG.Random() * (maxValue - minValue)
end

---Returns a random element from a list
---@generic T
---@param list T[]
---@return T|nil
function RNG.Choice(list)
    if not list or #list == 0 then return nil end
    return list[RNG.RandomInt(1, #list)]
end