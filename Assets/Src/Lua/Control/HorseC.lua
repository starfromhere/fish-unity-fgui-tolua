---@class HorseC
---@field public instance HorseC
HorseC = class("HorseC")
function HorseC:ctor()
    GameEventDispatch.instance:On(tostring(21000), self, self.syncHorseTip)
    GameEventDispatch.instance:On(tostring(21001), self, self.syncIsOpenNotice)

end

function HorseC:syncIsOpenNotice(data)
    if data.code == 1 then
        HorseM.instance:setIsOpenNotice(true)
    else
        HorseM.instance:setIsOpenNotice(false)
    end
end

function HorseC:loopNotice()
    GameTimer.once(HorseM.instance:getNoticeTime(), self, self.showNotice)
    if HorseM.instance:getOneTimesNotice() then
        GameTimer.once(HorseM.instance:getOneTimes(), self, self.loopRankHorseTips)
    end
end

function HorseC:loopRankHorseTips()
    if LevelM.instance:getRankDoubleReward() then
        HorseM.instance:setOneTimesNotice(false)
        cfg_hId.instance(tonumber(cfg_hourse.instance(7).txt1)).txtContent = LevelM.instance:loopMsg()
        local data = { id = 7, agent = true }
        HorseM.instance:addHorseTipItem(data)
        if HorseM.instance:getIsIn() == false then
            UIManager:LoadView("HorseTipPage")
        end
        HorseM.instance:setInfo()
    end
end

function HorseC:showNotice()
    if HorseM.instance:getIsOpenNotice() then
        local data = { id = 6, agent = true }
        HorseM.instance:addHorseTipItem(data)
        if HorseM.instance:getIsIn() == false then
            UIManager:LoadView("HorseTipPage")
        end
        HorseM.instance:setInfo()
    end
    self:loopNotice()
end
function HorseC:syncHorseTip(data)
    HorseM.instance:addHorseTipItem(data)
    if HorseM.instance:getIsIn() == false then
        UIManager:LoadView("HorseTipPage")
    end
    HorseM.instance:setInfo()
end
        