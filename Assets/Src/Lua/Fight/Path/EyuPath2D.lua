---@class EyuPath2D
EyuPath2D = class("EyuPath2D")
function EyuPath2D:ctor()

    self.targetSeatId = nil
    self.targetSeat = nil

    self.originPoint = Vector2.New()
    self.targetPoint = Vector2.New()
    self.direct_vec2 = Vector2.New()

    self:_chooseFirstTarget()
    self:_calcCurTarget()

    self.loopTime = 2
    self.curLoop = 0
    self.firstSeatID = self.targetSeatId

    self.totalTime = 7
    self.speed = 500
    self.calcedSec = 0


    --是否需要咬一下标志位
    self.needHit = false
    self.haveHit = false

    --需要根据位置做镜像
    self.needMirror = false
end

function EyuPath2D:_chooseFirstTarget()
    if SeatRouter.instance.seat1 then
        self.targetSeatId = 1
        self.targetSeat = SeatRouter.instance.seat1
    elseif SeatRouter.instance.seat2 then
        self.targetSeatId = 2
        self.targetSeat = SeatRouter.instance.seat2
    elseif SeatRouter.instance.seat3 then
        self.targetSeatId = 3
        self.targetSeat = SeatRouter.instance.seat3
    elseif SeatRouter.instance.seat4 then
        self.targetSeatId = 4
        self.targetSeat = SeatRouter.instance.seat4
    end
end
function EyuPath2D:_nextSeatId(seatId)
    return seatId % 4 + 1
end

function EyuPath2D:chooseNextTarget(seatId)
    local nextTargetSeatId = self:_nextSeatId(seatId)
    local seat = SeatRouter.instance:getSeatById(nextTargetSeatId)
    return seat
    --if seat.fsm:isInState(StateSeatExit) then
    --    return self:chooseNextTarget(nextTargetSeatId)
    --else
    --    return seat
    --end
end

---转换到下一个目标
function EyuPath2D:nextTarget()

    local nextSeat = self:chooseNextTarget(self.targetSeatId)
    if nextSeat.seatId == self.firstSeatID then
        self.curLoop = self.curLoop + 1
    end

    self.targetSeatId = nextSeat.seatId
    self.targetSeat = nextSeat
    self:_calcCurTarget()
end

---计算当前目标的数据
function EyuPath2D:_calcCurTarget()
    self.originPoint.x = self.targetSeat.shootStartX
    self.originPoint.y = (GameScreen.instance.adaptHeight - self.targetSeat.shootStartY)
    if self.targetSeat.shootStartY > GRoot.inst.height/2 then
        self.originPoint.y = self.originPoint.y - 770
    else
        self.originPoint.y = self.originPoint.y + 770
    end
    self.targetPoint.x = self.targetSeat.shootStartX
    self.targetPoint.y = self.targetSeat.shootStartY

    self.direct_vec2.x = self.targetPoint.x - self.originPoint.x
    self.direct_vec2.y = self.targetPoint.y - self.originPoint.y
    self.direct_vec2 = Vector2.Normalize(self.direct_vec2)
end

---@param out PathResult
function EyuPath2D:move(sec, out)

    --计算时间
    local calcSec = sec - self.calcedSec
    if self.curLoop >= self.loopTime then
        out.isOver = true
        return
    else
        out.isOver = false
    end

    if calcSec > self.totalTime then
        self:nextTarget()
        self:_calcCurTarget()
        self.haveHit = false
        self.calcedSec = sec
    end

    out.position.x = self.originPoint.x + self.speed * self.direct_vec2.x * calcSec
    out.position.y = self.originPoint.y + self.speed * self.direct_vec2.y * calcSec
    out.dirVec.x = self.direct_vec2.x
    out.dirVec.y = self.direct_vec2.y
    out.rotation = MathTools.vecToAngle(out.dirVec.x, out.dirVec.y)

    if calcSec > 0.5 and not self.haveHit and self.curLoop < self.loopTime then
        self.needHit = true
    end
end

