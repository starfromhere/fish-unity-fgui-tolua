--将所有的协议移动到这里


---@class S2C_12021 @玩家退出
C2s_12021 = {
    ---@type number
    seat_id = nil,
    ---@type number
    battery = nil,
    ---@type number
    cskin = nil
}

---@class S2C_12026 @进入房间
S2c_12026 = {
    seat_id = 0,
    scene_id = 0,
    ccoin = 0,
    cscore = 0,
    end_time = 0,
    closeRoom = false
}

---@class C2S_12027_ShootBullet @发射子弹
C2s_shootBullet = {
    startX = nil,
    startY = nil,
    endX = 0,
    endY = 0,
    sk = 0,
    bt = 0,
    sr = nil,
    index = 0,
    lock = 0,
    fuid = 0,
    uid = 0,
    m = 0,
    tick = 0,
}

---@class SkillInfo
SkillInfo = {
    id = 0,
    cd = 0
}

---@class C2S_17001 @使用技能
C2s_17001 = {
    id = 0,
    uid = 0,
    x = 0,
    y = 0,
    rp = 0,
    index = 0
}

---@class S2C_17002 @释放技能回包
S2c_17002 = {
    code = 0,
    id = 0
}

---@class S2C_17003 @同步技能信息
S2C_SkillInfo_17003 = {
    ---@type SkillInfo[]
    info = nil
}

---@class S2C_12028
S2c_12028 = class("S2c_12028")
function S2c_12028:ctor()
    self.time = nil
end

---@class S2C_12029 @使用鱼雷
S2c_12029 = class("S2c_12029")
function S2c_12029:ctor()
    self.sid = 0
    self.uid = 0
    self.x = nil
    self.y = nil
    self.seat_id = 0
    self.coin = 0
    self.agent = 0

end

---@class S2C_12023 @鱼潮
S2c_12023 = class("S2c_12023")
function S2c_12023:ctor()
    self.d = nil
    self.t = nil
end

---@class ProtoFightPlayerCoint
ProtoFightPlayerCoint = class("ProtoFightPlayerCoint")
function ProtoFightPlayerCoint:ctor()
    self.agent = 0
    self.seat_id = 0
    self.coin = 0
end

---@class S2C_12015 @射击子弹返回
S2c_12015 = class("S2c_12015")
function S2c_12015:ctor()
    self.code = 0
    self.coin = 0
    self.ac = 0
    self.dbCount = 0
    self.awardScore = nil
    self.prize = nil
    self.bcoin = 0
    self.ccoin = 0
end

---@class ProtoFightEatCoinRet
ProtoFightEatCoinRet = class("ProtoFightEatCoinRet")
function ProtoFightEatCoinRet:ctor()
    self.agent = 0
    self.seat_id = 0
    self.coin = 0

end

---@class S2C_12030
S2c_12030 = class("S2c_12030")
function S2c_12030:ctor()
    self.seat_id = 0
    self.sid = 0
    self.lvet = nil
end

---使用锁定技能
---@class S2C_12033
S2c_12033 = class("S2c_12033")
function S2c_12033:ctor()
    self.seat_id = 0
    self.lock_et = nil
    self.lock_uid = 0
    self.lock_sid = 0
end

---@class S2c_handshake_10000
S2c_handshake = class("S2c_handshake")
function S2c_handshake:ctor()
    self.uuid = nil
    self.in_fight = false
    self.time = 0
    self.gold_pool_value = nil
    self.enter_main = 0
    self.uid = nil
    self.shop_rate = nil

end

---@class S2C_10008
S2c_10008 = class("S2c_10008")
function S2c_10008:ctor()
    self.coin = 0
    self.fcount = 0
    self.fcoin = 0
    self.exp = 0
    self.diamond = 0
    self.bcoin = 0
    self.cscore = 0
end

---@class S2C_12100
S2C_12100 = {
    master_seat_id = 0
}

---@class S2C_12108
S2C_12108 = {
    playerNum = 0
}

---@class S2C_12102
S2C_12102 = {
    prepare_status = {}
}
