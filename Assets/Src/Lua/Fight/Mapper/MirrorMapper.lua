---@class MirrorMapper
MirrorMapper = class("MirrorMapper")

MirrorMapper.MIRROR_FLAG_nil = 0--0b00;左下
MirrorMapper.MIRROR_FLAG_X = 1--0b01;右下
MirrorMapper.MIRROR_FLAG_Y = 2--0b10;左上
MirrorMapper.MIRROR_FLAG_XY = 3--0b11;右上

--镜像类型
MirrorMapper.fish_path_mirror_nil = 1
MirrorMapper.fish_path_mirror_x = 2
MirrorMapper.fish_path_mirror_y = 3
MirrorMapper.fish_path_mirror_xy = 4

MirrorMapper.double_mirror_point_x = FightContext.instance.designWidth
MirrorMapper.double_mirror_point_y = FightContext.instance.designHeight

--获取相对位置
function MirrorMapper.getRelativeMirrorFlag(flagOrigin, flagRelative)
    return bit.bxor(flagOrigin, flagRelative)
end

--判断flag是否x镜像
function MirrorMapper.getMirrorXByFlag(flag)
    return bit.band(flag, MirrorMapper.MIRROR_FLAG_X) > 0
end

--判断flag是否y镜像
function MirrorMapper.getMirrorYByFlag(flag)
    return bit.band(flag, MirrorMapper.MIRROR_FLAG_Y) > 0
end

--[[
座位ID
4  3        0b10 0b11
1  2  ----> 0b00 0b01
历史遗留问题只能写死映射
]]
function MirrorMapper.getMirrorFlagBySeatId(seatId)

    if seatId == 1 then
        return MirrorMapper.MIRROR_FLAG_nil
    elseif seatId == 2 then
        return MirrorMapper.MIRROR_FLAG_X
    elseif seatId == 3 then
        return MirrorMapper.MIRROR_FLAG_XY
    elseif seatId == 4 then
        return MirrorMapper.MIRROR_FLAG_Y
    end

end

function MirrorMapper.getSeatIdByMirrorFlag(flag)
    if flag == MirrorMapper.MIRROR_FLAG_nil then
        return 1
    elseif flag == MirrorMapper.MIRROR_FLAG_X then
        return 2
    elseif flag == MirrorMapper.MIRROR_FLAG_Y then
        return 4
    elseif flag == MirrorMapper.MIRROR_FLAG_XY then
        return 3
    end
end
function MirrorMapper.mapVec2(vec, out, flag)
    if MirrorMapper.getMirrorXByFlag(flag) then
        out.x = vec.x * -1
    else
        out.x = vec.x

    end
    if MirrorMapper.getMirrorYByFlag(flag) then
        out.y = vec.y * -1
    else
        out.y = vec.y
    end
end

function MirrorMapper.map3DPoint(vec, out, flag)
    if MirrorMapper.getMirrorXByFlag(flag) then
        out.x = -vec.x
    else
        out.x = vec.x
    end
    if MirrorMapper.getMirrorYByFlag(flag) then
        out.y = -vec.y
    else
        out.y = vec.y
    end
    out.z = vec.z
end

function MirrorMapper.map2DPoint(p, out, flag)
    if MirrorMapper.getMirrorXByFlag(flag) then
        out.x = MirrorMapper.double_mirror_point_x - p.x
    else
        out.x = p.x
    end
    if MirrorMapper.getMirrorYByFlag(flag) then
        out.y = MirrorMapper.double_mirror_point_y - p.y
    else
        out.y = p.y
    end

end

--[[
cfg_fishgrouppath表里的mirror字段与位置的映射关系
2  4        0b10 0b11
1  3  ----> 0b00 0b01
历史遗留问题只能写死映射
]]
function MirrorMapper.getMirrorFlagByPathMirror(mirror)

    if mirror == 1 then
        return MirrorMapper.MIRROR_FLAG_nil
    elseif mirror == 2 then
        return MirrorMapper.MIRROR_FLAG_Y
    elseif mirror == 3 then
        return MirrorMapper.MIRROR_FLAG_X
    elseif mirror == 4 then
        return MirrorMapper.MIRROR_FLAG_XY
    end
    return MirrorMapper.MIRROR_FLAG_nil
end
