FisheryTick = class("FisheryTick")
function FisheryTick:ctor()
    self._curTick = 0
    self._maxTick = 0
    self._syncTick = 0
    self._syncTickTime = 0
    self._syncTickInterval = 2000
    self._syncTickStartTime = 0
    self.startTime = 0
    self._canShowOldFreeze = true
    self.errorTick = 4000
    self._freezeTotalTick = 0

end
function FisheryTick:init()
    self._freezeTotalTick =cfg_skill.instance(1).lasttime / FightConst.fixed_update_time
    local milli = TimeTools.getCurMill()
    self._syncTickTime = milli
    self._syncTickStartTime = milli

end
function FisheryTick:update(delta)
    
    local milli = TimeTools.getCurMill()
    if FightM.instance.sceneId > 0 then
        self._curTick = self._syncTick + Mathf.Floor((milli - self._syncTickTime) / (1000 * GameConst.fixed_update_time))
        if self._curTick > self._maxTick then
            self._curTick = Mathf.Floor(self._curTick % self._maxTick)

        end
        if self._syncTickStartTime <= self._syncTickTime and (milli - self._syncTickTime) >= self._syncTickInterval then
            NetSender.SyncTick()
            self._syncTickStartTime = milli
        end
    end

end
function FisheryTick:onlineFight()
    return FightM.instance.sceneId > 0 and FightM.instance.seatId > 0

end
function FisheryTick:syncTick_12040(data)
    if fight.fishery.FisheryTick.instance:onlineFight() then
        if data and data.tick then
            local milli = TimeTools.getCurMill()
            local delayTick = Mathf.Floor((milli - self._syncTickStartTime) / (1000 * GameConst.fixed_update_time))
            self._syncTickTime = milli
            self._curTick = data.tick + delayTick
            if self._curTick > self._maxTick then
                self._curTick = Mathf.Floor(self._curTick % self._maxTick)

            end
            self._syncTick = self._curTick

        end

    end

end
function FisheryTick:syncTick_12017(data)

    self.startTime = TimeTools.getCurMill()
    self._curTick = data.tick
    self._syncTick = data.tick
    self._maxTick = data.maxTick

end
function FisheryTick:isVaiable()

    local time = TimeTools.getCurMill()
    local tickDiff = Mathf.Floor((time - self.startTime) / 20)
    if self._curTick + tickDiff > self._maxTick then
        return false

    end
    return true

end
function FisheryTick:isFirstEntry()

    local time = TimeTools.getCurMill()
    local tickDiff = Mathf.Floor((time - self.startTime) / 20)
    return tickDiff < self.errorTick

end
function FisheryTick:getRunTick(startTick)
    local ret = 0
    if self:isVaiable() then
        if self._curTick >= startTick then
            ret = self._curTick - startTick


        else
            if self:isFirstEntry() and startTick > self._curTick and self._curTick < self.errorTick and startTick > (self._maxTick - self.errorTick) then
                ret = self._maxTick - startTick + self._curTick


            else
                ret = 0

            end
        end


    else
        ret = 0

    end
    return ret

end
function FisheryTick:getCurTick()
    return self._curTick

end
function FisheryTick:getMaxTick()
    return self._maxTick

end
function FisheryTick:getFreezeLeftTick(freezeStartTick)
    local freezeLeftTick = 0
    if freezeStartTick and freezeStartTick > 0 then
        local freezeRun = self:getRunTick(freezeStartTick)
        if freezeRun <= 0 then
            return 0

        end
        if self._freezeTotalTick <= 0 then
            self._freezeTotalTick =cfg_skill.instance(1).lasttime / FightConst.fixed_update_time
        end
        freezeLeftTick = self._freezeTotalTick - freezeRun
        if freezeLeftTick < 0 then
            freezeLeftTick = 0

        end

    end
    return freezeLeftTick

end
function FisheryTick:syncFreeze(freezeStartTick)
    local freezeLeftTick = self:getFreezeLeftTick(freezeStartTick)
    if self._canShowOldFreeze and freezeLeftTick > 0 then
        self._canShowOldFreeze = false
        local freezeTime = freezeLeftTick * FightConst.fixed_update_time
        Fishery.instance:setFreeze(freezeTime)
    end

end

function FisheryTick:setCanShowOldFreeze(value)
    self._canShowOldFreeze = value
end

FisheryTick.instance = FisheryTick.new()
