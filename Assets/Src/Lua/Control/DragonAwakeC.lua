---@class DragonAwakeC:BossAwakeC
---@field public instance DragonAwakeC
DragonAwakeC = class("DragonAwakeC", BossAwakeC)

function DragonAwakeC:ctor()
    self.super.ctor(self)
    self.bosstype = FightConst.fish_death_type_dragon_awake
    self.tick = 0
end

function DragonAwakeC:onDragonAwake(isTest, uid, showAwardInfo, agentId, startPos, tick)
    local seat = nil
    self.tick = tick or 0
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

function DragonAwakeC:playAwake(uid, agentId, startPos)
    local info = self:getAwakeInfo(uid)
    local seat = SeatRouter.instance:getSeatByAgent(agentId)
    if not self.awake then
        self.awake = DragonAwake.create(info.totalStage, uid, startPos, seat)
    end
    self.awake:play()
end


function DragonAwakeC:getStageCount(uid)
    local info = self:getAwakeInfo(uid)
    local award = info.award
    local targetCount = 0
    if award and award[info.curStage + 1] then
        targetCount = award[info.curStage + 1][1] or 0
    end
    local curCount = 0
    if award and award[info.curStage] then
        curCount = award[info.curStage][1] or 0
    end
    return targetCount - curCount
end

function DragonAwakeC:onMsgRet(data,lastNum)
    local s2c = S2c_12131.create()
    s2c:parse(data)

    if self.awake then
        self.awake:initData(s2c.stage, s2c.end_stage, s2c.award)
    else
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
        local seat = SeatRouter.instance:getSeatByAgent(s2c.agentId)
        GameTimer.once(4000, self, function ()
            local stage = 0
            if s2c.stage + 1 > s2c.end_stage then
                stage = s2c.end_stage
            else
                stage = s2c.stage + 1
            end

            self.awake = DragonAwake.create(s2c.end_stage, s2c.uid, nil, seat)
            self.awake:playWithProtocol(stage)
            seat.bingoController:synBingoShow((seat.fortLevel.text or 1), BingoType.LongBoss, nil,s2c.award)
        end)
    end
    s2c:recover()
end


function DragonAwakeC:getComebackTick(data)
    if not self.awake then
        return
    end
    local offTick = data - self.tick
    self.awake:resetAni(offTick * 20)
end

