
---@class GamePool
GamePool = class("GamePool")

GamePool.__dic = {}

function GamePool._getPoolBySign(sign)
    if not GamePool.__dic[sign] then
        GamePool.__dic[sign] = {}
    end
    return GamePool.__dic[sign]
end

function GamePool.getItemBySign(sign)
    local pool = GamePool._getPoolBySign(sign)
    if #pool > 0 then
        local item = pool[1]
        table.remove(pool, 1)
        Log.debug("从对象池获取",sign)
        return item
    else
        return nil
    end
end

function GamePool.recover(sign, item)
    Log.debug("对象池归还",sign,item)

    local pool = GamePool._getPoolBySign(sign)
    table.insert(pool, item)
end


