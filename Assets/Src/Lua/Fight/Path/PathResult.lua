---@class PathResult
PathResult = class("PathResult3D")

function PathResult:ctor()
    --兼容2d 3d坐标
    self.position = Vector3.New()


    --2d 鱼方向向量
    self.dirVec = Vector2.New()

    --2d 鱼角度
    self.rotation = 0
    --self.rotate = Vector3.New()

    self.isOver = false

    --鱼是否到炮附近，用于鳄鱼咬炮台判断
    self.isOverBattery = false

end



