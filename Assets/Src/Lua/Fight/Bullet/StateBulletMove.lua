---@class StateBulletMove
StateBulletMove = class("StateBulletMove")

---@param bullet Bullet
function StateBulletMove:enter(bullet)
end

---@param bullet Bullet
function StateBulletMove:execute(bullet)
    bullet:calcNextFramePos()
    if not GameScreen.instance:isInScreen(bullet.nextFramePos.x, bullet.nextFramePos.y) then
        bullet:reflect()
        bullet:calcNextFramePos()
    end
    bullet:pos(bullet.nextFramePos.x, bullet.nextFramePos.y)
    if bullet.skinCfg.id == FightConst.skin_type_jiguangpao then
        bullet.fsm:changeState(StateBulletWait.instance)
        bullet.fsm._currentState:bullet(bullet)
    else
        local lockFish = bullet.seat.lockFish
        if bullet.lockFishUid and lockFish and bullet.lockFishUid ~= lockFish.uniId then
            lockFish = Fishery.instance:findFishByUniId(bullet.lockFishUid)
        end
        if lockFish then
            --bullet:lerpLookAt(lockFish.fishWrapper.x, lockFish.fishWrapper.y, 60)
            --local isHit = lockFish:pointCollisionDetect(bullet.nextFramePos.x, bullet.nextFramePos.y)
            --if isHit then
            --    bullet:hit(lockFish)
            --end
            bullet:checkHit(lockFish)
        else
            local fish = Fishery.instance:pointCollision(bullet.nextFramePos.x, bullet.nextFramePos.y)
            if fish then
                bullet:hit(fish)
            end
        end
    end
end

---@param bullet Bullet
function StateBulletMove:exit(bullet)
end
