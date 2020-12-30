---@class FightC
---@field public instance FightC
FightC = class("FightC")
function FightC:ctor()
    GameEventDispatch.instance:on(tostring(12002), self, self.roomGetInRet)
    --GameEventDispatch.instance:on(tostring(12052), self, self.roomGetInRet)
    --GameEventDispatch.instance:on(tostring(12015), self, self.multiShootBulletRet)
    GameEventDispatch.instance:on(tostring(12050), self, self.addAwardScore)
    GameEventDispatch.instance:on(tostring(13002), self, self.buyBattery)
    GameEventDispatch.instance:on(tostring(17003), self, self.syncSkills)
    GameEventDispatch.instance:on(tostring(17002), self, self.useSkillRet)
    GameEventDispatch.instance:on(tostring(12041), self, self.useSkill)
    --GameEventDispatch.instance:on(tostring(12046), self, self.dayComsumeTooMuch)
    GameEventDispatch.instance:on(tostring(12055), self, self.contestStart)
    --GameEventDispatch.instance:on(tostring(12056), self, self.exitNewPlayerScene)
    GameEventDispatch.instance:on(tostring(30000), self, self.getGoldPoolAward)
    GameEventDispatch.instance:on(tostring(30001), self, self.gold_pool_all_value_update)
    GameEventDispatch.instance:on(tostring(30004), self, self.syncGoldPoolAward)
    GameEventDispatch.instance:on(GameEvent.UseGoodsConfirmAndJumpToShop, self, self.useGoodsConfirmAndJumpToShop)

end
function FightC:startContestMatch(data)
    local tmpInfo = QuitTipInfo.New()
    tmpInfo.isHaveTime = true
    tmpInfo.autoCloseTime = 50
    tmpInfo.state = 1
    tmpInfo.content = "xxx"
    GameEventDispatch.instance:event("QuitTip", tmpInfo)

end
function FightC:exitNewPlayerScene()
    GameEventDispatch.instance:event("MsgTp", 70)

end
function FightC:contestStart(data)
    if Fishery.instance.sceneId == 7 then
        MatchM.instance.isMatchStart = 1
        MatchM.instance.tManSeat = -1
        FightM.instance:setContestEndTime(data.end_time)
        --GameEventDispatch.instance:event("MatchingGameSynState")
        Fishery.instance:startMatchGame()
    else
        FightM.instance:setContestEndTime(data.end_time)
        GameEventDispatch.instance:event(GameEvent.ContestFightStart, nil)

    end

end
function FightC:dayComsumeTooMuch(data)
    GameEventDispatch.instance:event("MsgTp", 32)
    GameEventDispatch.instance:event("ExitLoginView", null)

end
function FightC:syncGoldPoolAward(data)
    RoleInfoM.instance:setAwardValue(data.value)
    local goldPoolAwardMsg = {}
    goldPoolAwardMsg.value = RoleInfoM.instance:getAwardValue()
    NetSender.PoolReward(goldPoolAwardMsg)

end
function FightC:getGoldPoolAward(data)
    RoleInfoM.instance:setAwardScore(0)
    if data.value > 0 then
        GameEventDispatch.instance:event(GameEvent.GetGoldPoolAward, data)
    end

    GameEventDispatch.instance:event(GameEvent.UpdateProfile)

end
function FightC:gold_pool_all_value_update(data)
    FightM.instance:setGoldPoolTotalValue(data.value)
    GameEventDispatch.instance:event(GameEvent.UpdateGoldPoolInfo)
end

function FightC:useGoodsConfirmAndJumpToShop(data)
    NetSender.DiamondToGoods()
    GameEventDispatch.instance:event("QuitTip", data)

end
function FightC:onLoop()
    FightM.instance:agentGetInfoUpdate(Laya.timer.delta / 1000)

end
function FightC:syncSkills(data)
    local protoData = data
    for i = 1, #data.info do
        FightM.instance:updateSkillCdLeftTime(protoData.info[i])
    end

end
function FightC:useSkill(data)
    local musicPath = ConfigManager.getConfValue("cfg_skill", data.skill, "sound")
    local musicFilter = string.gsub(musicPath, "^%l", string.upper);
    if musicPath then
        SoundManager.PlayEffect(musicFilter)
    end

end
function FightC:useSkillRet(data)
    local protoData = data
    if 0 == protoData.code then
        local skillInfo = {}
        skillInfo.id = protoData.id
        skillInfo.cd = ConfigManager.getConfValue("cfg_skill", protoData.id, "cd")
        local skillType = ConfigManager.getConfValue("cfg_skill", protoData.id, "skill_type")
        if skillType == 2 then
            FightM.instance._lockUid = 0
        end
        FightM.instance:updateSkillCdLeftTime(skillInfo)
        GameEventDispatch.instance:Event(GameEvent.FightCoinUpdate)
    elseif 1 == protoData.code then
        GameEventDispatch.instance:event("MsgTp", 1)
    elseif 2 == protoData.code then

    elseif 10 == protoData.code then

    elseif 5 == protoData.code then
        local tmpType = ConfigManager.getConfValue("cfg_skill", protoData.id, "skill_type")
        if tmpType == 5 then
            GameEventDispatch.instance:event("MsgTp", 2)

        else
            local tmpInfo = ConfirmTipInfo.new();
            local diamondNum = SkillM.instance:skillDiamondCount(protoData.id);
            tmpInfo.content = "道具不足，是否花费" .. diamondNum .. "钻石释放该技能";
            tmpInfo.autoCloseTime = 10;
            tmpInfo.rightClick = function()
                GameEventDispatch.instance:event(GameEvent.UseGoodsConfirmAndJumpToShop, { protoData.id, 1 })
                if SkillM.instance:isConsumeEnough(protoData.id) then
                    CmdGateOut:useSkill(protoData.id, 1)
                else
                    local t = Timer.New(function()
                        Seat.TipToShop()
                    end, 0.1, 1)
                    t:Start()
                end

            end
            GameTip.showConfirmTip(tmpInfo)

        end

    else
        GameEventDispatch.instance:event(GameEvent.Shop, GameConst.shop_tab_diamond)

    end
end
function FightC:buyBattery(data)
    local protoData = data
    if 0 == protoData.code then
        RoleInfoM.instance:setBattery(protoData.battery)
        GameEventDispatch.instance:event("BatteryBuyRet", data)
        SoundManager.PlayEffect("Music/batteryup.mp3")
    else
        if 1 == protoData.code then
            GameEventDispatch.instance:event("Shop", "tab_diamond")
        end
    end
end

function FightC:addAwardScore(data)
    RoleInfoM.instance:setAwardScore(data.score)
    FightM.instance:goldPoolTotalValueAdd(data.prize)
    GameEventDispatch.instance:event("UpdateGoldPoolInfo")
    GameEventDispatch.instance:event("UpdateProfile")

end
--function FightC:multiShootBulletRet(data)
--    local ret = data
--    if ret.code == 0 then
--        if ~FightM.instance:coinShootScene() then
--            RoleInfoM.instance:setContestCoin(ret.ccoin)
--
--
--        else
--            RoleInfoM.instance:setCoin(ret.coin)
--            RoleInfoM.instance:setBindCoin(ret.bcoin)
--
--        end
--        GameEventDispatch.instance:event("UpdateProfile")
--        GameEventDispatch.instance:event("FightCoinUpdate")
--
--
--    else
--        if 5 == ret.code then
--
--
--        else
--            if 1 == ret.ac then
--
--
--            else
--                if 2 == ret.ac then
--                    GameEventDispatch.instance:event("MsgTp", 3)
--                    GameEventDispatch.instance:event("Shop", "tab_coin")
--
--                end
--            end
--            GameEventDispatch.instance:event("ShootError", null)
--
--        end
--    end
--
--end

function FightC:roomGetInRet(data)
    local getIn = data
    if getIn.code == 0 then
        LoadTipM.instance:getInRoomFailCount(0)
        UIManager:ClosePanel("MainPage")
        UIManager:ClosePanel("LoadPage",nil, false)
    else
        LoginM.instance.roomId = -1
        GameTip.showTipById(getIn.code + 52)

        LoadTipM.instance:getInRoomFailCount(LoadTipM.instance:getInRoomFailCount() + 1)
        UIManager:ClosePanel("LoadPage",nil, false)
    end
end

function FightC:seatConfigChange(data)
    local protoData = data
    GameEventDispatch.instance:event("FightPlayerUpdate", nil)
end

function FightC:changeSkin(seatId)
    local lstSkinId = RoleInfoM.instance:getLastSkinID()
    if SeatRouter.instance.mySeatId == seatId and lstSkinId > 0 then
        GameEventDispatch.instance:event(GameEvent.ChangeSkin, lstSkinId)
        -- 置掉上次保存的数据
        RoleInfoM.instance:setLastSkinID(-1)
    end
end