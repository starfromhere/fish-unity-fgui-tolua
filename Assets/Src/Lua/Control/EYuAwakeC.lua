---@class EYuAwakeC:BossAwakeC
---@field instance EYuAwakeC
EYuAwakeC = class("EYuAwakeC", BossAwakeC)

function EYuAwakeC:ctor()
    EYuAwakeC.super.ctor(self)
    self.bosstype = FightConst.fish_death_type_eyu_awake
end
function EYuAwakeC:onEYuAwake(uid, showAwardInfo, agentId, startPos)
    local info = self:getAwakeInfo(uid)
    info.agentId = agentId
    info.award = showAwardInfo.award
    info.curStage = 0
    info.totalStage = showAwardInfo.index
    local fish = Fishery.instance:findFishByUniId(uid)
    if fish then
        info.fishId = fish.fishId
    end
    local seat = SeatRouter.instance:getSeatByAgent(agentId)
    seat.isUnableAddCoin = true
    self:playAwake(uid, startPos)

    if seat then
        seat:changeToWait()
    end
end

function EYuAwakeC:playAwake(uid, startPos)
    local info = self:getAwakeInfo(uid)
    local awake = self.awake
    if not awake then
        awake = EYuAwake.create(info.totalStage, uid, startPos)
        self.awake = awake
    end
    awake:play()
end

function EYuAwakeC:onMsgRet(data,lastNum)
    local s2c = S2c_12131.create()
    s2c:parse(data)

    local seat = SeatRouter.instance:getSeatByAgent(s2c.agentId)
    if seat then
        seat.bingoController:startShowNum(BingoType.EYuBoss,nil, nil, s2c.award, 4000, 0)
    end
    if not self.awake then

        local cfg_fish = cfg_fish.instance(s2c.fishId)
        local award = cfg_fish.award_level_arr
        local info = self:getAwakeInfo(s2c.uid)
        info.agentId = s2c.agentId
        info.award = award
        info.curStage = s2c.stage
        info.totalStage = s2c.end_stage
        local fish = Fishery.instance:findFishByUniId(s2c.uid)
        if fish then
            info.fishId = fish.fishId
        end

        GameTimer.once(4000, self, function ()
            local stage = 0
            if s2c.stage + 1 > s2c.end_stage then
                stage = s2c.end_stage
            else
                stage = s2c.stage + 1
            end

            self.awake = EYuAwake.create(s2c.end_stage, s2c.uid, nil,  stage)
            self.awake:playWithProtocol(stage)
            seat.bingoController:synBingoShow((seat.fortLevel.text or 1), BingoType.EYuBoss, nil,s2c.award)
        end)

    end
    s2c:recover()
end

function EYuAwakeC:onMsgEndRet(data)
    local s2c = S2c_12132.create()
    s2c:parse(data)
    local out_room = data.out_room or 0
    local seat = SeatRouter.instance:getSeatByAgent(s2c.agentId)
    if seat and out_room ~= 1 then
        seat.bingoController:startShowNum(BingoType.EYuBoss,nil, nil,  s2c.extra_award, 2500, 0)
        seat.bingoController:bingoEnd(BingoType.EYuBoss,nil, s2c.extra_award, seat, function ()

            GameTimer.once(2000, self, function ()
                seat.isUnableAddCoin = false
            end)
            seat.bingoController:resetUi(BingoType.EYuBoss,nil);

            local s2c = S2c_12132.create()
            s2c:parse(data)
            seat:bossDeathAddCoin(s2c.extra_award + s2c.base_award,s2c.agentId)
            seat:bingoEndAutoState()
        end,true)
        self.awakeDic[s2c.uid] = nil
    end

    if self.awake then
        self.awake:playEndScore(out_room)
    end
    s2c:recover()
end
