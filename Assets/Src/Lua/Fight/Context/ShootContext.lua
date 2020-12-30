---@class ShootContext
ShootContext = class("ShootContext")

--一次射击的上下文
function ShootContext:ctor()
    self.seatId = nil
    self.battery = nil
    self.skinId = nil
    ---@type Vector2
    self.adaptStartPoint = Vector2.New()
    ---@type Vector2
    self.adaptEndPoint = Vector2.New()
    self.uid = nil
    self.hitCount = nil
    self.isMain = nil
    self.agentId = nil
    self.fuid = nil
end
---@return ShootContext
function ShootContext:clone()
    local newCtx = ShootContext.new()
    newCtx.seatId = self.seatId
    newCtx.battery = self.battery
    newCtx.skinId = self.skinId
    newCtx.adaptStartPoint = self.adaptStartPoint:Clone()
    newCtx.adaptEndPoint = self.adaptEndPoint:Clone()
    newCtx.uid = self.uid
    newCtx.hitCount = self.hitCount
    newCtx.isMain = self.isMain
    newCtx.agentId = self.agentId
    newCtx.fuid = self.fuid
    return newCtx
end