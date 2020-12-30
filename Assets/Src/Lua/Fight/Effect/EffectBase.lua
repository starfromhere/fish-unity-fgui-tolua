---@class EffectBase
---@field New EffectBase
EffectBase = class("EffectBase")
function EffectBase:ctor()
end

---根据传入的对象类型标识字符，获取对象池中此类型标识的一个对象实例
---@param item 用于创建该类型对象的类。
---@return 此类型标识的一个对象。
function EffectBase:InitInfo()
    self:AddEvtLsn()
end

function EffectBase:AddEvtLsn()
    GameEventDispatch.instance:On(GameEvent.FightStop, self, self.Destroy)
end

function EffectBase:RmvEvtLsn()
    GameEventDispatch.instance:Off(GameEvent.FightStop, self, self.Destroy)
end

function EffectBase:Destroy()
    self:RmvEvtLsn()
    -- local sign = Pool._getClassSign(self)
    -- local items = Pool.getPoolBySign(sign)
    -- Log.debug("---->> pool items length before is: ", sign, " ", #items)
    Pool.clearByClass(self)
    -- items = Pool.getPoolBySign(sign)
    -- Log.debug("---->> pool items length after is: ", sign, " ", #items)
end