StateFishFreeze = class("StateFishFreeze")

---@param fish Fish2D
function StateFishFreeze:enter(fish)
    fish:freezeIn()
end

---@param fish Fish2D
function StateFishFreeze:execute(fish)
    fish.freezeTime = fish.freezeTime - Time.deltaTime
    if fish.freezeTime < 0 then
        fish.fsm:changeState(StateFishRunning)
    end
end
---@param fish Fish2D
function StateFishFreeze:exit(fish)
    fish:freezeOut()
end
