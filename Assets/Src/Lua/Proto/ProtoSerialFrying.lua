ProtoSerialFrying = class("ProtoSerialFrying")
function ProtoSerialFrying:ctor()
    self.points = nil -- 表现的设计坐标
    self.agentId = 0;
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    self.bRate = 0
    self.tp = 0 -- 总分
    self.sceneId = 0 -- 场景id
end

function ProtoSerialFrying:reset()
    self.points = nil
    self.agentId = 0;
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    self.bRate = 0
    self.tp = 0
    self.sceneId = 0
end

function ProtoSerialFrying:recover()
    self:reset()
end

function ProtoSerialFrying.create()
    local item = ProtoSerialFrying.New()
    return item
end

function ProtoSerialFrying:parse(data)
    self.startX = data.startX
    self.startY = data.startY
    self.endX = data.endX
    self.endY = data.endY
    self.bRate = data.bRate
    self.tp = data.tp
    self.points = data.points
    self.sceneId = data.sceneId
    self.agentId = data.agent;
end