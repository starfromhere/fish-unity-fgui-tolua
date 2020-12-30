---@class AnKangYuAwakeC:BossAwakeC
---@field public instance AnKangYuAwakeC
AnKangYuAwakeC = class("AnKangYuAwakeC", BossAwakeC)

function AnKangYuAwakeC:ctor()
    AnKangYuAwakeC.super.ctor(self)
    self.bosstype = FightConst.fish_death_type_anakangyu_awake
end
function AnKangYuAwakeC:onAnKangYuAwake(isTest, uid, showAwardInfo, agentId, startPos)
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

-- function AnKangYuAwakeC:sendMsg(uid, fishes, stage, removeFishes)
--     self.super.sendMsg(self, uid, fishes, stage, removeFishes, FightConst.fish_death_type_anakangyu_awake)
-- end

function AnKangYuAwakeC:playAwake(uid, agentId, startPos)
    local info = self:getAwakeInfo(uid)
    local seat = SeatRouter.instance:getSeatByAgent(agentId)
    if not self.awake then
        self.awake = AnKangYuAwake.create(info.totalStage, uid, startPos, seat)
    end
    self.awake:play()
end

function AnKangYuAwakeC:onMsgRet(data)
    local s2c = S2c_12131.create()
    s2c:parse(data)
    local seat = SeatRouter.instance:getSeatByAgent(s2c.agentId)

    if not self.awake then
        self.awake = AnKangYuAwake.create(s2c.end_stage, s2c.uid, nil, seat, s2c.stage)
        self.awake:play()
        seat.bingoController:synBingoShow((seat.fortLevel.text or 1), BingoType.AnKangYuBoss,nil, s2c.award)
    end
    seat.bingoController:startShowNum(BingoType.AnKangYuBoss,nil, nil,  s2c.award, 4000, 0)
    self.awake:initData(s2c.stage, s2c.end_stage, s2c.award)
    s2c:recover()
end
