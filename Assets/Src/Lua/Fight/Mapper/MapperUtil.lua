---@class MapperUtil
MapperUtil = class("MapperUtil")

function MapperUtil.mapperPointBySeatId(p1, out, fromSeatId)
    local mySeat = SeatRouter.instance.mySeat
    local seat = SeatRouter.instance:getSeatById(fromSeatId)
    local relativeMirrorFlag = MirrorMapper.getRelativeMirrorFlag(mySeat.mirrorFlag, seat.mirrorFlag)
    MirrorMapper.map2DPoint(p1, out, relativeMirrorFlag)
end

