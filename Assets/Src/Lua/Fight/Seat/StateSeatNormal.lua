---@class StateSeatNormal
StateSeatNormal = class("StateSeatNormal")

---@param seat Seat
function StateSeatNormal:enter(seat)

    seat.shootIntervalSecond = seat.skinCfg.shootInterval
    if seat.waitComponent then
        seat.waitComponent.visible = false
    end
    seat.playerComponent.visible = true
end

---@param seat Seat
function StateSeatNormal:execute(seat)
    if (seat.isMouseDown or seat.isOpenAuto) and seat:canShoot() then
        if seat:checkLaserShoot() then
            return
        end
        
        --TODO
        ---@type ShootContext
        local ctx = ShootContext.New()
        ctx.adaptStartPoint.x = seat.shootStartX
        ctx.adaptStartPoint.y = seat.shootStartY
        ctx.adaptEndPoint.x = seat.mouseX
        ctx.adaptEndPoint.y = seat.mouseY
        ctx.seatId = seat.seatId
        ctx.skinId = seat.skinId
        ctx.battery = seat.battery

        ctx.hitCount = seat.skinCfg.catch_count
        seat:shoot(ctx)
    end
end

---@param seat Seat
function StateSeatNormal:exit(seat)
end
