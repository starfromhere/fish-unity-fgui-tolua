---@class ProtoCatchAward
ProtoCatchAward = class("ProtoCatchAward")

--一次射击的上下文
function ProtoCatchAward:ctor()
    ---@type table
    self.p = nil

end


function ProtoCatchAward:getT()
    return self.p[1]
end

function ProtoCatchAward:getV()
    return self.p[2]
end

return ProtoCatchAward