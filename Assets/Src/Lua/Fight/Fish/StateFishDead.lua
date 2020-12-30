StateFishDead = class("StateFishDead")

---@param fish Fish2D
function StateFishDead:enter(fish)
    fish:changeDelayRemove()
    fish:playDeath()
end
---@param fish Fish2D
function StateFishDead:execute(fish)
    --if fish.fishCfg.ctype ~= FightConst.fish_catch_type_award_change and
    --        (fish.fishCfg.ctype < FightConst.fish_catch_type_boss_awake or
    --                fish.fishCfg.ctype > FightConst.fish_catch_type_boss_max_awake)
    --then
    --    fish:pathUpdate(Time.deltaTime)
    --end

    if fish.delayRemove then
        if fish:getDeathAniTime() >= 1 then
            fish.fsm:changeState(StateFishStop)
            fish.delayRemove = false
        end
    end
end

---@param fish Fish2D
function StateFishDead:exit(fish)
end
