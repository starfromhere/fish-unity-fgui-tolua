---@class BezierPath2D
BezierPath2D = class("BezierPath2D")
function BezierPath2D:ctor()
    self._pathId = nil
    self._points = {}
    self._bezierPoints = {}
    self.depth = 0

    --路径总时间
    self._totalTime = 0

    self._segNum = nil
    self._cached = false
    self._startPoint = Vector2.New()
    self._endPoint = Vector2.New()
    self._bezierPoint = Vector2.New()
    self._startTime = nil
    self._endTime = nil
    self._segTotalTime = nil
    self._T = nil
    self._1_T = nil
    self._derivationX = nil
    self._derivationY = nil
    self._X = nil
    self._Y = nil
    self._mirror = nil
    self._direct_vec2 = Vector2.New()
    self._tmpPoint = Vector2.New()

    --需要根据位置做镜像
    self.needMirror = true
end
function BezierPath2D:_cache_data(sec)
    local curSegIndex = self:getSegIndexByTime(sec)
    local pointStartIndex = curSegIndex * 2 + 1
    local bezierPointIndex = curSegIndex * 3 + 1
    self._startPoint:Set(self._points[pointStartIndex], self._points[pointStartIndex + 1])
    self._endPoint:Set(self._points[pointStartIndex + 2], self._points[pointStartIndex + 3])
    self._bezierPoint:Set(self._bezierPoints[bezierPointIndex], self._bezierPoints[bezierPointIndex + 1])
    self._endTime = self._bezierPoints[bezierPointIndex + 2]
    if curSegIndex == 0 then
        self._startTime = 0
    else
        self._startTime = self._bezierPoints[bezierPointIndex - 1]
    end
    if self._endTime then
        self._segTotalTime = self._endTime - self._startTime
    else
        --TODO
        local LogTools = require 'Util.Serpent'
        Log.error("_endTime error: ", LogTools.block(self),"pathid-----",self._pathId)
        -- 加一个保护
        self._endTime = self._bezierPoints[#self._bezierPoints]
        self._segTotalTime = self._endTime - self._startTime
    end
end
function BezierPath2D:_calc(sec)
    if self._cached then
        if sec > self._endTime then
            self:_cache_data(sec)
        end
    else
        self:_cache_data(sec)
        self._cached = true
    end
    self._T = (sec - self._startTime) / self._segTotalTime
    self._1_T = 1 - self._T
    self._X = self._1_T * self._1_T * self._startPoint.x + 2 * self._1_T * self._T * self._bezierPoint.x + self._T * self._T * self._endPoint.x
    self._Y = self._1_T * self._1_T * self._startPoint.y + 2 * self._1_T * self._T * self._bezierPoint.y + self._T * self._T * self._endPoint.y

    --求导数
    self._derivationX = -2 * (self._1_T) * self._startPoint.x + 2 * (self._1_T - self._T) * self._bezierPoint.x + 2 * self._T * self._endPoint.x
    self._derivationY = -2 * (self._1_T) * self._startPoint.y + 2 * (self._1_T - self._T) * self._bezierPoint.y + 2 * self._T * self._endPoint.y
    self._direct_vec2.x = self._derivationX
    self._direct_vec2.y = self._derivationY
    MirrorMapper.mapVec2(self._direct_vec2, self._direct_vec2, self._mirror)

    self._direct_vec2:SetNormalize()
end

---@param out PathResult
function BezierPath2D:move(sec, out)
    if sec >= self._totalTime then
        out.isOver = true
        return
    else
        out.isOver = false
    end

    self:_calc(sec)

    --2d路径基于1280 * 720 放大到1920 * 1080
    self._X = self._X * 1.5
    self._Y = self._Y * 1.5

    self._tmpPoint:Set(self._X, self._Y)

    GameScreen.instance:designToAdapt(self._tmpPoint, self._tmpPoint)
    MirrorMapper.map2DPoint(self._tmpPoint, self._tmpPoint, self._mirror)

    out.position.x = self._tmpPoint.x
    out.position.y = self._tmpPoint.y
    out.dirVec.x = self._direct_vec2.x
    out.dirVec.y = self._direct_vec2.y
    out.rotation = MathTools.vecToAngle(out.dirVec.x, out.dirVec.y)
end

function BezierPath2D:getSegIndexByTime(sec)
    for i = 0, self._segNum - 1 do
        if self._bezierPoints[i * 3 + 3] > sec then
            return i
        end
    end
    return self._segNum
end

function BezierPath2D:init(pathId, mirror, pathData)
    self._pathId = pathId
    self._mirror = mirror
    self.depth = pathData[3] or 0

    self._points = pathData[1]
    self._bezierPoints = pathData[2]

    self._totalTime = self._bezierPoints[#self._bezierPoints]
    self._segNum = #self._bezierPoints / 3
end

