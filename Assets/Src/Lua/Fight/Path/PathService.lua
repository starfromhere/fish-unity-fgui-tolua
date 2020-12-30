PathService = class("PathService")

PathService._cachePath3D = {}
PathService._cachePath = {}

function PathService.createPath3D(pathContext)

    if PathService._cachePath3D[pathContext.pathId .. ""] then
        return PathService._cachePath3D[pathContext.pathId .. ""]

    else
        local path = BezierPath3D.new()
        path:init(pathContext.pathData)
        PathService._cachePath3D[pathContext.pathId .. ""] = path

        return PathService._cachePath3D[pathContext.pathId .. ""]
    end
end

function PathService.createPath2D(pathId, mirror)
    local path = PathService._cachePath[pathId]
    if path then
        path._mirror = mirror
        return path
    else
        local cfg = cfg_fishgrouppath.instance(pathId)
        if cfg then
            ---@type BezierPath2D
            local path = BezierPath2D.New()
            local fakeData = { cfg.path, cfg.segInfo, cfg.depth or 0 }
            local mirrorFlag = MirrorMapper.getMirrorFlagByPathMirror(mirror)

            path:init(pathId, mirrorFlag, fakeData)
            return path
        else
            Log.debug("不存在的路径", pathId)
            return nil
        end
    end
end

function PathService.createEyuPath()
    return EyuPath2D.New()
end