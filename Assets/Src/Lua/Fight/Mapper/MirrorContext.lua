---@class MirrorContext
MirrorContext = class("MirrorContext")

function MirrorContext:ctor(seatId)
    self.mirrorFlag = MirrorMapper.getMirrorFlagBySeatId(seatId)
end

---@return boolean
function MirrorContext:mirrorX()
    return bit.band(self.mirrorFlag, MirrorMapper.MIRROR_FLAG_X) > 0
end

---@return boolean
function MirrorContext:mirrorY()
    return bit.band(self.mirrorFlag, MirrorMapper.MIRROR_FLAG_Y) > 0
end


