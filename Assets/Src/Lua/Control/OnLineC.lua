---@class OnLineC
---@field public instance OnLineC
OnLineC = class("OnLineC")
function OnLineC:ctor()
    GameEventDispatch.instance:on(tostring(22001), self, self.get_online_award)
    GameEventDispatch.instance:on(tostring(22003), self, self.get_online_award_info)
    GameEventDispatch.instance:on(tostring(22004), self, self.sync_online_award_info)
    GameTimer.frameLoop(1, self, self.onLoop)

end

function OnLineC:onLoop()
    OnLineM.instance:timeTick(Time.deltaTime)

end
function OnLineC:get_online_award(data)
    local protoData = data
    if protoData.code == 0 then
        OnLineM.instance:setRewardIndex(protoData.id)
        OnLineM.instance:setLeftTime(protoData.lt)
        OnLineM.instance:setAwardId(protoData.id)
        GameEventDispatch.instance:event(GameEvent.OnlineAwardUpdate, protoData)
        GameEventDispatch.instance:event(GameEvent.RewardTip, { { 1 }, { protoData.awardNum } })
    else
        if 4 == protoData.code then
            GameTip.showTipById(42)
        else
            GameTools:dealCode(protoData.code)
        end
    end

end
function OnLineC:get_online_award_info(data)
    local protoData = data
    OnLineM.instance:setLeftTime(protoData.lt)
    OnLineM.instance:setAwardId(protoData.id)
    OnLineM.instance:setRewardIndex(protoData.id)
    GameEventDispatch.instance:event(GameEvent.OnlineAwardUpdate)

end
function OnLineC:sync_online_award_info(data)
    local protoData = data
    OnLineM.instance:setRewardIndex(protoData.id)
    OnLineM.instance:setLeftTime(protoData.lt)
    OnLineM.instance:setAwardId(protoData.id)
    GameEventDispatch.instance:event(GameEvent.OnlineAwardUpdate)

end
        