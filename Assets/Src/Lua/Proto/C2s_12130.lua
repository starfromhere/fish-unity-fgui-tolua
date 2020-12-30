---详情见: http://183.131.147.91:8890/web/#/40?page_id=719
C2s_12130 = class("C2s_12130")
function C2s_12130:ctor()
    self.uid = nil -- 捕获的boss的uid
    self.fishes = nil -- 碰撞鱼的uid数组
    self.removeFishes = nil --移除的小鱼
    self.stage = 1 --当前阶段

    self.msgTmp = {} -- 发送消息的对象
end

function C2s_12130:reset()
    self.uids = nil
    self.fishes = nil
    self.stage = 1
    self.removeFishes = nil
end

function C2s_12130:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function C2s_12130.create()
    local item = Pool.createByClass(C2s_12130)
    return item
end

function C2s_12130:init(uid, fishes, stage, removeFishes)
    self.uid = uid
    self.fishes = fishes
    self.stage = stage or 1
    self.removeFishes = removeFishes
end

function C2s_12130:sendMsg()
    local catchFishes = self.fishes
    if (not catchFishes) then
        return
    end
    local msg = self.msgTmp
    msg.uid = self.uid
    msg.f = self.fishes
    msg.stage = self.stage
    msg.rf = self.removeFishes
    NetSender.BossLastCollision(msg)
    self:recover()
end