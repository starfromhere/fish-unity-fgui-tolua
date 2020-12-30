---@class LoadTipM
---@field public instance LoadTipM
LoadTipM = class("LoadTipM")
function LoadTipM:ctor()
    self._idArr = nil
    self._contentArr = nil
    self._getInRoomFailCount = 0

end

function LoadTipM:getIndex(len)
    local index = math.floor(math.random(1, len))
    return index
end

function LoadTipM:getInRoomFailCount(value)
    if value ~= nil then
        self._getInRoomFailCount = value
    else
        return self._getInRoomFailCount
    end

end




        