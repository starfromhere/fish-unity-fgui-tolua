---@class StateFishHit
StateFishHit = class("StateFishHit")

---@param fish Fish2D
function StateFishHit:enter(fish)
    --local fish = owner
    --if fish:canPlayHit() then
    --    fish:playHit()
    --    fish.lastHitEndTime = FightTools:nowSecond()
    --else
    --    fish.fsm:revertToPrevState()
    --end

    Log.debug("StateFishHit.enter")
end
---@param fish Fish2D
function StateFishHit:execute(fish)
    --if fish.freezeTime <= 0 then
    --    fish:pathUpdate(Time.deltaTime)
    --end
    --if fish:getNormalizedTime() >= 1 then
    --    fish.fsm:revertToPrevState()
    --end
end

---@param fish Fish2D
function StateFishHit:exit(fish)
end
