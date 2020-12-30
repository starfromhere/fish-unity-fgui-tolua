---@class CollisionRect
---@field New CollisionRect
--   两矩形相交非轴对称OBB
--   see: https://juejin.im/post/5d6927baf265da03b810760e#heading-12
CollisionRect = class("CollisionRect")
function CollisionRect:ctor()
    self.x = 0 -- x坐标
    self.y = 0 -- y坐标
    self.width = 0
    self.height = 0
    self.anchorX = 0 -- x轴锚点,值为0-1
    self.anchorY = 0 -- y轴锚点,值为0-1
    self.pivotX = 0 -- x轴心点
    self.pivotY = 0 -- y轴心点
    self.rotation = 0 -- 旋转角度

    self.vecC = Vector2.New() -- 轴心点坐标
    self.vecAxisX = Vector2.New(1, 0) -- 未旋转时的对称轴X
    self.vecAxisY = Vector2.New(0, 1) -- 未旋转时的对称轴Y
    self.vecAxisXR = Vector2.New(1, 0) -- 旋转时的对称轴X
    self.vecAxisYR = Vector2.New(0, 1) -- 旋转时的对称轴Y
    self.VERTEX_NUM = 4 -- 顶点数
    self.vertexs = {} -- 顶点数组
    self.vertexsR = {}

    self.tmp = Vector2.New()
end

function CollisionRect.create(x, y, width, height, rotation)
    local item = Pool.createByClass(CollisionRect)
    item:init(x, y, width, height, rotation)
    return item
end

function CollisionRect:reset()
    self.vertexs = nil
    self.vertexsR = nil
end

function CollisionRect:recover()

    self:reset()
    Pool.recoverByClass(self)
end

function CollisionRect:init(x, y, width, height, rotation)
    self:reset()
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.rotation = rotation % 360
    self.vecC:Set(self.x, self.y)
    -- TODO 暂时按轴心点在矩形的中心来处理
    self.anchorX = 0.5
    self.anchorY = 0.5
    self.pivotX = self.width * self.anchorX
    self.pivotY = self.height * self.anchorY

    self.vertexs = {}
    self.vertexsR = {}
    local vex = nil --- 没有旋转的顶点坐标
    local vexR = nil --- 旋转后的顶点
    for i = 1, self.VERTEX_NUM, 1 do
        vex = Vector2.New()
        vexR = Vector2.New()
        if i <= 2 then
            vex.y = self.y - self.pivotY
        else
            vex.y = self.height + self.y - self.pivotY
        end
        if i == 1 or i == 3 then
            vex.x = self.x - self.pivotX
        else
            vex.x = self.width + self.x - self.pivotX
        end
        table.insert(self.vertexs, vex)
        table.insert(self.vertexsR, vexR)
    end
end

function CollisionRect:vecC(value)
    if nil == value then
        return self.vecC
    else
        self.vecC = value
    end
end

-- 计算上旋转后的对称轴X
function CollisionRect:axisX(value)
    if nil == value then
        local ret = self.vecAxisXR
        self:calcVecAxis(self.vecAxisX, ret)
        return ret
    else
        self.vecAxisXR = value
    end
end

-- 计算上旋转后的对称轴Y
function CollisionRect:axisY()
    if nil == value then
        local ret = self.vecAxisYR
        self:calcVecAxis(self.vecAxisY, ret)
        return ret
    else
        self.vecAxisYR = value
    end
end

function CollisionRect:calcVecAxis(vec2, out)
    local ret = out
    ret:Set(vec2.x, vec2.y)
    if self.rotation % 360 ~= 0 then
        FightTools:rotateVec2(ret, self.rotation, ret)
    end
end

function CollisionRect:calcVecVertex(vec2, out)
    local ret = out
    ret:Set(vec2.x, vec2.y)
    if self.rotation % 360 ~= 0 then
        local tmp = self.tmp
        FightTools:subtractVec2(self.vecC, vec2, tmp)
        FightTools:rotateVec2(tmp, self.rotation, tmp)
        FightTools:addVec2(self.vecC, tmp, ret)
    end
end

function CollisionRect:vertexs()
    if nil == value then
        local ret = self.vertexsR
        local l = #ret
        for i, _ in ipairs(ret) do
            self:calcVecVertex(self.vertexs[i], self.vertexsR[i])
        end
        return ret
    else
        self.vertexsR = value
    end
end

function CollisionRect:getProjections(axis)
    local vertexs = self.vertexs
    local projections = {}
    for _, vex in ipairs(vertexs) do
        table.insert(projections, Vector2.Dot(vex, axis))
    end
    table.sort(projections, function(val1, val2)
        return val1 < val2
    end)
    return projections
end

function CollisionRect:OBBrectRectIntersect(src, target)
    local srcAxisX = src:axisX()
    local srcAxisY = src:axisY()
    local targetAxisX = target:axisX()
    local targetAxisY = target:axisY()
    -- 4轴投影都相交,则两矩形发生碰撞
    return CollisionRect:isCrossed(src, target, srcAxisX) and CollisionRect:isCrossed(src, target, srcAxisY) and CollisionRect:isCrossed(src, target, targetAxisX) and CollisionRect:isCrossed(src, target, targetAxisY)
end

function CollisionRect:isCrossed(src, target, axis)
    local srcProjections = src:getProjections(axis)
    local targetProjections = target:getProjections(axis)
    local srcMin = srcProjections[1] -- 矩形src最小长度的投影
    local srcMax = srcProjections[#srcProjections - 1] -- 矩形src最大长度的投影
    local targetMin = targetProjections[1] -- 矩形src最小长度的投影
    local targetMax = targetProjections[#targetProjections - 1] -- 矩形target最大长度的投影
    return srcMax >= targetMin and srcMin <= targetMax
end