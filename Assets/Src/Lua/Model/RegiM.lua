---@class RegiM
---@field public instance RegiM
RegiM = class("RegiM")
function RegiM:ctor()
    self.state = nil
    self.registerDiSkin = "touxiang1.png"
    self.unregisterDiSkin = "touxiang0.png"
    self._isRegic = false
    self._isToday = false
    self._finishDays = 0
end

function RegiM:isToday(value)
    if value == nil then
        return self._isToday
    else
        self._isToday = value
    end
end

function RegiM:isRegic(value)
    if value == nil then
        return self._isRegic
    else
        self._isRegic = value
    end
end

function RegiM:finishDays(value)
    if value == nil then
        return self._finishDays
    else
        self._finishDays = value
    end
end

function RegiM:skinInd(rewardId)
    local goods = cfg_goods.instance(tostring(rewardId))
    return goods.typeID
end

function RegiM:isShowVip(reward)
    if reward.db_vip == 0 then
        return false
    else
        return true
    end
end

function RegiM:getVipTime(reward)
    return "v" .. tostring(reward.db_vip)
end

function RegiM:imageUrl(goodsId, id)
    local goods = ConfigManager.getConfObject("cfg_goods", goodsId)
    if goods.type == 7 then
        if RoleInfoM.instance:isSkinExit(goods.typeID) then
            local m = ConfigManager.getConfObject("cfg_register", id)
            local mId = m.replace_reward_id
            local n = ConfigManager.getConfObject("cfg_goods", mId)
            return n.icon
        end
    end
    return goods.icon
end

function RegiM:rewardCount(goodsId, id)
    local goods = ConfigManager.getConfObject("cfg_goods", goodsId)
    local m = ConfigManager.getConfObject("cfg_register", id)
    local num = m.rewardCount
    if goods.type == 7 then
        if RoleInfoM.instance:isSkinExit(goods.typeID) then
            num = m.replace_reward_count
        end
    end
    return num
    --return ActivityM.instance:exchangeConversion(goodsId, num)
end

function RegiM:infoList()
    local infoArr = {}
    local idArrData = self:idArr()
    for i = 1, #idArrData do
        local rewardId = idArrData[i]
        local rewardData = ConfigManager.getConfObject("cfg_register", rewardId)
        local data = {}
        if RoleInfoM.instance:getSignInStatus(rewardId) == GameConst.sign_in_getted then
            data.registerId = rewardId
            data.name = ConfigManager.getConfObject("cfg_goods", rewardData.rewardID).name
            data.text = { text = rewardData.weekName, color = "#ffffff", strokeColor = "#104d86" }
            data.image = { skin = self:imageUrl(rewardData.rewardID, idArrData[i]) }
            data.count = { text = self:rewardCount(rewardData.rewardID, idArrData[i]), color = "#ffffff" }
            data.rightBtn = { visible = true }
            data.diImg = { skin = self.unregisterDiSkin }
            data.vipdi = { visible = false }
            data.vipbei = { visible = false }
            data.twobei = { visible = false }
            data.imgSelected = { visible = false };
            table.insert(infoArr, data)
        elseif RoleInfoM.instance:getSignInStatus(rewardId) == GameConst.sign_in_getting then
            --self._finishDays = self._finishDays + 1;
            data.registerId = rewardId
            data.name = ConfigManager.getConfObject("cfg_goods", rewardData.rewardID).name
            data.text = { text = rewardData.weekName, color = "#f25619", strokeColor = "#ffffff" }
            data.image = { skin = self:imageUrl(rewardData.rewardID, idArrData[i]) }
            data.count = { text = self:rewardCount(rewardData.rewardID, idArrData[i]), color = "#f25619" }
            data.rightBtn = { visible = false }
            data.diImg = { skin = self.registerDiSkin }
            data.vipdi = { visible = false }
            data.vipbei = { visible = false }
            data.twobei = { visible = false }
            data.imgSelected = { visible = true };
            table.insert(infoArr, data)
        elseif RoleInfoM.instance:getSignInStatus(rewardId) == GameConst.sign_in_not_reach then
            data.registerId = rewardId
            data.name = ConfigManager.getConfObject("cfg_goods", rewardData.rewardID).name
            data.text = { text = rewardData.weekName, color = "#ffffff", strokeColor = "#104d86" }
            data.image = { skin = self:imageUrl(rewardData.rewardID, idArrData[i]) }
            data.count = { text = self:rewardCount(rewardData.rewardID, idArrData[i]), color = "#ffffff" }
            data.rightBtn = { visible = false }
            data.diImg = { skin = self.unregisterDiSkin }
            data.vipdi = { visible = false }
            data.vipbei = { visible = false }
            data.twobei = { visible = false }
            data.imgSelected = { visible = false };
            table.insert(infoArr, data)
        end
    end
    return infoArr
end

function RegiM:idArr()
    local arr = {}
    local items = ConfigManager.getLawItem("cfg_register")
    for i = 1, #items do
        local rewardId = items[i].rewardID
        if rewardId == false then
            break ;
        end
        table.insert(arr, i);
    end
    return arr
end

function RegiM:isGet()
    local isget = false;
    local idArrData = self.idArr()
    for i = 1, #idArrData do
        if RoleInfoM.instance:getSignInStatus(idArrData[i]) == GameConst.sign_in_getting then
            isget = true;
            break ;
        end
    end
    return isget;
end

function RegiM:getFinishDays()
    return self._finishDays
end

function RegiM:setFinishDays(value)
    self._finishDays = value
end

