
---@class FireDragonAwakeC:BossAwakeC
---@field public instance FireDragonAwakeC
FireDragonAwakeC = class("FireDragonAwakeC", BossAwakeC)

function FireDragonAwakeC:ctor()
    self.super.ctor(self)
    self.bosstype = FightConst.fish_death_type_fireDragon_awake
    self.tick = 0
end

function FireDragonAwakeC:onDragonAwake(isTest, uid, showAwardInfo, agentId, startPos, tick)
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


function FireDragonAwakeC:playAwake(uid, agentId, startPos)
    local info = self:getAwakeInfo(uid)
    local seat = SeatRouter.instance:getSeatByAgent(agentId)
    if not self.awake then
        self.awake = FireDragonAwake.create(info.totalStage, uid, startPos, seat)
    end
    self.awake:play()
end


function FireDragonAwakeC:onMsgRet(data,lastNum)
    local s2c = S2c_12131.create()
    s2c:parse(data)

    if self.awake then
        self.awake:initData(s2c.stage, s2c.end_stage, s2c.award)
    end
    s2c:recover()
end