---@class RuleM
---@field public instance RuleM
RuleM = class("RuleM")
function RuleM:ctor()
    self._integral = nil
    self._url = nil
    self._coinCount = nil
    self._goodsId = 0
    self._hour = nil
    self._minute = 0
    self._second = 0
    self._islist = true
    self._totalTime = 0
    self._activityID = nil
    self._activityNum = nil
    self._coinCount = 0

end
function RuleM:isRewardShowScene()
    if FightM.instance.sceneId == 4 or FightM.instance.sceneId == 1 then
        return false
    end
    return true
end

function RuleM:isShowScene()
    --if FightM.instance.sceneId == 4 then
    --    return true
    --end
    return true
end

function RuleM:second(value)
    if nil == value then
        return tonumber(self._second)
    else
        self._second = value
    end
end

function RuleM:minute(value)
    if nil == value then
        return tonumber(self._minute)
    else
        self._minute = value
    end
end

function RuleM:hour(value)
    if nil == value then
        return tonumber(self._hour)
    else
        self._hour = value
    end
end

function RuleM:goodsId(value)
    if nil == value then
        return self._goodsId
    else
        self._goodsId = value
    end
end

function RuleM:imageUrl()
    local cfg = cfg_goods.instance(self._goodsId)
    return cfg.icon
end

function RuleM:coinCount(value)
    if nil == value then
        return self._coinCount
    else
        self._coinCount = value
    end
end

function RuleM:totalTime(value)
    if nil == value then
        return Math.floor(self._totalTime)
    else
        self._totalTime = value
    end
end

function RuleM:setTime(time)
    if time ~= nil then
        self:hour(os.date("%H", time))
        self:minute(59 - os.date("%M", time))
        self:second(59 - os.date("%S", time))
        if self:second() < 0 then
            self:second(59)
        end
        GameEventDispatch.instance:Event(GameEvent.UpdateTime)
    end
end

function RuleM:showTime()
    local min = self:minute()
    local sec = self:second()
    local hou = self:hour()
    if min < 10 then
        min = "0" .. min
    end
    if sec < 10 then
        sec = "0" .. sec
    end
    if hou < 10 then
        hou = "0" .. hou
    end
    local showtime = "倒计时：00:" .. min .. ":" .. sec
    return showtime
end

function RuleM:activityID(value)
    if nil == value then
        return self._activityID
    else
        self._activityID = value
    end
end

function RuleM:activityNum(value)
    if nil == value then
        return self._activityNum
    else
        self._activityNum = value
    end
end

