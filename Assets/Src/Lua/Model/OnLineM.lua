---@class OnLineM
---@field public instance OnLineM
OnLineM = class("OnLineM")

function OnLineM:ctor()
    self._index = 1
    self._isAni = false
    OnLineM._awardId = -1
    OnLineM._leftTime = 0
end

function OnLineM:getAwardStatus(awardId)
    if OnLineM._awardId < 0 then
        return FightConst.online_award_status_getted;
    end
    if awardId < OnLineM._awardId then
        return FightConst.online_award_status_getted;
    elseif awardId > OnLineM._awardId then
        return FightConst.online_award_status_not_start;
    end
    return FightConst.online_award_status_start;
end

function OnLineM:getRewardStatus(awardId)
    return nil
end

function OnLineM:timeTick(delta)
    if OnLineM._leftTime > 0 then
        OnLineM._leftTime = OnLineM._leftTime - delta
        if OnLineM._leftTime <= 0 then
            GameEventDispatch.instance:event(GameEvent.StartRefersh)
            self:list()
        end
    end
end

function OnLineM:getAwardState(id)
    local _onlineList = {}
    local idArr = self:idArr()
    for i, value in ipairs(idArr) do
        local online = cfg_onLine.instance(tonumber(idArr[i]))
        if self:getAwardStatus(idArr[i]) == 1 then
            table.insert(_onlineList, { count = online.rewardCount, name = "未领取", rewardUrl = "ui/fish/lqjl_1.png", enable = false, isVisible = true, isTimeVisible = true })
        elseif self:getAwardStatus(idArr[i]) == 3 then
            table.insert(_onlineList, { count = online.rewardCount, name = "未领取", rewardUrl = "ui/fish/lqjl_1.png", enable = false, isVisible = true, isTimeVisible = true })
        elseif self:getAwardStatus(idArr[i]) == 2 and self:getLeftTime() <= 0 then
            table.insert(_onlineList, { count = online.rewardCount, name = "可以领取", rewardUrl = "ui/fish/lqjl_1.png", enable = true, isVisible = true, isTimeVisible = false })
        else
            table.insert(_onlineList, { count = online.rewardCount, name = "未领取", rewardUrl = "ui/fish/lqjl_1.png", enable = false, isVisible = true, isTimeVisible = true })
        end
    end

    if id >= #_onlineList or id < 0 then
        local obj = { count = "", name = "未领取", rewardUrl = "ui/fish/lqjl_3.png", enable = false, isVisible = false, isTimeVisible = true }
        return obj
    else
        return _onlineList[id]
    end
end

function OnLineM:imageUrl(goodsId)
    local goods = cfg_goods.instance(tonumber(goodsId))
    return goods.icon
end

function OnLineM:vipTime(id)
    local cfg = cfg_onLine.instance(tonumber(id))
    return cfg.vipTimes
end

function OnLineM:idArr()
    local arr = {}
    local items = ConfigManager.items("cfg_onLine")
    for k, v in pairs(items) do
        if k ~= "instance" then
            table.insert(arr, tonumber(k))
        end
    end
    return arr
end

function OnLineM:list()
    local listArr = {}
    local can_acc = false;
    local idArr = self:idArr()
    for i, v in ipairs(idArr) do
        local online = cfg_onLine.instance(tonumber(idArr[i]))
        if self:getAwardState(idArr[i]) == GameConst.online_award_status_getted then
            table.insert(listArr, {
                icon = { skin = self:imageUrl(online.rewardID) },
                coinLabel = { text = online.rewardCount },
                reaminTime = { text = online.receiveTime },
                receiveBtn = { gray = true, mouseEnabled = false },
                receivelabel = { text = "已领取", gray = true }
            })
        elseif self:getAwardStatus(idArr[i]) == GameConst.online_award_status_not_start then
            table.insert(listArr, {
                icon = { skin = self:imageUrl(online.rewardID) },
                coinLabel = { text = online.rewardCount },
                reaminTime = { text = online.receiveTime },
                receiveBtn = { gray = true, mouseEnabled = false },
                receivelabel = { text = "领取", gray = true }
            })
        elseif self:getAwardStatus(idArr[i]) == GameConst.online_award_status_start and self:getLeftTime() <= 0 then
            can_acc = true;
            table.insert(listArr, {
                icon = { skin = self:imageUrl(online.rewardID) },
                coinLabel = { text = online.rewardCount },
                reaminTime = { text = online.receiveTime },
                receiveBtn = { gray = true, mouseEnabled = false },
                receivelabel = { text = "领取", gray = false }
            })
        else
            table.insert(listArr, {
                icon = { skin = self:imageUrl(online.rewardID) },
                coinLabel = { text = online.rewardCount },
                reaminTime = { text = online.receiveTime },
                receiveBtn = { gray = true, mouseEnabled = false },
                receivelabel = { text = "领取", gray = true }
            })
        end
    end
    return listArr
end

function OnLineM:imageUrl(goodsId)
    local goods = cfg_goods.instance(tonumber(goodsId));
    return goods.icon;
end

OnLineM._awardId = 0
OnLineM._leftTime = nil

---@return boolean
function OnLineM:getIsAni()
    return self._isAni;
end
---@param ani boolean
function OnLineM:setIsAni(ani)
    self._isAni = ani;
end
---@return number
function OnLineM:getRewardIndex()
    return self._index;
end
---@param index number
function OnLineM:setRewardIndex(index)
    self._index = index;
end
---@return number
function OnLineM:getLeftTime()
    return OnLineM._leftTime
end

---@param leftTime number
function OnLineM:setLeftTime(leftTime)
    OnLineM._leftTime = leftTime;
end

---@param id number
function OnLineM:setAwardId(id)
    OnLineM._awardId = id;
end
