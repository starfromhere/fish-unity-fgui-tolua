---@class CmdGateOut
---@field public instance CmdGateOut
CmdGateOut = class("CmdGateOut")

function CmdGateOut:send(id, msg)
    WebSocketManager.instance:send(id, msg)

end

function CmdGateOut:bulletHitFish(bulletId, fishUid)
    local proto = CS_BulletHit:New()
    local hitInfo = C_BulletHitInfo:New()
    hitInfo.b = bulletId

    table.insert(hitInfo.f, fishUid)
    table.insert(proto.hit, hitInfo)

    WebSocketManager.instance:SendObject(proto)
end

function CmdGateOut:bulletHitFishs(bulletId, fishUids, exclueFishUids, dType)
    NetSender.BeHit( { hit = { { b = bulletId, f = fishUids } }, rf = { uids = exclueFishUids, type = dType } })
end

function CmdGateOut:killFishs(killType, fishIds)
    local c2s = C2s_12122.create()
    c2s:init(fishIds, killType)
    c2s:sendMsg()
end

---@param fish Fish2D
function CmdGateOut:useBoom(skillId, fish)
    ---@type C2S_17001
    local msg = {}
    local seat = SeatRouter.instance.mySeat
    FightTools.TEMP_POINT1.x = fish.fishWrapper.x
    FightTools.TEMP_POINT1.y = fish.fishWrapper.y

    GameScreen.instance:adaptToDesign(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1)
    MirrorMapper.map2DPoint(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1, seat.mirrorFlag)
    msg.id = skillId
    msg.uid = fish.uniId
    msg.x = FightTools.TEMP_POINT1.x
    msg.y = FightTools.TEMP_POINT1.y
    msg.index = seat.seatId
    NetSender.UseSkill(msg)
end

---@type C2S_12027_ShootBullet
local proto = {}
---@param shootContext ShootContext
function CmdGateOut:sendShootProtocol(shootContext)
    GameScreen.instance:adaptToDesign(shootContext.adaptStartPoint, FightTools.TEMP_POINT1)
    proto.startX = FightTools.TEMP_POINT1.x / GameScreen.instance.designRatio
    proto.startY = FightTools.TEMP_POINT1.y / GameScreen.instance.designRatio

    GameScreen.instance:adaptToDesign(shootContext.adaptEndPoint, FightTools.TEMP_POINT1)
    proto.endX = FightTools.TEMP_POINT1.x / GameScreen.instance.designRatio
    proto.endY = FightTools.TEMP_POINT1.y / GameScreen.instance.designRatio
    proto.sk = shootContext.skinId
    proto.bt = shootContext.battery
    proto.sr = 1
    proto.index = shootContext.seatId

    --TODO 锁定逻辑
    proto.fuid = shootContext.fuid
    --proto.lock = 0
    --if proto.fuid > 0 then
    --    proto.lock = 1
    --end
    proto.uid = shootContext.uid
    proto.m = shootContext.isMain
    proto.tick = 0
    NetSender.Shoot( proto)
end

function CmdGateOut:useSkill(skillId, rp)
    ---@type C2S_17001
    local msg = {}
    msg.id = skillId
    msg.rp = rp or 0
    NetSender.UseSkill(msg)
end