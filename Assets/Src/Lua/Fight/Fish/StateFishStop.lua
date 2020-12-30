StateFishStop = class("StateFishStop")

---@param fish Fish2D
function StateFishStop:enter(fish)
    fish:destroy()
    Fishery.instance:removeFish(fish)
end
---@param fish Fish2D
function StateFishStop:execute(fish)
end

---@param fish Fish2D
function StateFishStop:exit(fish)
end