---@class BezierPath3D
BezierPath3D = class("BezierPath3D")
function BezierPath3D:ctor()
    self._dirVector3 = Vector3.New()
end

function BezierPath3D:init(pathData)
    self._pathPoints = pathData["points"]
    self._segInfo = pathData["segs"]
    self._eulers = pathData["eulers"]
    self._segNum = #self._pathPoints / 3 - 1
    local pointStartIndex = 1
    local startX = self._pathPoints[pointStartIndex]
    local startY = self._pathPoints[pointStartIndex + 1]
    local startZ = self._pathPoints[pointStartIndex + 2]
    local pointEndIndex = self._segNum * 3
    local endX = self._pathPoints[pointEndIndex]
    local endY = self._pathPoints[pointEndIndex + 1]
    local endZ = self._pathPoints[pointEndIndex + 2]
    self._dirVector3:Set(endX - startX, endY - startY, endZ - endZ)
    self:_calcTotalTime()
end

function BezierPath3D:_calcTotalTime()
    self._totalTime = 0
    for i = 1, self._segNum do
        self._totalTime = self._totalTime + self._segInfo[i * 7]
    end
end

function BezierPath3D:getSegIndexByTime(time)
    local curSegNum = 0
    for i = 0, self._segNum - 1 do
        self.segEndTime = self._segInfo[i * 7 + 7]
        if self.segEndTime > time then
            return i
        end
    end
    return self._segNum
end

function BezierPath3D:move(time, out)
    local curSegIndex = self:getSegIndexByTime(time)
    out.isOver = curSegIndex == self._segNum
    if out.isOver then
        return
    end

    local pointStartIndex = curSegIndex * 3 + 1
    local bezierPointBegin = curSegIndex * 7 + 1
    local startX = self._pathPoints[pointStartIndex]
    local startY = self._pathPoints[pointStartIndex + 1]
    local startZ = self._pathPoints[pointStartIndex + 2]
    local endX = self._pathPoints[pointStartIndex + 3]
    local endY = self._pathPoints[pointStartIndex + 4]
    local endZ = self._pathPoints[pointStartIndex + 5]
    local p1X = self._segInfo[bezierPointBegin]
    local p1Y = self._segInfo[bezierPointBegin + 1]
    local p1Z = self._segInfo[bezierPointBegin + 2]
    local p2X = self._segInfo[bezierPointBegin + 3]
    local p2Y = self._segInfo[bezierPointBegin + 4]
    local p2Z = self._segInfo[bezierPointBegin + 5]
    local bezierStartTime = bezierPointBegin > 0 and self._segInfo[bezierPointBegin - 1] or 0
    local bezierEndTime = self._segInfo[bezierPointBegin + 6]
    local bezierLastTime = bezierEndTime - bezierStartTime
    local T = (time - bezierStartTime) / bezierLastTime
    local MT = 1 - T
    local pow2T = T * T
    local pow2MT = MT * MT
    local p1 = pow2MT * MT
    local p2 = 3 * T * pow2MT
    local p3 = 3 * pow2T * MT
    local p4 = pow2T * T
    out.position.x = p1 * startX + p2 * p1X + p3 * p2X + p4 * endX
    out.position.y = p1 * startY + p2 * p1Y + p3 * p2Y + p4 * endY
    out.position.z = p1 * startZ + p2 * p1Z + p3 * p2Z + p4 * endZ
    --out.rotate.x = 0
    --out.rotate.y = 0
    --out.rotate.z = self:getRotateZ(time)

end

