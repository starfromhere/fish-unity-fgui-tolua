---@class BossAwakeC
---@field instance BossAwakeC
BossAwakeC = class("BossAwakeC")
function BossAwakeC:ctor()
    self.awakeDic = {}
    self.awake = nil
    self.bosstype = 0
end

function BossAwakeC:onBossAwake(isTest, uid, showAwardInfo, agentId, startPos)
    local seat = nil
    if isTest then
        seat = SeatRouter.instance.mySeat
    else
        local info = self:getAwakeInfo(uid)
        info.agentId = agentId
        info.award = showAwardInfo.award
        info.curStage = 0
        info.totalStage = showAwardInfo.index or 1
        local fish = Fishery.instance:findFishByUniId(uid)
        if fish then
            info.fishId = fish.fishId
        end
        seat = SeatRouter.instance:getSeatByAgent(agentId)
    end

    if seat then
        seat.isUnableAddCoin = true
        self:playAwake(uid, agentId, startPos)
        seat:changeToWait()
    end
end

function BossAwakeC:reset()
    for k, info in pairs(self.awakeDic) do
        if info then
            self.awakeDic:recover()
            self.awakeDic[k] = nil
        end
    end
    self.awakeDic = {}
end

function BossAwakeC:sendMsg(uid, fishes, stage, removeFishes)
    local info = self:getAwakeInfo(uid)
    if info and info.curStage then
        info.curStage = info.curStage + 1
    end
    local rf = {uids = removeFishes, type = self.bosstype}
    local c2s = C2s_12130.create()
    c2s:init(uid, fishes, stage, rf)
    c2s:sendMsg()
end

function BossAwakeC:getAwakeInfo(uid)
    uid = uid or 0
    local ret = self.awakeDic[uid]
    if not ret then
        ret = {}
        self.awakeDic[uid] = ret
    end
    ret.uid = uid
    return ret
end

function BossAwakeC:getStageCount(uid)
    local info = self:getAwakeInfo(uid)
    local award = info.award
    local targetCount = 0
    if award and award[info.curStage + 1] then
        targetCount = award[info.curStage + 1][3] or 0
    end
    local curCount = 0
    if award and award[info.curStage] then
        curCount = award[info.curStage][3] or 0
    end
    return targetCount - curCount
end

function BossAwakeC:getAwakeFishInfo(uid)
    uid = uid or 0
    return self.awakeDic[uid]
end

function BossAwakeC:onMsgEndRet(data)
    local s2c = S2c_12132.create()
    s2c:parse(data)
    if self.awake then
        local out_room = data.out_room or 0
        self.awake:playEndScore(s2c.extra_award + s2c.base_award,s2c.agentId, out_room)
        self.awakeDic[s2c.uid] = nil
    end
    s2c:recover()
end

function BossAwakeC:getComeBackData(data)
    if self.awake then
        self.awake:getComeBackData(data)
    end
end
