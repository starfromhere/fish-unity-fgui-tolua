StateBulletHit = class("StateBulletHit")

---@param bullet Bullet
function StateBulletHit:enter(bullet)

    bullet.hitCount = bullet.hitCount - 1

    if not bullet.seat:isLockPao() then
        BulletFactory.createBulletNet(bullet)
    end
    
    local skinId = 0
    if bullet and bullet.skinCfg and bullet.skinCfg.id then
        skinId = bullet.skinCfg.id
    end    
    
    -- 钻头炮的碰撞特殊处理
    if FightConst.skin_type_zuantoupao == skinId then    
        -- 第一次碰撞的时候启动计数器
        if bullet.hitCount == bullet.skinCfg.catch_count - 1 then
            bullet.seat:onZuantoupaoFirstHit(bullet)
        end
    end

    if skinId == FightConst.skin_type_jiguangpao then
        Fishery.instance:removeBullet(bullet)
        bullet:destroy()
    elseif bullet.hitCount <= 0 then    
        -- 钻头炮的销毁特殊处理
        if FightConst.skin_type_zuantoupao == skinId then    
            bullet.speed = bullet.speed / 2
            -- 使新设置的速度生效
            bullet:onChangeDirVec()
            bullet.fsm:changeState(StateBulletFly)
            -- 根据服务端的消息播放表现
            -- bullet.seat:onZuantoupaoBurst(bullet)
        else
            Fishery.instance:removeBullet(bullet)
            bullet:destroy()
        end
        --else
        --    local lockFish = bullet.seat.lockFish
        --    if lockFish and lockFish:isValid() then
        --        if bullet:isCrossLockPoint() then
        --            bullet.fsm:revertToPrevState()
        --        else
        --            bullet.fsm:changeState(StateBulletMove.instance)
        --        end
        --    else
        --        bullet.fsm:changeState(StateBulletMove.instance)
        --    end
    else
        bullet.fsm:changeState(StateBulletMove)
    end
end

---@param bullet Bullet
function StateBulletHit:execute(bullet)
end

---@param bullet Bullet
function StateBulletHit:exit(bullet)
end