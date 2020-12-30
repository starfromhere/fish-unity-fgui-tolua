---@class RTipC
---@field public instance RTipC
RTipC = class("RTipC")
function RTipC:ctor()
    GameEventDispatch.instance:On(GameEvent.RewardTip, self, self.RewardTip)

end
function RTipC:RewardTip(data)
    local dataOne = data[1]
    local dataTwo = data[2]
    local isShow = data[3]
    local delay = data[4]
    if #dataOne > 0 and #dataTwo > 0 then
        RTipM:setInfo(dataOne, dataTwo, isShow)
        UIManager:LoadView("RewardTipPage", { delay = delay },UIEffectType.NORMAL)
    end

end 