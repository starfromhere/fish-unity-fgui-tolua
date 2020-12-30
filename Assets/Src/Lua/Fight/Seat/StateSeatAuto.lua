---@class StateSeatAuto
StateSeatAuto = class("StateSeatAuto")
---@param seat Seat
function StateSeatAuto:enter(seat)
    if seat then
        -- SeatRouter.instance:updateSizeById(seat.seatId)
    end
    -- SeatAuto.instance:onAutoShootStart()
end

---@param seat Seat
function StateSeatAuto:execute(seat)
    if seat.isMouseDown then
        seat:changeAutoPoint(seat.mouseX, seat.mouseY)
    end
    -- seat:shoot(seat.autoShootPoint.x, seat.autoShootPoint.y, seat.seatId)
end

---@param seat Seat
function StateSeatAuto:exit(seat)
    if FightContext.instance.lockMode == 1 then
        -- SeatAuto.instance:onAutoShootStop()
    end
end
