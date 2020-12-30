---详情见: http://183.131.147.91:8890/web/#/40?page_id=719
S2c_12132 = class("S2c_12132")
function S2c_12132:ctor()
    self.agentId = 0 -- 玩家agent
    self.uid = 0 -- 觉醒boss uid
    self.base_award = 0 -- 基础奖励
    self.extra_award = 0 -- 阶段总奖励
    self.out_room = 0 --是否玩家主动退出
end

function S2c_12132:reset()
    self.agentId = 0
    self.uid = 0
    self.base_award = 0
    self.extra_award = 0
    self.out_room = 0
end

function S2c_12132:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function S2c_12132.create()
    local item = Pool.createByClass(S2c_12132)
    return item
end

function S2c_12132:parse(data)
    self.agentId = data.agent
    self.uid = data.uid
    self.base_award = data.base_award
    self.extra_award = data.extra_award
    self.out_room = data.out_room
end