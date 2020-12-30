C2s_12120 = class("C2s_12120")
function C2s_12120:ctor()
    self.points = nil -- 表现的设计坐标
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    self.bRate = 0
    self.tp = 0 -- 总分
    self.sceneId = 0 -- 场景id

    self.msgTmp = {} -- 发送消息的对象
end

function C2s_12120:reset()
    self.points = nil
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    self.bRate = 0
    self.tp = 0
    self.sceneId = 0
end

function C2s_12120:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function C2s_12120.create()
    local item = Pool.createByClass(C2s_12120)
    return item
end

function C2s_12120:init(startX, startY, endX, endY, bRate, tp, points, sceneId)
    self.startX = startX
    self.startY = startY
    self.endX = endX
    self.endY = endY
    self.bRate = bRate
    self.tp = tp
    self.points = points
    self.sceneId = sceneId
end

function C2s_12120:sendMsg()
    local msg = self.msgTmp
    msg.startX = self.startX
    msg.startY = self.startY
    msg.endX = self.endX
    msg.endY = self.endY
    msg.bRate = self.bRate
    msg.tp = self.tp
    msg.points = self.points
    msg.sceneId = self.sceneId
    NetSender.BombFish(msg)
    self:recover()
end