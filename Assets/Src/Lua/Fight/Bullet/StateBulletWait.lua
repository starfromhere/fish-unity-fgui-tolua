---@class StateBulletWait
StateBulletWait = class("StateBulletWait")

---@param bullet Bullet
function StateBulletWait:enter(bullet)
end

---@param bullet Bullet
function StateBulletWait:execute(bullet)
    -- Log.error( StateBulletWait.state)
    -- if StateBulletWait.state ~= 1 then return end
    -- local pt = bullet.bulletWrapper:GetChild("center"):LocalToGlobal(Vector2.New());
    -- local bulletRect = CollisionRect.create(pt.x, pt.y, bullet.bulletWrapper.width, bullet.bulletWrapper.height, bullet.rootSp.rotation)
    -- local hitarr = Fishery.instance:rectCollision(bulletRect)
    -- bullet:hitFishs(hitarr)
    -- bullet.fsm:changeState(StateBulletHit.instance)
end

function StateBulletWait:bullet(bullet)
--     local pt = Vector2.New()
--     pt.x = bullet.rootSp.x
--     pt.y = bullet.rootSp.y

--     local holder = UIPackage.CreateObject("BulletsFrames", "zidan11")
--     -- local holder = GGraph.New()
-- holder.pivot = Vector2.New(0.5, 0.5)
-- holder.pivotAsAnchor = true
-- --  holder:DrawRect(bullet.bulletWrapper.width, bullet.bulletWrapper.height,1, Color.New(0, 125, 0, 1), Color.New(125, 0, 0, 1))
-- holder.rotation = bullet.rootSp.rotation
-- FishLayer.instance.effectLayer:AddChild(holder)
-- holder.position = Vector2.New(pt.x+FightTools.CalCosBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2,pt.y+FightTools.CalSinBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2)
--     local decorate = UIPackage.CreateObject("Fish", "lock").asImage
--      decorate.pivot = Vector2.New(0.5, 0.5)
--      decorate.pivotAsAnchor = true
--      decorate.position = Vector2.New(pt.x+FightTools.CalCosBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2,pt.y+FightTools.CalSinBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2)
--      FishLayer.instance.effectLayer:AddChild(decorate)
    -- local bulletRect = CollisionRect.create(bullet.rootSp.x+FightTools.CalCosBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2,bullet.rootSp.y+FightTools.CalSinBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2, bullet.bulletWrapper.width, bullet.bulletWrapper.height, bullet.rootSp.rotation)
    -- local hitarr = Fishery.instance:rectCollision(bulletRect)
    
    -- local arr = {}
    -- for _,fish in pairs(hitarr) do
    --         table.insert(arr, fish.uniId)
    -- end
    -- luadump(arr)
    local o1 = obb.New(Vector2.New(bullet.rootSp.x+FightTools.CalCosBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2,bullet.rootSp.y+FightTools.CalSinBySheet(bullet.rootSp.rotation)*bullet.bulletWrapper.width/2),Vector2.New(bullet.bulletWrapper.width, bullet.bulletWrapper.height),bullet.rootSp.rotation)
    local hitarr2 = Fishery.instance:obbCollision(o1)
    --  arr = {}
    -- for _,fish in pairs(hitarr2) do
    --     table.insert(arr, fish.uniId)
    -- end
    -- luadump(arr)
    bullet:hitFishs(hitarr2)
    -- bullet.fsm:changeState(StateBulletHit.instance)
end

---@param bullet Bullet
function StateBulletWait:exit(bullet)
end
