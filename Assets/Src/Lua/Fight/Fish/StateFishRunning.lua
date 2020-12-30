StateFishRunning = class("StateFishRunning")
---@param fish Fish2D
function StateFishRunning:enter(fish)
    fish:playSwim()
end

---@param fish Fish2D
function StateFishRunning:execute(fish)
    fish:pathUpdate(Time.deltaTime)
    if fish.pathResult.isOver then
        fish.fsm:changeState(StateFishStop)
    end

    ---判断鳄鱼咬炮台逻辑
    if fish.path.needHit and not fish.path.isOver then
        fish:playAttack()

        GameTimer.once(1500, self, function()
            fish.path.targetSeat:showDropParts()
            fish.path.targetSeat:playBatteryDoudong()
        end)
        fish.path.needHit = false
        fish.path.haveHit = true
    end
end

---@param fish Fish2D
function StateFishRunning:exit(fish)
end


