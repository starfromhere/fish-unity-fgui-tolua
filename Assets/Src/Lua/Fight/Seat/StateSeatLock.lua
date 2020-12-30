---@class StateSeatLock
StateSeatLock = class("StateSeatLock")
---@param seat Seat
function StateSeatLock:enter(seat)
    if seat.lockFishUid then
        seat.lockFish = Fishery.instance:findFishByUniId(seat.lockFishUid)
    end
    if is_empty(seat.lockLine) then
        seat.lockLine = seat.playerComponent:GetChild("battery"):GetChild("lock")
        seat.lockCircle = seat.playerComponent:GetChild("battery"):GetChild("lockImg")
        FishLayer.instance.effectLayer:AddChild(seat.lockCircle)
        for i = 1, seat.lockLineSpriteNum do
            local item = seat.lockLine:GetChild("n" .. i)
            seat.lockLineSprites[i] = item
        end
    end

    seat.lockLine.visible = true
    seat.lockCircle.visible = true
    seat.isOpenAuto = true
end

---@param seat Seat
function StateSeatLock:execute(seat)
    if seat.lockRemainTime <= 0 then
        seat.fsm:revertToPrevState()
        return
    end

    if not seat.lockFish or not seat.lockFish:canBeLock() or not seat.lockFish:isInScreen() then
        if (seat.lockFishUid > 0) then
            local fish = Fishery.instance:findFishByUniId(seat.lockFishUid)
            if (fish and fish:canBeLock()) then
                seat.lockFish = fish
                seat.lockFishUid = 0;
            else
                seat.lockFish = Fishery.instance:chooseLockFish()
            end
        else
            seat.lockFish = Fishery.instance:chooseLockFish()
        end
        seat.lockFish = Fishery.instance:chooseLockFish()
    end
    if seat.lockFish then
        seat:lookAt(seat.lockFish:getLockPoint().x, seat.lockFish:getLockPoint().y)

        local distance = FightTools:distance2(seat.lockFish:getLockPoint().x, seat.shootStartX,
                seat.lockFish:getLockPoint().y, seat.shootStartY)

        local showNum = Mathf.Floor(distance / 70)
        for i, value in ipairs(seat.lockLineSprites) do
            value.visible = i < showNum
        end
        seat.lockCircle.x = seat.lockFish:getLockPoint().x
        seat.lockCircle.y = seat.lockFish:getLockPoint().y

        seat.mouseX = seat.lockFish:getLockPoint().x
        seat.mouseY = seat.lockFish:getLockPoint().y
        seat:shootContext()
        -- StateSeatNormal.execute(seat)
    end
    seat.lockRemainTime = seat.lockRemainTime - Time.deltaTime
end

---@param seat Seat
function StateSeatLock:exit(seat)
    seat.lockFish = nil
    seat.lockFishUid = nil
    seat.lockFishSid = nil
    seat.lockLine.visible = false
    seat.lockCircle.visible = false

    seat.isOpenAuto = false
end
