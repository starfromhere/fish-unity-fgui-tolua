---@class SeatRouter
---@field public instance SeatRouter
SeatRouter = class("SeatRouter")

SeatRouter.SEAT_INX_1 = 1
SeatRouter.SEAT_INX_2 = 2
SeatRouter.SEAT_INX_3 = 3
SeatRouter.SEAT_INX_4 = 4

function SeatRouter:ctor()
    --根据ID索引
    self.seat1 = nil
    self.seat2 = nil
    self.seat3 = nil
    self.seat4 = nil

    --根据位置索引
    ---@type Seat
    self.mySeat = nil
    ---@type Seat
    self.mySeatX = nil
    ---@type Seat
    self.mySeatY = nil
    ---@type Seat
    self.mySeatXY = nil

    self.mySeatId = nil
    self.myMirrorFlag = nil
    self.paoParent1 = nil
    self.paoParent2 = nil
    self.paoParent3 = nil
    self.paoParent4 = nil
end

function SeatRouter:setMySeatId(seatId)

    Log.debug("SeatRouter:setMySeatId", seatId)

    self.mySeatId = seatId;
    self.myMirrorFlag = MirrorMapper.getMirrorFlagBySeatId(self.mySeatId)

    Log.debug("self.myMirrorFlag", self.myMirrorFlag)
    --相对位置的seatId
    local mySeatIdX = MirrorMapper.getSeatIdByMirrorFlag(bit.bxor(self.myMirrorFlag, MirrorMapper.MIRROR_FLAG_X))
    local mySeatIdXY = MirrorMapper.getSeatIdByMirrorFlag(bit.bxor(self.myMirrorFlag, MirrorMapper.MIRROR_FLAG_Y))
    local mySeatIdY = MirrorMapper.getSeatIdByMirrorFlag(bit.bxor(bit.bxor(self.myMirrorFlag, MirrorMapper.MIRROR_FLAG_X), MirrorMapper.MIRROR_FLAG_Y))
    Log.debug("self.myMirrorFlag", self.mySeatId, mySeatIdX, mySeatIdXY, mySeatIdY)

    if not self.mySeat then
        self.mySeat = Seat.New()
        self.mySeatX = Seat.New()
        self.mySeatY = Seat.New()
        self.mySeatXY = Seat.New()
    end
    self.mySeat:init(self.mySeatId)
    self.mySeatX:init(mySeatIdX)
    self.mySeatY:init(mySeatIdY)
    self.mySeatXY:init(mySeatIdXY)

    self:_setSeatById(self.mySeatId, self.mySeat)
    self:_setSeatById(mySeatIdX, self.mySeatX)
    self:_setSeatById(mySeatIdY, self.mySeatY)
    self:_setSeatById(mySeatIdXY, self.mySeatXY)
end

function SeatRouter:_setSeatById(_seatId, seat)

    if _seatId == SeatRouter.SEAT_INX_1 then
        self.seat1 = seat
    elseif _seatId == SeatRouter.SEAT_INX_2 then
        self.seat2 = seat
    elseif _seatId == SeatRouter.SEAT_INX_3 then
        self.seat3 = seat
    elseif _seatId == SeatRouter.SEAT_INX_4 then
        self.seat4 = seat
    else
        return nil
    end
end
function SeatRouter:setSeatParent(parent, parentX, parentY, parentXY, wait2, wait3, wait4)
    self.paoParent1 = parent
    self.paoParent2 = parentX
    self.paoParent3 = parentY
    self.paoParent4 = parentXY
    self.mySeat:assemble(parent, nil)
    self.mySeatX:assemble(parentX, wait2)
    self.mySeatY:assemble(parentY, wait3)
    self.mySeatXY:assemble(parentXY, wait4)
end

---@return Seat
function SeatRouter:getSeatById(seatId)
    if seatId == SeatRouter.SEAT_INX_1 then
        return self.seat1
    elseif seatId == SeatRouter.SEAT_INX_2 then
        return self.seat2
    elseif seatId == SeatRouter.SEAT_INX_3 then
        return self.seat3
    elseif seatId == SeatRouter.SEAT_INX_4 then
        return self.seat4
    else
        return nil
    end

end
function SeatRouter:getPaoPatentById(seatId)
    if seatId == SeatRouter.SEAT_INX_1 then
        return self.paoParent1
    elseif seatId == SeatRouter.SEAT_INX_2 then
        return self.paoParent2
    elseif seatId == SeatRouter.SEAT_INX_3 then
        return self.paoParent3
    elseif seatId == SeatRouter.SEAT_INX_4 then
        return self.paoParent4
    else
        return nil
    end
end

---@return ProtoSeatInfo
function SeatRouter:getSeatInfoByAgent(agent)
    if self.seat1 and self.seat1.seatInfo and self.seat1.seatInfo.agent == agent then
        return self.seat1.seatInfo
    end
    if self.seat2 and self.seat2.seatInfo and self.seat2.seatInfo.agent == agent then
        return self.seat2.seatInfo
    end
    if self.seat3 and self.seat3.seatInfo and self.seat3.seatInfo.agent == agent then
        return self.seat3.seatInfo
    end
    if self.seat4 and self.seat4.seatInfo and self.seat4.seatInfo.agent == agent then
        return self.seat4.seatInfo
    end
    return nil
end

function SeatRouter:getSeatByAgent(agent)
    if self.seat1 and self.seat1.seatInfo and self.seat1.seatInfo.agent == agent then
        return self.seat1
    end
    if self.seat2 and self.seat2.seatInfo and self.seat2.seatInfo.agent == agent then
        return self.seat2
    end
    if self.seat3 and self.seat3.seatInfo and self.seat3.seatInfo.agent == agent then
        return self.seat3
    end
    if self.seat4 and self.seat4.seatInfo and self.seat4.seatInfo.agent == agent then
        return self.seat4
    end
    return nil
end

function SeatRouter:inSeatInfo(seatId, seatInfo)
    if seatId == 1 then
        self.seat1.seatInfo = seatInfo
        self.seat1.seatInfo.skipCoin = 0
    elseif seatId == 2 then
        self.seat2.seatInfo = seatInfo
        self.seat2.seatInfo.skipCoin = 0
    elseif seatId == 3 then
        self.seat3.seatInfo = seatInfo
        self.seat3.seatInfo.skipCoin = 0
    elseif seatId == 4 then
        self.seat4.seatInfo = seatInfo
        self.seat4.seatInfo.skipCoin = 0
    end
    self:syncLockSkill(seatId, seatInfo)
end

function SeatRouter:changeToExit()
    self.mySeat:changeToExit()
    self.mySeatX:changeToExit()
    self.mySeatY:changeToExit()
    self.mySeatXY:changeToExit()
end

function SeatRouter:syncLockSkill(seatId, seatInfo)
    if seatInfo.seat_id > 0 and seatInfo.lock_et > 0 then
        local seat = fight.seat.SeatRouter.instance:getSeatById(seatInfo.seat_id)
        if seat then
            seat.lockRemainTime = seatInfo.lock_et
            seat.lockFishUid = seatInfo.lock_uid
            seat.lockFishSid = seatInfo.lock_sid
            seat:changeToLock()
        end
    end
end

function SeatRouter:getSeatInfo(seatId)
    --[[
    TODO
    switch(seatId){case1:return self.seat1.seatInfo

    case2:return self.seat2.seatInfo

    case3:return self.seat3.seatInfo

    case4:return self.seat4.seatInfo

    }]]
    return nil
end

function SeatRouter:getOwnUseBattery()
    local seatInfo = self:getSeatInfo(self.mySeatId)
    if seatInfo then
        return seatInfo.battery
    end
    return 0
end

function SeatRouter:seatAddCoin(sId, agent, addCoin, skipCoinClear)
    local seatInfo = self:getSeatInfo(sId)
    if seatInfo and seatInfo.seat_id == sId and seatInfo.agent == agent then
        seatInfo.coin = seatInfo.coin + addCoin
        if skipCoinClear then
            seatInfo.skipCoin = 0
        end
        if sId == self.mySeatId then
            GameEventDispatch.instance:event("PlayerCoinChange", {})
        end
    end
end

function SeatRouter:seatAddContestCoin(sId, agent, addCoin)
    local seatInfo = self:getSeatInfo(sId)
    if seatInfo and seatInfo.seat_id == sId and seatInfo.agent == agent then
        seatInfo.contestCoin = nil --[TODO]+= addCoin
        if sId == self.mySeatId then
            GameEventDispatch.instance:event("PlayerCoinChange", {})
        end
    end
end

function SeatRouter:seatAddCoinByAgent(agent, addCoin)
    local seat = SeatRouter.instance:getSeatByAgent(agent)
    
    if seat  then
        seat:addCoin(addCoin,true)
    end
end

function SeatRouter:seatAddContestScoreByAgent(agent, addScore)
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(agent)
    if seatInfo then
        seatInfo.contestScore = seatInfo.contestScore + addScore
        if seatInfo.seat_id == self.mySeatId then
            GameEventDispatch.instance:event("PlayerCoinChange", {})
        end
    end
end

function SeatRouter:setSkipCoin(sId, skipCoin)
    local seatInfo = SeatRouter.instance:getSeatInfo(sId)
    if seatInfo then
        seatInfo.skipCoin = skipCoin
        GameEventDispatch.instance:event("PlayerCoinChange", {})
    end
end

function SeatRouter:setLevel(seat_id, level)
    local seatInfo = self:getSeatInfo(seat_id)
    if seatInfo then
        seatInfo.level = level
    end
end

function SeatRouter:seatConfigChange(seat_id, cskin, battery)
    local seatInfo = self:getSeatInfo(seat_id)
    if seatInfo then
        seatInfo.cskin = cskin
        seatInfo.battery = battery
    end
end

function SeatRouter:outSeatInfo(seatId)

    --[[
    TODO
    switch(seatId){case1:self.seat1.seatInfo=null
    break

    case2:self.seat2.seatInfo=null
    break

    case3:self.seat3.seatInfo=null
    break

    case4:self.seat4.seatInfo=null
    break

    }]]
end

function SeatRouter:onResize()
    if self.mySeat then
        self.mySeat:screenResize()
    end
    if self.mySeatX then
        self.mySeatX:screenResize()
    end
    if self.mySeatY then
        self.mySeatY:screenResize()
    end
    if self.mySeatXY then
        self.mySeatXY:screenResize()
    end
end

function SeatRouter:updateSeatInfo()
    if self.mySeat:isLockPao() then
        self.mySeat:dealLockFishImg()
    end

    if self.mySeatX:isLockPao() then
        self.mySeatX:dealLockFishImg()
    end

    if self.mySeatY:isLockPao() then
        self.mySeatY:dealLockFishImg()
    end
    
    if self.mySeatXY:isLockPao() then
        self.mySeatXY:dealLockFishImg()
    end
end
