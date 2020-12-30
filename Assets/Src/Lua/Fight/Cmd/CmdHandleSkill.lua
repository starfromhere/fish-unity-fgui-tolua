

---@param protoData S2C_12029
function CmdGateIn:useBoom(protoData)

    local seat = SeatRouter.instance:getSeatById(protoData.seat_id)
    local relativeMirrorFlag = MirrorMapper.getRelativeMirrorFlag(SeatRouter.instance.myMirrorFlag, seat.mirrorFlag)

    FightTools.TEMP_POINT1.x = protoData.x
    FightTools.TEMP_POINT1.y = protoData.y
    MirrorMapper.map2DPoint(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1, relativeMirrorFlag)
    GameScreen.instance:designToAdapt(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1)
    seat:onUseBoom(FightTools.TEMP_POINT1.x, FightTools.TEMP_POINT1.y, protoData.sid, protoData.uid, protoData.coin,protoData.seat_id,protoData.agent)

    

    --local boomContext = nil--[TODO] new BoomContext()
    --boomContext:init(protoData.uid, protoData.x, protoData.y, protoData.seat_id, protoData.sid, protoData.coin, protoData.agent)
    --Fishery.instance:useBoom(boomContext)

end


---@param protoData S2C_12033
function CmdGateIn:lockSkill(protoData)
    local seat = SeatRouter.instance:getSeatById(protoData.seat_id)
    if seat then
        seat.lockRemainTime = protoData.lock_et
        seat.lockFishUid = protoData.lock_uid
        seat.lockFishSid = protoData.lock_sid
        seat:changeToLock()
    end
end


---@param data S2C_12028
function CmdGateIn:freezeSkill(data)
    Fishery.instance:setFreeze(data.time)
end


---@param data S2C_17003 @同步自己的技能CD
function CmdGateIn:syncSkillInfo_17003(data)
    local mySeat = SeatRouter.instance.mySeat
    for _, info in pairs(data.info) do
        mySeat:updateSkillCdLeftTime(info)
    end
end

function CmdGateIn:useSkill(protoData)

end

---@param protoData S2C_17002 @释放技能回包
function CmdGateIn:useSkillRet(protoData)
    local skillCfg = cfg_skill.instance(protoData.id)
    local code = protoData.code
    if 0 == code then
        ---@type SkillInfo
        local skillInfo = {}
        skillInfo.id = protoData.id
        skillInfo.cd = skillCfg.cd

        --TODO
        --if skillCfg.skill_type == 2 then
        --    FightM.instance._lockUid = 0
        --end

        local seat = SeatRouter.instance.mySeat
        seat:updateSkillCdLeftTime(skillInfo)
    elseif 1 == protoData.code then
        GameEventDispatch.instance:event("MsgTp", 1)
    elseif 2 == protoData.code then

    elseif 10 == protoData.code then

    elseif 5 == protoData.code then
        if protoData.code == 5 then
            local tmpType = ConfigManager.getConfValue("cfg_skill", protoData.id, "skill_type")
            if tmpType == 5 then
                GameEventDispatch.instance:event("MsgTp", 2)

                --
                --else
                --    local info = QuitTipInfo.New()
                --    local diamondNum = SkillM.instance:skillDiamondCount(protoData.id)
                --    info.state = 1
                --    info.content = "道具不足，是否花费"..diamondNum.."钻石释放该技能"
                --    info.confirmCallback = Handler:create(self, CmdGateOut.instance.useSkill, { protoData.id, 1 })
                --    info.autoCloseTime = 10
                --    GameEventDispatch.instance:event("QuitTip", info)

            end

        end
    else
        GameEventDispatch.instance:event(GameEvent.Shop, GameConst.shop_tab_diamond)

    end
end

---@param protoData S2C_12030
function CmdGateIn:syncViolent(protoData)
    local seat = SeatRouter.instance:getSeatById(protoData.seat_id)
    seat:setViolentInfo(protoData.lvet, protoData.sid)
end


