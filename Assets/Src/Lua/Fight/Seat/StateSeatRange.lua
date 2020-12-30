---@class StateSeatRange
---@field state number
StateSeatRange = class("StateSeatRange")

-- StateSeatRange.isTimeOut = false
-- StateSeatRange.state = 0 -- state的值的意义: 0: 不能发射子弹 1: 可以发射子弹但是没有发射 2: 已经发射了子弹
function StateSeatRange:ctor()
end
---@param seat Seat
function StateSeatRange:enter(seat)
    if seat then
        -- SeatRouter.instance:updateSizeById(seat.seatId)
    end
    seat.rangeState = 1
    
end

---@param seat Seat
function StateSeatRange:execute(seat)
    if seat.rangeState == 1 then
        local mouseX = seat.mouseX
        local mouseY = seat.mouseY
        if seat.seatId == SeatRouter.instance.mySeatId then
            if seat.rangeTimeOut then
                seat.rangeState = 2
                -- TODO
                ---@type ShootContext
                local ctx = ShootContext.New()
                ctx.adaptStartPoint.x = seat.shootStartX
                ctx.adaptStartPoint.y = seat.shootStartY
                ctx.adaptEndPoint.x = seat.mouseX
                ctx.adaptEndPoint.y = seat.mouseY
                ctx.seatId = seat.seatId
                ctx.skinId = seat.skinId
                ctx.battery = seat.battery

                ctx.uid = Fishery.instance:getBulletUid()
                ctx.hitCount = seat.skinCfg.catch_count
                seat:shoot(ctx)
            elseif seat.isMouseDown then
                seat:playShoot(mouseX, mouseY)
            end
        end
    end

end

---@param seat Seat
function StateSeatRange:exit(seat)
    
    if FightContext.instance.lockMode == FightConst.lock_mode_auto_shoot then
        -- SeatAuto.instance:onAutoShootStop()
    end
end