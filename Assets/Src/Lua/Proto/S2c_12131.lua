---详情见: http://183.131.147.91:8890/web/#/40?page_id=719
S2c_12131 = class("S2c_12131")
function S2c_12131:ctor()
    self.fishId = 0
    self.agentId = 0 -- 玩家agent
    self.uid = 0 -- 觉醒boss uid
    self.stage = 0 -- 阶段
    self.award = 0 -- 阶段总奖励
    self.end_stage = 0 -- 共有多少个阶段
end

function S2c_12131:reset()
    self.fishId = 0
    self.agentId = 0
    self.uid = 0
    self.stage = 0
    self.award = 0
end

function S2c_12131:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function S2c_12131.create()
    local item = Pool.createByClass(S2c_12131)
    return item
end

function S2c_12131:parse(data)
    self.fishId = data.fishId
    self.agentId = data.agent
    self.uid = data.uid
    self.stage = data.stage
    self.award = data.award
    self.end_stage = data.end_stage
end