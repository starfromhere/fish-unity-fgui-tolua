---@class RewardM
---@field public instance RewardM
RewardM = class("RewardM")
function RewardM:ctor()
    self.aniNames = { "common", "bronze", "silver", "gold", "platina", "extreme" }
    self.idArr = { "firstId", "secondId", "threeId", "fourId", "fiveId", "sixId" }
    self.commonArr = { "common_1", "common_2", "common_3", "common_4", "common_5", "common_6" }
    self.typeArr = { 101, 201, 301, 401, 501, 601 }   --抽奖类型
    self.infoList = nil
    self._recordArr = nil
    self._currentList = nil
    self._userNameArr = nil
    self._lotterIdArr = nil
    self._isCollect = nil
    self._isFristCollect = nil
    self.reward = {}

end

function RewardM:isShowScene()
    --if FightM.instance.sceneId == 4 then
    --    return true
    --end
    return false

end

function RewardM:isRewardShowScene()
    --if FightM.instance.sceneId == 4 or FightM.instance.sceneId == 1 then
    --    return false
    --
    --end
    return true

end

function RewardM:currentList(listData)
    self._currentList = listData;
end

function RewardM:RecordArr()
    local arr = {};
    if self._currentList ~= nil then
        local max = 3
        if #self._currentList > max then
            for i = 1, max do
                local typeId = self._currentList[i].type;
                local goodId = self._currentList[i].reward[1].t;
                local goodNum = self._currentList[i].reward[1].v;
                local userName = GameTools.filterName(FightTools:formatNickName(""..self._currentList[i].nickname, 10));
                local userName1 =FightTools:formatNickName(""..self._currentList[i].nickname, 10);
                table.insert(arr, self:getlotteryRecord(typeId, userName1))
            end
        else

            for j, v in pairs(self._currentList) do
                local typeId = self._currentList[j].type;
                local goodId = self._currentList[j].reward[1].t;
                local goodNum = self._currentList[j].reward[1].v;
                local userName = GameTools.filterName(FightTools:formatNickName(self._currentList[j].nickname, 10));
                local userName1 =FightTools:formatNickName(""..self._currentList[i].nickname, 10);
                table.insert(arr, self:getlotteryRecord(typeId, userName1))
            end
        end
    end
    return arr;
end

function RewardM:setInfo()
    for j, value in pairs(self.aniNames) do
        local rewardType = ConfigManager.getConfObject("cfg_rewardType", self.aniNames[j])
        local arr = {}
        for k, v in ipairs(self.idArr) do
            table.insert(arr, rewardType[self.idArr[k]])
        end
        self.reward[tostring(self.aniNames[j])] = arr
    end

end
function RewardM:getlotteryRecord(id, userName)
    --userName=userName:replace(/[&<>]/g,"")
    userName = tostring(userName)
    userName = string.gsub(userName, "/[&<>]/g", "")
    local contentOne = "恭喜"
    local contentTwo = "[color=#1aa2d2]" .. userName .. "[/color]"
    local contentThree = "通过进行" .. tostring(self:getlotteryName(id)) .. "，获得了"
    local contentFour = "[color=#d87014]" .. tostring(self:rewardName(tostring(id))) .. "[/color]"
    return contentOne .. contentTwo .. contentThree .. contentFour
end

function RewardM:getUserName()
    return "郭钱"
end

function RewardM:rewardArr(id)
    local arr = {}
    local rewardArr = self.reward[self.aniNames[id] + ""]
    for i, value in TODO do
        local c = cfg_rewardDetails.instance(rewardArr[i])
        local goodsId = c.award[1]
        local goods = cfg_goods.instance(tostring(goodsId))
        if goods.type == 7 then
            if RoleInfoM.instance:isSkinExit(goods.typeID) then
                table.insert(arr, { id = c.id, txt = c.re_rewardName, image = c.re_rewardUrl, count = c.re_award })
            else
                table.insert(arr, { id = c.id, txt = c.rewardName, image = c.rewardUrl, count = c.award })
            end
        else
            table.insert(arr, { id = c.id, txt = c.rewardName, image = c.rewardUrl, count = c.award })
        end
    end
    return arr
end

function RewardM:getCurrentList()

end

function RewardM:rewardName(id)
    local c = cfg_rewardDetails.instance(tonumber(id))
    if c then
     return c.rewardName
    end
    return ""
end

function RewardM:conditonValue(id)
    local c = cfg_rewardDetails.instance(self.typeArr[id + 1])
    return c.condition[2]
end

function RewardM:conditionShowValue(id)
    --local rewardArr = self.reward[self.aniNames[id] .. ""]
    local c = cfg_rewardDetails.instance(self.typeArr[id + 1])
    return c.com_fish_coin
end

function RewardM:imageUrl(id)
    local c = cfg_rewardDetails.instance(id)
    local goodsId = c.goodId
    local cfg = cfg_goods.instance(goodsId)
    return cfg.icon
end

function RewardM:goodsId(id)
    local c = cfg_rewardDetails.instance(id)
    local goodsId = c.goodId
    return goodsId
end

function RewardM:rewardCount(id)
    local c = cfg_rewardDetails.instance(id)
    local awardArr = c.award
    return awardArr[2]
end

function RewardM:baseFishCount()
    local c = cfg_rewardDetails.instance(101)
    return c.condition[1]
end

function RewardM:selectTab(coin)
    if coin >= self:conditonValue(0) and coin < self:conditonValue(1) then
        return 0
    elseif coin >= self:conditonValue(1) and coin < self:conditonValue(2) then
        return 1
    elseif coin >= self:conditonValue(2) and coin < self:conditonValue(3) then
        return 2
    elseif coin >= self:conditonValue(3) and coin < self:conditonValue(4) then
        return 3
    elseif coin >= self:conditonValue(4) and coin < self:conditonValue(5) then
        return 4
    elseif coin >= self:conditonValue(5) then
        return 5
    else
        return 0
    end
end

function RewardM:setName(coin)
    if coin >= self:conditonValue(0) and coin < self:conditonValue(1) then
        return "普通抽奖"
    elseif coin >= self:conditonValue(1) and coin < self:conditonValue(2) then
        return "青铜抽奖"
    elseif coin >= self:conditonValue(2) and coin < self:conditonValue(3) then
        return "白银抽奖"
    elseif coin >= self:conditonValue(3) and coin < self:conditonValue(4) then
        return "黄金抽奖"
    elseif coin >= self:conditonValue(4) and coin < self:conditonValue(5) then
        return "钻石抽奖"
    elseif coin >= self:conditonValue(5) then
        return "至尊抽奖"
    else
        return "普通抽奖"
    end
end

function RewardM:getlotteryName(id)
    local c = cfg_rewardDetails.instance(id)
    return c.reward_type
end

function RewardM:url(award)
    local goodsId = award[1]
    local cfg_good = cfg_goods.instance(tostring(goodsId))
    return cfg_good.icon
end

function RewardM:isCollect(value)
    self._isCollect = value
end
        