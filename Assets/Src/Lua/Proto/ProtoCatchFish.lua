---@class ProtoCatchFish
ProtoCatchFish = class("ProtoCatchFish")
function ProtoCatchFish:ctor()
    self.p = nil
    self.seat_info = nil
end
function ProtoCatchFish:getFishUid()
    return self.p[1]
end
function ProtoCatchFish:getAward()
    return self.p[2]
end
function ProtoCatchFish:getAgent()
    return self.p[3]
end
function ProtoCatchFish:getB()
    return self.p[4]
end
function ProtoCatchFish:getShowAwardInfo()
    return self.p[5]
end
