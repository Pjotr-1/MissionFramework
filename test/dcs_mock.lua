-- =========================================================
-- DCS Mock Environment
-- Used for local Lua 5.1 testing outside DCS.
-- =========================================================

env = {
    info = function(msg) print(msg) end,
    error = function(msg) print("ERROR: " .. tostring(msg)) end
}

timer = {
    _time = 0,
    _maxTicks = 30,

    getTime = function()
        return timer._time
    end,

    getAbsTime = function()
        return timer._time + 1000
    end,

    scheduleFunction = function(func, arg, startTime)
        local nextTime = startTime

        for i = 1, timer._maxTicks do
            timer._time = nextTime

            local result = func(arg, nextTime)

            if not result then
                print("[MOCK] Scheduler stopped")
                return nil
            end

            nextTime = result
        end

        print("[MOCK] Scheduler stopped after " .. tostring(timer._maxTicks) .. " ticks")
        return nextTime
    end
}

world = {
    weather = {
        _fogVisibility = 12000,
        _fogThickness = 800,

        getFogVisibilityDistance = function()
            return world.weather._fogVisibility
        end,

        getFogThickness = function()
            return world.weather._fogThickness
        end,

        setFogVisibilityDistance = function(value)
            world.weather._fogVisibility = value
            print("[MOCK] Fog visibility = " .. tostring(value))
        end,

        setFogThickness = function(value)
            world.weather._fogThickness = value
            print("[MOCK] Fog thickness = " .. tostring(value))
        end
    }
}