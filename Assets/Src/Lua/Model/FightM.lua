---@class FightM
---@field public instance FightM
FightM = class("FightM")
function FightM:ctor()
    self.seatId = 0
    self.sceneId = 0
    self._lockUid = 0
    self._seatOneInfo = nil
    self._seatTwoInfo = nil
    self._seatThreeInfo = nil
    self._seatFourInfo = nil
    self._skillList = {}
    self._agentGetArray = nil
    self._goldPoolTotalValue = nil
    self.contestEndTime = nil
    self._tipSwich = true
    self._seatOneInfo = nil
    self._seatTwoInfo = nil
    self._seatThreeInfo = nil
    self._seatFourInfo = nil
    self._goldPoolTotalValue = 0
    self._agentGetArray = {}

end
function FightM:dataReset()
    self._seatOneInfo = nil
    self._seatTwoInfo = nil
    self._seatThreeInfo = nil
    self._seatFourInfo = nil
    self.seatId = 0
    self.sceneId = 0
    self.contestEndTime = 0

end
function FightM:setContestEndTime(time)
    self.contestEndTime = time

end
function FightM:getContestEndTime()
    return self.contestEndTime

end
function FightM:contestEndTimeSub()
    if self.contestEndTime > 0 then
        self.contestEndTime = self.contestEndTime - 1
        if self.contestEndTime < 0 then
            self.contestEndTime = 0

        end

    end

end
function FightM:isMatchingGame()
    if Fishery.instance.sceneId == 7 then
        return true
    end
    return false

end
function FightM:coinShootScene()
    return Fishery.instance.isCoinScene
end

function FightM:isShowRankAni()
    if self.sceneId > 1 and self.sceneId <= 4 then
        return true
    end
    return false
end

function FightM:setGoldPoolTotalValue(value)
    self._goldPoolTotalValue = value

end
function FightM:getGoldPoolTotalValue()
    return math.floor(self._goldPoolTotalValue)

end
function FightM:goldPoolTotalValueAdd(value)
    self._goldPoolTotalValue = self._goldPoolTotalValue + value

end
function FightM:getOwnAgent()
    local ret = -1
    local seatInfo = SeatRouter.instance.mySeat.seatInfo
    if seatInfo then
        return seatInfo.agent

    end
    return ret
end

function FightM:isOwnBestBulletOwner(agent)
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(agent)
    if seatInfo and agent >= 0 then
        return seatInfo.seat_id == self.seatId

    end
    if self._seatOneInfo then
        return self._seatOneInfo.seat_id == self.seatId

    end
    if self._seatTwoInfo then
        return self._seatTwoInfo.seat_id == self.seatId

    end
    if self._seatThreeInfo then
        return self._seatThreeInfo.seat_id == self.seatId

    end
    if self._seatFourInfo then
        return self._seatFourInfo.seat_id == self.seatId

    end
    return false

end
function FightM:seatAddContestCoinByAgent(agent, addCoin)
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(agent)
    if seatInfo then
        seatInfo.contestCoin = seatInfo.contestCoin + addCoin
        if seatInfo.seat_id == self.seatId then
            GameEventDispatch.instance:event("PlayerCoinChange", {})
        end
    end
end

function FightM:isShowScene()
    if self.sceneId == 4 then
        return true
    else
        return false;
    end
end

function FightM:isGoldPoolScene()
    if self.sceneId > 0 then
        local playId = ConfigManager.getConfValue("cfg_scene", self.sceneId, "play_id")
        return playId == 4

    end
    return false

end
function FightM:getSkillId(skillIndex)
    if FightM.instance.sceneId > 0 then
        local skills = ConfigManager.getConfValue("cfg_scene", FightM.instance.sceneId, "skills")
        if skills then
            return skills[skillIndex]
        end
    end
    return 0

end
function FightM:getSkillCdLeftTime(skillId)
    for i, v in pairs(self._skillList) do
        if v.id == skillId then
            return v.cd
        end
    end
    return 0

end
function FightM:updateSkillCdLeftTime(skillData)
    if self._skillList then
        for i, v in pairs(self._skillList) do
            if v.id == skillData.id then
                v.cd = skillData.cd
                break
            end
        end
    end

    table.insert(self._skillList, skillData)
end

function FightM:resetSkillCd()
    for i, v in ipairs(self._skillList) do
        v.cd = 0
    end
end

function FightM:updateSkill(delta)
    if #self._skillList <= 0 then
        return
    end
    for i, v in ipairs(self._skillList) do
        if v.cd > 0 then
            v.cd = v.cd - delta
        end
    end
end

function FightM:getShootInterval()
    local seatInfo = SeatRouter.instance.mySeat.seatInfo
    local ret = ConfigManager.getConfValue("cfg_battery_skin", RoleInfoM.instance:getCurSkin(), "shootInterval")
    if seatInfo then
        if seatInfo.lvet > 0 then
            local firing_rate = ConfigManager.getConfValue("cfg_skill", seatInfo.vsid, "firing_rate")
            ret = ret / firing_rate

        end

    end
    return ret

end
function FightM:isOwnLock()
    if self.seatId == 1 then
        if self._seatOneInfo then
            return self._seatOneInfo.lock_et > 0

        end


    else
        if self.seatId == 2 then
            if self._seatTwoInfo then
                return self._seatTwoInfo.lock_et > 0

            end


        else
            if self.seatId == 3 then
                if self._seatThreeInfo then
                    return self._seatThreeInfo.lock_et > 0

                end


            else
                if self.seatId == 4 then
                    if self._seatFourInfo then
                        return self._seatFourInfo.lock_et > 0

                    end

                end
            end
        end
    end
    return false

end
function FightM:updateLock(delta)
    if self._seatOneInfo then
        if self._seatOneInfo.lock_et > 0 then
            self._seatOneInfo.lock_et = self._seatOneInfo.lock_et - delta
            if self._seatOneInfo.lock_et <= 0 and SeatRouter.instance.mySeatId == 1 then
                GameEventDispatch.instance:event("stopLock")

            end

        end

    end
    if self._seatTwoInfo then
        if self._seatTwoInfo.lock_et > 0 then
            self._seatTwoInfo.lock_et = self._seatTwoInfo.lock_et - delta
            if self._seatTwoInfo.lock_et <= 0 and SeatRouter.instance.mySeatId == 2 then
                GameEventDispatch.instance:event("stopLock")

            end

        end

    end
    if self._seatThreeInfo then
        if self._seatThreeInfo.lock_et > 0 then
            self._seatThreeInfo.lock_et = self._seatThreeInfo.lock_et - delta
            if self._seatThreeInfo.lock_et <= 0 and SeatRouter.instance.mySeatId == 3 then
                GameEventDispatch.instance:event("stopLock")

            end

        end

    end
    if self._seatFourInfo then
        if self._seatFourInfo.lock_et > 0 then
            self._seatFourInfo.lock_et = self._seatFourInfo.lock_et - delta
            if self._seatFourInfo.lock_et <= 0 and SeatRouter.instance.mySeatId == 4 then
                GameEventDispatch.instance:event("stopLock")

            end

        end

    end

end
function FightM:update(delta)
    local seat = SeatRouter.instance.mySeat
    seat:updateSkill(delta)
    self:updateLock(delta)

end
function FightM:addAgentGetInfo(info)
    table.insert(self._agentGetArray, info)
end
function FightM:getGoodsUnreachNum(agent, goodsId)
    local ret = 0
    local info
    for i, value in pairs(self._agentGetArray) do
        info = self._agentGetArray[i]
        if info.ag == agent and info.t == goodsId then
            ret = nil --[TODO]+= info.v

        end
    end
    return ret
end
function FightM:agentGetInfoUpdate(delta)
    local info
    local removeArray = {}
    local coinUpdate = false
    local goodsUpdate = false
    for i, value in pairs(self._agentGetArray) do
        info = self._agentGetArray[i]
        info.leftTime = info.leftTime - delta
        if info.leftTime <= 0 then
            if info.t == 1 then
                coinUpdate = true
                SeatRouter.instance:seatAddCoinByAgent(info.ag, info.v)


            else
                if info.t == 201 then
                    goodsUpdate = true
                    SeatRouter.instance:seatAddContestScoreByAgent(info.ag, info.v)


                else
                    goodsUpdate = true

                end
            end
            table.insert(removeArray, info)

        end

    end
    for j, value in pairs(removeArray) do
        local removeInfo = removeArray[j]
        for k, value in pairs(self._agentGetArray) do
            if self._agentGetArray[k] == removeInfo then
                table.remove(self._agentGetArray, k)
                break

            end

        end

    end
    if coinUpdate then
        GameEventDispatch.instance:event(GameEvent.FightCoinUpdate, {})

    end
    if goodsUpdate then
        GameEventDispatch.instance:event("UpdateProfile", {})
        GameEventDispatch.instance:event("GoodsUpdate", {})

    end

end
function FightM:getCoinRate()
    local cfg = cfg_scene.instance(FightM.instance.sceneId)
    if cfg.doubleRate[1] == 1 then
        return RoleInfoM.instance.coin_rate
    else
        return 1
    end
end

function FightM:getChangeRate()
    local cfg = cfg_scene.instance(FightM.instance.sceneId)
    if cfg.doubleRate[2] == 1 then
        return RoleInfoM.instance.chance_rate
    else
        return 1

    end

end

---@public
---@return void
function FightM.setBattery(cskin, battery, seatId)
    ---@type BatteryContext
    local batteryC = BatteryContext.new()
    local _batterySkinCfg = cfg_battery_skin.instance(cskin)

    if _batterySkinCfg ~= nil then
        batteryC:skinId(_batterySkinCfg.id)

        batteryC:shootInterval(_batterySkinCfg.shootInterval)
        batteryC:aniName(_batterySkinCfg.ani)
        batteryC:catchCount(_batterySkinCfg.catch_count)
        batteryC:multi(_batterySkinCfg.multi)
        batteryC:speed(_batterySkinCfg.speed)
        batteryC:netEffectName(_batterySkinCfg.web)

        local _batteryCfg = cfg_battery.instance(battery)
        batteryC:batteryId(_batteryCfg.id)
        batteryC:consume(_batteryCfg.comsume)

        Fishery.instance:setBatteryById(seatId, batteryC)
    end


end
function FightM:checkCanShoot(seat, isContinueShoot)
    if self:isMoneyEnough(seat, isContinueShoot) then
        return true
    else
        return false
    end
end
function FightM:isMoneyEnough(seat, isContinuous)
    local totalCoin = RoleInfoM.instance:getCoin() + RoleInfoM.instance:getBindCoin()
    local comsume = seat:getConsume()
    if Fishery.instance.isMatchScene then
        totalCoin = SeatRouter.instance.mySeat.contest_coin
    end

    local shootNowSeatId = seat.seatId
    local mySeatId = SeatRouter.instance.mySeatId
    if totalCoin < comsume and mySeatId == shootNowSeatId then
        self:noMoneyShoot(seat, isContinuous)
        return false
    end
    if seat.myCoinCount <=0 then
        return false
    end
    return true

end

function FightM:noMoneyShoot(seat, isContinuous)
    if Fishery.instance.isCoinScene then
        GameTip.showTipById(3)
        GameEventDispatch.instance:event(GameEvent.Shop, GameConst.shop_tab_coin)

        local seat = SeatRouter.instance.mySeat
        if seat then
            seat:closeAuto()
        end

        --if isContinuous then
        --    if self._tipSwich then
        --        self._tipSwich = false
        --        Laya.timer:clearAll(self)
        --        GameTip.showTip(cfg_tip.instance(3).txtContent)
        --        GameEventDispatch.instance:event("Shop", "coin")
        --        Laya.timer:once(10000, self, function()
        --            self._tipSwich = true
        --        end)
        --
        --    end
        --else
        --    GameTip.showTip(cfg_tip.instance(3).txtContent)
        --    GameEventDispatch.instance:event("Shop", "coin")
        --end
    end

end

function FightM:updateIsCanShoot(isContinueShoot)
    --if SeatRouter.instance.mySeat then
    --SeatRouter.instance.mySeat.isOutsidesCanShoot = FightM.instance:checkCanShoot(SeatRouter.instance.mySeat, isContinueShoot)
    --
    --end

end
