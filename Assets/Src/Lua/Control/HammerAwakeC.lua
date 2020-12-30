---@class HammerAwakeC:BossAwakeC
---@field instance HammerAwakeC
HammerAwakeC = class("HammerAwakeC", BossAwakeC)
function HammerAwakeC:ctor()
    HammerAwakeC.super.ctor(self)
    self.bosstype = FightConst.fish_death_type_leishenchui_awake
    self.tick = 0
end

function HammerAwakeC:onHammerAwake(isTest, uid, showAwardInfo, agentId, tick)

    local fishPos = nil
    local seat = nil
    self.tick = tick or 0
    if isTest then
        seat = SeatRouter.instance.mySeat
    else
        local info = self:getAwakeInfo(uid)
        info.agentId = agentId
        info.award = showAwardInfo.award
        info.curStage = 0
        info.totalStage = showAwardInfo.index
        local fish = Fishery.instance:findFishByUniId(uid)
        if fish then
            info.fishId = fish.fishId
        end
        fishPos = Vector2.New(fish:getLockPoint().x, fish:getLockPoint().y)
        seat = SeatRouter.instance:getSeatByAgent(agentId)
    end
    if seat then
        self:playAwake(uid, agentId, fishPos)
        seat.isUnableAddCoin = true
        seat:changeToWait()
    end
end

function HammerAwakeC:playAwake(uid, agentId, fishPosition)
    local seat = SeatRouter.instance:getSeatByAgent(agentId)
    if not self.awake then
        self.awake = HammerAwake.create(uid, fishPosition, seat)
    end
    self.awake:play()
end

function HammerAwakeC:onMsgRet(data,lastNum)
    local s2c = S2c_12131.create()
    s2c:parse(data)
    local seat = SeatRouter.instance:getSeatByAgent(s2c.agentId)

    if self.awake then
        self.awake:initData()
    else
        self.awake = HammerAwake.create(s2c.uid, nil, seat)
        self.awake:play()
        seat.bingoController:synBingoShow((seat.fortLevel.text or 1), BingoType.HammerPangXie,nil, s2c.award)
    end
    s2c:recover()
end

function HammerAwakeC:onMsgEndRet(data)
    local s2c = S2c_12132.create()
    s2c:parse(data)
    GameTimer.once(2000, self, function()
        local seat = SeatRouter.instance:getSeatByAgent(s2c.agentId)
        if seat then
            seat.isUnableAddCoin = false
            s2c:recover()
        end        
    end)
    if self.awake then
        local out_room = data.out_room or 0
        self.awake:initEndScore(s2c.extra_award , s2c.base_award,s2c.agentId, out_room)
        self.awakeDic[s2c.uid] = nil
    end
end

function HammerAwakeC:getComebackTick(data)
    if not self.awake then
        return
    end
    local offTick = data - self.tick
    self.awake:resetAni(offTick * 20)
end