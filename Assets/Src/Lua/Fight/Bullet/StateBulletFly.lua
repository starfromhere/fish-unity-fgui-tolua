---@class StateBulletFly
StateBulletFly = class("StateBulletFly")

---@param bullet Bullet
function StateBulletFly:enter(bullet)
end

---@param bullet Bullet
function StateBulletFly:execute(bullet)
    bullet:calcNextFramePos()
    if not GameScreen.instance:isInScreen(bullet.nextFramePos.x, bullet.nextFramePos.y) then
        bullet:reflect()
        bullet:calcNextFramePos()
    end
    bullet:pos(bullet.nextFramePos.x, bullet.nextFramePos.y)
end

---@param bullet Bullet
function StateBulletFly:exit(bullet)
end
