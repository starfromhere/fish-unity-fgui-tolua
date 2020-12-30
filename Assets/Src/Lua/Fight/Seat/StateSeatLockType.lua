---@class StateSeatLockTypeType

StateSeatLockType = class("StateSeatLockType")
---@param seat Seat
function StateSeatLockType:enter(seat)
    if not seat.laserWrapper then
        -- 播放激光粒子特效， 默认粒子特效y轴长度是1420
        local root = FishLayer.instance.bulletLayer
        local rpos = seat.laserBattery.parent:LocalToGlobal(Vector2.New(seat.laserBattery.position.x, seat.laserBattery.position.y))
        local rootPos = GRoot.inst:GlobalToLocal(Vector2.New(rpos.x, rpos.y));
        local laserWrapper, laser = EffectManager.playLaser(rootPos, root)
        seat.laser = laser
        seat.laserWrapper = laserWrapper
        --seat.laserEndPosWrapper = laserEndPosWrapper
    end
end

---@param seat Seat
function StateSeatLockType:execute(seat)
    seat:dealLockFishImg()

    -- 锁定鱼游出去了  换鱼
    if seat.lockFish and (not seat.lockFish:isValid() or not seat.lockFish:isInScreen()) then
        seat.lockFish = nil
        seat.laserLock = false
        if not seat.isOpenAuto then
            seat.fsm:changeState(StateSeatNormal)
        end
        return
    end

    ---@type ShootContext
    local ctx = ShootContext.New()
    if not seat.lockFish then
        local fishes = Fishery.instance:getFishByGroupLock(seat.lockType)
        local _, fish = next(fishes)
        if fish == nil then
            ctx.adaptEndPoint.x = seat.mouseX
            ctx.adaptEndPoint.y = seat.mouseY
            --Log.debug("StateSeatLockType   没有可选的鱼: ", seat.lockType)
            if seat.laserWrapper and not seat.laserLock then
                seat.laserWrapper.visible = false;
                SoundManager.StopEffectByUrl("Music/lockShoot.wav")
            end
            return
        end
        seat.lockFish = fish
    end
    local lockPoint = seat.lockFish:getLockPoint(Vector2.New(seat.shootStartX, seat.shootStartY))
    ctx.adaptEndPoint.x = lockPoint.x
    ctx.adaptEndPoint.y = lockPoint.y
    seat.laserWrapper.visible = true

    --seat.laserEndPosWrapper:SetPosition(seat.lockFish.fishPosition.x, seat.lockFish.fishPosition.y, 0)

    FightTools.TEMP_POINT3.x = lockPoint.x + seat.lockFish.offvec.x
    FightTools.TEMP_POINT3.y = lockPoint.y + seat.lockFish.offvec.y
    local angle = MathTools.vecToAngle(FightTools.TEMP_POINT3.x - seat.laserWrapper.position.x,
            FightTools.TEMP_POINT3.y - seat.laserWrapper.position.y) + 90
    seat.laserWrapper.rotation = angle
    local dis = Vector2.Distance({ x = seat.laserWrapper.position.x, y = seat.laserWrapper.position.y }, FightTools.TEMP_POINT3)
    local scaleY = dis / 7.59
    seat.laserWrapper:SetScale(1, scaleY)
    seat:laserShootContext()
    seat.laserLock = true
end

---@param seat Seat
function StateSeatLockType:exit(seat)
    if seat.laserWrapper then
        seat.laserWrapper.visible = false
        SoundManager.StopEffectByUrl("Music/lockShoot.wav")
    end
    seat.lockFish = nil
end