---@class GoodsFlyManager
---@field public instance GoodsFlyManager
GoodsFlyManager = class("GoodsFlyManager")

function GoodsFlyManager:ctor()
    self.flyEffectArray = {}
end

function GoodsFlyManager:loop(delta)
    if #self.flyEffectArray <= 0 then
        return
    end
    for i = #self.flyEffectArray, 1, -1 do
        local flyEffect = self.flyEffectArray[i]
        if flyEffect:isEnd() then
            flyEffect:destroy()
            table.remove(self.flyEffectArray, i)
        else
            flyEffect:update(delta)
        end
    end
    -- for _, v in ipairs(self.flyEffectArray) do
    --     v:update(delta)
    -- end
    -- self:removeInvalidEffect()
end

function GoodsFlyManager:removeInvalidEffect(removeAll)
    if not removeAll then
        removeAll = false
    end
    for i = #self.flyEffectArray, 1, -1 do
        local flyEffect = self.flyEffectArray[i]
        if flyEffect:isEnd() or removeAll then
            flyEffect:destroy()
            table.remove(self.flyEffectArray, i)
        end
    end
end

---@param effect GoodsFlyEffect
function GoodsFlyManager:addFlyEffect(effect)
    table.insert(self.flyEffectArray, effect)
end
