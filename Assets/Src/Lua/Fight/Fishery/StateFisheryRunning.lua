---@class StateFisheryRunning
---@field public instance StateFisheryRunning
StateFisheryRunning = class("StateFisheryRunning")

---@param fishery Fishery
function StateFisheryRunning:enter(fishery)
    fishery:startLoop()
end

---@param fishery Fishery
function StateFisheryRunning:execute(fishery)
end

---@param fishery Fishery
function StateFisheryRunning:exit(owfisheryner)
end