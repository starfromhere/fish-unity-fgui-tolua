C2s_12122 = class("C2s_12122")
function C2s_12122:ctor()
    self.uids = nil -- 鱼的uid数组
    self.type = FightConst.fish_death_type_none
    self.isEnd = 0 -- 是否是最后一波,只有1是真不填或其他是否

    self.msgTmp = {} -- 发送消息的对象
    -- TODO 临时加一个agentId,解决客户端都会放送消息导致消息里的agent不对的bug
    self.agentId = 0
end

function C2s_12122:reset()
    self.uids = nil -- 鱼的uid数组
    self.type = FightConst.fish_death_type_none
    self.agentId = 0
end

function C2s_12122:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function C2s_12122.create()
    local item = Pool.createByClass(C2s_12122)
    return item
end

function C2s_12122:init(fishes, dType, isEnd, agentId)
    self.uids = fishes
    self.type = dType
    if isEnd then
        self.isEnd = 1
    else
        self.isEnd = 0
    end
    self.agentId = agentId or 0
end

function C2s_12122:sendMsg()
    if (not self.uids) then
        -- isEnd和服务端刷新螃蟹有关系，如果isEnd = 1, 即使捕获的数组为空,也需要发送
        if self.isEnd ~= 1 then
            return
        end
        self.uids = {}
    end
    local msg = self.msgTmp
    msg.uids = self.uids
    msg.type = self.type
    msg.isEnd = self.isEnd
    msg.agent = self.agentId
    NetSender.MoveOutFish(msg)
    self:recover()
end