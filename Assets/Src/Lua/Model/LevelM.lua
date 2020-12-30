---@class LevelM
---@field public instance LevelM
LevelM = class("LevelM")
function LevelM:ctor()
    self.keyArr = nil
    self.sceneType = 0
    self.sceneArr = nil
    self._isCanReward = 0
    self._coinRankLv = -1
    self._coinReward = {}
    self._strengthRankLv = -1
    self._strengthReward = {}
    self._loopMsg = ""
    self._todayStrIsHaveReward = false
    self._todayCoinIsHaveReward = false
    self._isPopupRankPage = 0
    self._coinReward = self._coinReward or {}
    self._strengthReward = self._strengthReward or {}
    self._rankInfo = {}
end

---@return string
function LevelM:loopMsg()
    if ActivityM.instance:getActivityData(GameConst.activity_rank) then
        local data = ActivityM.instance:getActivityData(GameConst.activity_rank)
        self._loopMsg = data.config.timing_msg
    else
        self._loopMsg = ""
    end
    return self._loopMsg
end

function LevelM:setInfo(stype)
    self.sceneType = stype
    self.keyArr = {}
    local items = ConfigManager.items("cfg_scene")
    for _, v in pairs(items) do
        table.insert(self.keyArr, v)
    end
    self.sceneArr = {}
    self.sceneArr = ConfigManager.groupby("cfg_scene", "sceneType")[stype]
end

function LevelM:getUnloc(id)
    local levlem = self.sceneArr[id]
    return levlem.unlock
end

function LevelM:getCountArr(level)
    local cfg = cfg_level.instance(level)
    return cfg.awardCount
end

function LevelM:getGoodsArr(level)
    local cfg = cfg_level.instance(level)
    return cfg.awardId
end

function LevelM:setSelfRankInfo(value)
    self._rankInfo = value
end

function LevelM:getSelfRankInfo()
    return self._rankInfo;
end

function LevelM:listArr()
    local arr = {}
    for j, v in ipairs(self.sceneArr) do
        local levelem = self.sceneArr[j]
        table.insert(arr, { levelImg = { skin = levelem.imageurl } })
        --arr:push({levelImg={skin=levelem.imageurl}})
    end
    return arr
end

function LevelM:setTodayStrIsHaveReward(result)
    local strLv = result.data["strength_top_me"]
    local strList = result.data["strength_top"]
    local coinLv = result.data["gold_top_me"]
    local coinList = result.data["gold_top"]
    if strList[tostring(strLv - 1)] and strList[tostring(strLv - 1)].reward.length > 0 then
        self._todayStrIsHaveReward = true
    else
        self._todayStrIsHaveReward = false
    end
    if coinList[tostring(coinLv - 1)] and coinList[tostring(coinLv - 1)].reward.length > 0 then
        self._todayCoinIsHaveReward = true
    else
        self._todayCoinIsHaveReward = false
    end
end

function LevelM:getRankDoubleReward()
    return ActivityM.instance:activityIsProceed(GameConst.activity_rank)
end

function LevelM:isCanReward(value)
    local a = value or nil
    if a == nil then
        return self._isCanReward;
    else
        self._isCanReward = a;
    end
end

function LevelM:coinRankLv(value)
    local a = value or nil
    if a == nil then
        return self._coinRankLv;
    else
        self._coinRankLv = a;
    end
end

function LevelM:coinReward(value)
    local a = value or nil
    if a == nil then
        return self._coinReward or {};
    else
        self._coinReward = a;
    end
end

function LevelM:strengthRankLv(value)
    local a = value or nil
    if a == nil then
        return self._strengthRankLv;
    else
        self._strengthRankLv = a;
    end
end

function LevelM:strengthReward(value)
    local a = value or nil
    if a == nil then
        return self._strengthReward or {};
    else
        self._strengthReward = a;
    end
end

function LevelM:todayStrIsHaveReward(value)
    local a = value or nil
    if a == nil then
        return self._todayStrIsHaveReward;
    else
        self._todayStrIsHaveReward = a;
    end
end

function LevelM:todayCoinIsHaveReward(value)
    local a = value or nil
    if a == nil then
        return self._todayCoinIsHaveReward;
    else
        self._todayCoinIsHaveReward = a;
    end
end

function LevelM:isPopupRankPage(value)
    local a = value or nil
    if a == nil then
        return self._isPopupRankPage;
    else
        self._isPopupRankPage = a;
    end
end
        