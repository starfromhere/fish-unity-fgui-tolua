---@class ZhangYuAwakeC:BossAwakeC
---@field instance ZhangYuAwakeC
ZhangYuAwakeC = class("ZhangYuAwakeC", BossAwakeC)

function ZhangYuAwakeC:ctor()
    ZhangYuAwakeC.super.ctor(self)
    self.bosstype = FightConst.fish_death_type_boss_awake
end
function ZhangYuAwakeC:onZhangYuAwake(uid, seat, pos, curStage, coinGet, catchInfo, agentId, showAwardInfo)
    local info = self:getAwakeInfo(uid)
    info.agentId = agentId
    info.award = showAwardInfo.award
    info.curStage = 0
    info.totalStage = showAwardInfo.index or 1
    if seat then
        self:playAwake(uid, seat, pos, showAwardInfo.index, curStage, coinGet, catchInfo, agentId)
        seat:changeToWait()
    end
end

function ZhangYuAwakeC:playAwake(uid, seat, pos, index, curStage, coinGet, catchInfo, agentId)
    if not self.awake then
        self.awake = ZhangYuAwake.create(uid, seat, pos, index, curStage)
        self.awake:play(coinGet, catchInfo, agentId)
    end
end

-- function ZhangYuAwakeC:sendMsg(uid, fishes, stage, removeFishes)
--     self.super.sendMsg(self, uid, fishes, stage, removeFishes, FightConst.fish_death_type_boss_awake)
-- end

function ZhangYuAwakeC:onMsgRet(data,lastNum)
    local s2c = S2c_12131.create()
    s2c:parse(data)
    local seat = SeatRouter.instance:getSeatByAgent(s2c.agentId)
    if not self.awake then
        local pos = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight/ 2)
        self.awake = ZhangYuAwake.create(s2c.uid, seat, pos, s2c.end_stage, s2c.stage)
        self.awake:playWithProtocol(s2c.award, s2c.agentId, s2c.stage, s2c.end_stage)
        seat.bingoController:synBingoShow((seat.fortLevel.text or 1), BingoType.ZhangYuBoss, nil,s2c.award)
    end

    s2c:recover()
end

function ZhangYuAwakeC:getStageCount(uid)
    local info = self:getAwakeInfo(uid)
    local award = info.award
    local targetCount = 0
    if award and award[info.curStage + 1] then
        targetCount = award[info.curStage + 1][1]
    end
    local curCount = 0
    if award and award[info.curStage] then
        curCount = award[info.curStage][1]
    end
    return targetCount - curCount
end

function ZhangYuAwakeC:onMsgEndRet(data)
    local s2c = S2c_12132.create()
    s2c:parse(data)
    if self.awake then
        local out_room = data.out_room or 0
        self.awake:endScore(out_room, data.base_award)
        self.awakeDic[s2c.uid] = nil
    end
    s2c:recover()
end

function ZhangYuAwakeC:getComeBackData(data)
    if self.awake then
        self.awake:getComeBackData(data)
    end
end