---@class BulletFactory
BulletFactory = class("BulletFactory")
function BulletFactory:ctor()

end

---@param bullet Bullet
function BulletFactory.createBulletNet(bullet)
    local prefabUrl = "FortsEffects/" .. bullet.skinCfg.web_down

    ---@type GGraph
    local bulletGraph = GGraph.New()
    FishLayer.instance.bulletLayer:AddChild(bulletGraph)

    local spine = SpineManager.create(prefabUrl,
            Vector2.New(0, 0), 1, bulletGraph)

    spine:setPosition(bullet.nextFramePos.x, bullet.nextFramePos.y)

    ---@param spine SpineManager
    local endHandler = function(spine)
        spine:destroy()
    end
    spine:play("animation", false, endHandler)
end
--
-----@return Bullet
--function BulletFactory.createBullet(context)
--    -- TODO：对象池
--    ---@type Bullet
--    local bullet
--    if bullet then
--        bullet:init(context)
--    else
--        bullet = Bullet.New()
--        bullet:init(context)
--    end
--    return bullet
--end

---@param shootContext ShootContext
---@return Bullet
function BulletFactory.createBullet(shootContext)
    ---@type Bullet
    local bullet = Bullet.New()
    bullet:init(shootContext)
    return bullet
end

function BulletFactory.recoverBulletNet(spine)
    spine:removeSelf()
    spine:paused()
    Pool:recover(spine:getSpineName(), spine)
end

function BulletFactory.recoverBullet(bullet)
    Pool:recover(bullet.context:cacheSign(), bullet)
end


