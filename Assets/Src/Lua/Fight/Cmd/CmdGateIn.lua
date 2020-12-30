---@class CmdGateIn
---@field public instance CmdGateIn
CmdGateIn = class("CmdGateIn")
function CmdGateIn:ctor()
    ---@type ProtoCatchFish
    self._catchInfoParser = ProtoCatchFish.new()
    ---@type BulletInfoParser
    self._bulletInfoParser = BulletInfoParser.new()
    ---@type ProtoCatchFish
    self._protoCatchFish = ProtoCatchFish.new()
    ---@type ProtoFishInfo
    self._fishDataParser = ProtoFishInfo.new()

    self.bossData = {}

    GameEventDispatch.instance:on(tostring(12017), self, self.onlineDataSync)
    GameEventDispatch.instance:on(tostring(12016), self, self.newBullet)

    --GameEventDispatch.instance:on(tostring(12048), self, self.onSyncAutoTime)
    GameEventDispatch.instance:on(tostring(12023), self, self.fishForm)
    GameEventDispatch.instance:on(tostring(12027), self, self.onBatteryChange)
    GameEventDispatch.instance:on(tostring(12013), self, self.roomPlayerGetIn_12013)
    GameEventDispatch.instance:on(tostring(12022), self, self.roomPlayerSyncOtherPlayer_12022)
    GameEventDispatch.instance:on(tostring(12021), self, self.roomPLayerGetOut_12021)
    GameEventDispatch.instance:on(tostring(12018), self, self.roomStopFight_12018)
    GameEventDispatch.instance:on(tostring(12015), self, self.shootBulletRet_12015)

    GameEventDispatch.instance:on(tostring(12030), self, self.syncViolent)
    --GameEventDispatch.instance:on(tostring(10008), self, self.syncCoin_10008)


    GameEventDispatch.instance:on(tostring(12059), self, self.syncSkipCoin)
    GameEventDispatch.instance:on(tostring(12060), self, self.changeScene)
    GameEventDispatch.instance:on(tostring(12061), self, self.changeSceneStage)
    GameEventDispatch.instance:on(tostring(12019), self, self.syncPlayerCoin)
    GameEventDispatch.instance:on(tostring(12049), self, self.fightEatCoinRet)
    --GameEventDispatch.instance:on(tostring(12034), self, self.syncLevel)
    GameEventDispatch.instance:on(tostring(12026), self, self.roomGetIn)


    --技能
    GameEventDispatch.instance:on(tostring(17003), self, self.syncSkillInfo_17003)
    GameEventDispatch.instance:on(tostring(17002), self, self.useSkillRet)
    GameEventDispatch.instance:on(tostring(12041), self, self.useSkill)
    GameEventDispatch.instance:on(tostring(12028), self, self.freezeSkill)
    GameEventDispatch.instance:on(tostring(12033), self, self.lockSkill)
    GameEventDispatch.instance:on(tostring(12029), self, self.useBoom)


    --网络相关
    GameEventDispatch.instance:on(tostring(10000), self, self.handshake);
    GameEventDispatch.instance:on(tostring(11002), self, self.heartbeat);
    GameEventDispatch.instance:on(tostring(10010), self, self.accountReplace);
    GameEventDispatch.instance:on(tostring(10014), self, self.server_error);
    GameEventDispatch.instance:on(tostring(10016), self, self.user_check_error);
    GameEventDispatch.instance:on(tostring(10017), self, self.network_error);
    GameEventDispatch.instance:on(tostring(10018), self, self.kicked);
    GameEventDispatch.instance:on(tostring(12121), self, self.onSerialFryingMsgRet);
    GameEventDispatch.instance:on(tostring(12131), self, self.onBossAwakeRet);
    GameEventDispatch.instance:on(tostring(12132), self, self.onBossAwakeEndRet);
    GameEventDispatch.instance:on(tostring(12040), self, self.onComebackGetTick);

    --比赛场
    --GameEventDispatch.instance:on(tostring(12052),self,self.end_daily_sign)
    --GameEventDispatch.instance:on(tostring(12053),self,self.end_snatch_sign)
    --GameEventDispatch.instance:on(tostring(35000),self,self.daily_match_settle)
    --GameEventDispatch.instance:on(tostring(35001),self,self.challenge_match_settle)
    --GameEventDispatch.instance:on(tostring(35004),self,self.end_accept_match_reward)
    --GameEventDispatch.instance:on(tostring(35006),self,self.end_accept_daily_match_reward)
    --GameEventDispatch.instance:on(tostring(12100),self,self.synRoomHostMsg)
    --GameEventDispatch.instance:on(tostring(12102),self,self.synRoomPrepareState)
    --GameEventDispatch.instance:on(tostring(12103),self,self.synRoomTManMsg)
    --GameEventDispatch.instance:on(tostring(12105),self,self.synMatchGameStart)
    --GameEventDispatch.instance:on(tostring(12108),self,self.synMatchGameRoomNum)
    --GameEventDispatch.instance:on(tostring(12109),self,self.synMatchGameResultMsg)
    --GameEventDispatch.instance:on(tostring(12113),self,self.synMatchGameAgainMsg)
    --GameEventDispatch.instance:on(tostring(12107),self,self.synMatchGamePalyerTMsg)
    --GameEventDispatch.instance:on(tostring(12111),self,self.findMatchGameDataFromRoomNum)
end
function CmdGateIn:syncLevel(data)
    SeatRouter.instance:setLevel(data.seat_id, data.level)
    GameEventDispatch.instance:event("FightPlayerUpdate")

end

function CmdGateIn:onSerialFryingMsgRet(data)
    SerialFryingC.instance:onMsgRet(data)
end

function CmdGateIn:onBossAwakeRet(data)
    local cfgFish = cfg_fish.instance(data.fishId)
    table.insert(self.bossData, { uid = data.uid, award = data.award })
    local num = 0
    if data.stage < data.end_stage then
        for _, v in ipairs(self.bossData) do
            if data.uid == v.uid then
                num = num + v.award
            end
        end
    end

    local lastNum = num - data.award or 0
    data.award = num

    if cfgFish.ctype == FightConst.fish_catch_type_ankangyu_awake then
        AnKangYuAwakeC.instance:onMsgRet(data, lastNum)
    elseif cfgFish.ctype == FightConst.fish_catch_type_eyu_awake then
        EYuAwakeC.instance:onMsgRet(data, lastNum)
    elseif cfgFish.ctype == FightConst.fish_catch_type_leishenchui_awake then
        HammerAwakeC.instance:onMsgRet(data, lastNum)
    elseif cfgFish.ctype == FightConst.fish_catch_type_boss_awake then
        ZhangYuAwakeC.instance:onMsgRet(data, lastNum)
    elseif cfgFish.ctype == FightConst.fish_catch_type_dragon_awake then
        DragonAwakeC.instance:onMsgRet(data, lastNum)
    end
end

function CmdGateIn:onBossAwakeEndRet(data)
    local cfgFish = cfg_fish.instance(data.fishId)
    for i = #self.bossData, 1, -1 do
        if data.uid == self.bossData[i].uid then
            table.remove(self.bossData, i)
        end
    end

    if cfgFish.ctype == FightConst.fish_catch_type_ankangyu_awake then
        AnKangYuAwakeC.instance:onMsgEndRet(data)
    elseif cfgFish.ctype == FightConst.fish_catch_type_eyu_awake then
        EYuAwakeC.instance:onMsgEndRet(data)
    elseif cfgFish.ctype == FightConst.fish_catch_type_leishenchui_awake then
        HammerAwakeC.instance:onMsgEndRet(data)
    elseif cfgFish.ctype == FightConst.fish_catch_type_boss_awake then
        ZhangYuAwakeC.instance:onMsgEndRet(data)
    elseif cfgFish.ctype == FightConst.fish_catch_type_dragon_awake then
        DragonAwakeC.instance:onMsgEndRet(data)
    end
end

function CmdGateIn:onComebackGetTick(data)
    local tick = data.tick
    local stageArgs = data.stageArgs
    for i, v in ipairs(stageArgs) do
        local cfgFish = cfg_fish.instance(v.fishId)
        if cfgFish.ctype == FightConst.fish_catch_type_ankangyu_awake then
            AnKangYuAwakeC.instance:getComeBackData(v.stage)
        end
        if cfgFish.ctype == FightConst.fish_catch_type_eyu_awake then
            EYuAwakeC.instance:getComeBackData(v.stage)
        end
        if cfgFish.ctype == FightConst.fish_catch_type_leishenchui_awake then
            HammerAwakeC.instance:getComebackTick(tick)
        end
        if cfgFish.ctype == FightConst.fish_catch_type_boss_awake then
            ZhangYuAwakeC.instance:getComeBackData(v)
        end
        if cfgFish.ctype == FightConst.fish_catch_type_dragon_awake then
            DragonAwakeC.instance:getComebackTick(tick)
        end
    end
end

---@param protoData ProtoFightEatCoinRet
function CmdGateIn:syncPlayerCoin(protoData)
    local seat = SeatRouter.instance:getSeatById(protoData.seat_id)
    seat:addCoin(protoData.coin, true)


    --SeatRouter.instance:seatAddCoin(protoData.seat_id, protoData.agent, protoData.coin)

    --TODO
    GameEventDispatch.instance:event(GameEvent.FightCoinUpdate)
end

function CmdGateIn:findFishInAwards(unid, awards)
    local len = 0
    if awards then
        len = #awards
    end
    local catchInfo = self._protoCatchFish
    local ret = nil
    for j = 1, len, 1 do
        catchInfo.p = awards[j];
        if (catchInfo and catchInfo:getFishUid() == unid) then
            ret = awards[j]
            break
        end
    end
    return ret
end

function CmdGateIn:syncDataCompleted(fishArray, awards)
    for _, value in pairs(fishArray) do
        self._fishDataParser.p = value
        local fishUid = self._fishDataParser:getUniId()
        local fish = Fishery.instance:findFishByUniId(fishUid)
        if fish then
            fish.isCatch = self._fishDataParser:isCatch()
            local awardInfo = self:findFishInAwards(fishUid, awards)
            local hasAward = false
            if awardInfo then
                hasAward = true

                local catchInfo = self._protoCatchFish
                catchInfo.p = awardInfo;
                local agentId =  catchInfo:getAgent()
                fish:agentId(agentId)
            end

            if fish.isCatch and self._fishDataParser:getCatchType() == FightConst.fish_death_type_laser_cannon then
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_laser_cannon, hasAward)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and self._fishDataParser:getCatchType() == FightConst.fish_death_type_whirlwind_cannon then
                --旋风鱼击杀
                fish.fsm:changeState(StateFishWind)
            elseif fish.isCatch and  self._fishDataParser:getCatchType() == FightConst.fish_death_type_boss_awake then
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_boss_awake, hasAward)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and FightConst.fish_death_type_boom_fish_boom == self._fishDataParser:getCatchType() then
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_boom_fish_boom, hasAward)
                -- Fishery.instance:syncSerialFryingKillFish(fish, self._fishDataParser,FightConst.fish_death_type_boom_fish_boom)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and FightConst.fish_death_type_drill_cannon_boom == self._fishDataParser:getCatchType() then
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_drill_cannon_boom, hasAward)
                -- Fishery.instance:syncZuantoupaoKillFish(fish, self._fishDataParser,FightConst.fish_death_type_drill_cannon_boom)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and FightConst.fish_death_type_eyu_awake == self._fishDataParser:getCatchType() then
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_eyu_awake, hasAward)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and FightConst.fish_death_type_anakangyu_awake == self._fishDataParser:getCatchType() then
                local seatInfo = SeatRouter.instance:getSeatInfoByAgent(self._fishDataParser:getAgent())
                local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
                local pos = fish:screenPoint()
                --seat:initFishBoom(pos.x, pos.y, pos.z)
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_anakangyu_awake, hasAward)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and FightConst.fish_death_type_leishenchui_awake == self._fishDataParser:getCatchType() then
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_leishenchui_awake, hasAward)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and FightConst.fish_death_type_dragon_awake == self._fishDataParser:getCatchType() then
                Fishery.instance:syncKillFish(fish, self._fishDataParser,FightConst.fish_death_type_dragon_awake, hasAward)
                fish.fsm:changeState(StateFishDead)
            elseif fish.isCatch and FightConst.fish_catch_type_boom == fish.fishCfg.ctype then
                if not hasAward then
                    return
                end
                local ownAgentId = FightM.instance:getOwnAgent()
                local catchInfo = self._protoCatchFish
                catchInfo.p = awardInfo;
                local agentId =  catchInfo:getAgent()
                if agentId == ownAgentId then
                    local endX = FightContext.instance.designWidth / 2
                    local endY = FightContext.instance.designHeight / 2
                    local tawards = catchInfo:getAward()
                    local point = 0
                    for _, award in ipairs(tawards) do
                        if FightConst.currency_coin == award[1] then
                            point = award[2]
                        end
                    end
                    local vec3 = fish:screenPoint()
                    SerialFryingC.instance:sendMsg(vec3.x, vec3.y, endX, endY, point)
                end
    end
        end
    end
end

function CmdGateIn:syncFishData(fishArray)
    local freezeStartTick = 0
    for _, value in pairs(fishArray) do
        self._fishDataParser.p = value
        local fish = Fishery.instance:findFishByUniId(self._fishDataParser:getUniId())

        if fish then
            fish.isCatch = self._fishDataParser:isCatch()
        else
            fish = FishFactory.create2DFish(self._fishDataParser)
            if not fish then
                return
            end
            if fish.isBoss then
                --UIFishPage.instance:initBossComingAni(fish.fishCfg.weight[1])
            end
            --if Fishery.instance.fishNum == 0 then
            if self._fishDataParser:isWhirlwind() then
                fish:showWhirlwindFlag()
            end

            Fishery.instance:addFish(fish)
            --end
        end

        --if fContext:isSpecFish() then
        --    local specFishC = self:createSpecFContext(fContext, self._fishDataParser)
        --end
        --fContext.specFishsContext = specFishC




        if freezeStartTick <= 0 then
            freezeStartTick = self._fishDataParser:getFreezeStartTick()
        end

    end
    -- 同步完鱼， 刷新作锁定炮台图标
    SeatRouter.instance:updateSeatInfo()
    FisheryTick.instance:syncFreeze(freezeStartTick)

end
function CmdGateIn:createSpecFContext(fContext, _fishDataParser)
    local arr = _fishDataParser:getFollowFishes()
    local offsets = null
    local specFishC = {}
    local tmp = nil--[TODO] new Point()
    for l, value in arr do
        local _fishContext = self:createFishContext(arr[l], _fishDataParser)
        _fishContext.fishSpecType = FishHelper:getFishLessSpecTypeByCType(fContext.ctype)
        offsets = FishHelper:getOffset(_fishContext.fishSpecType, l)
        if offsets then
            Screen.instance:adaptToDesign(offsets, tmp)
            _fishContext.offVec.x = _fishContext.offVec.x + tmp.x
            _fishContext.offVec.y = _fishContext.offVec.y + tmp.y
            _fishContext.offVec.z = _fishContext.offVec.z

        end
        specFishC:push(_fishContext)

    end
    return specFishC

end
---@param _fishDataParser ProtoFishInfo
function CmdGateIn:createFishContext(fishId, _fishDataParser)
    local cfg = cfg_fish.instance(tonumber(_fishDataParser:getFishId()))
    local cfgPath = cfg_fishgrouppath.instance(tonumber(_fishDataParser:getPath()[1]))

    local _fishContext = FishContext2D.New()
    _fishContext:init(cfg.id, cfg.aniName, cfg.scale_down, cfg.boom, cfg.hit_time, cfg.lock_pri, cfg.ctype,
            cfg.catch_show, cfg.ani_name, cfg.shock, cfg.action_name, cfg.playCatchSound, cfg.coin_fly,
            cfg.layer, cfg.hitSound, cfg.change_num, cfg.spec_flag, cfg.dead_ani, cfgPath.id,
            _fishDataParser:getUniId(), Vector3.New(_fishDataParser:getOffX(), _fishDataParser:getOffY(), _fishDataParser:getOffZ()),
            _fishDataParser:getMirror())
    _fishContext.startTick = _fishDataParser:getStartTick()
    _fishContext.freezeStartTick = _fishDataParser:getFreezeStartTick()
    _fishContext.extraTick = _fishDataParser:getExtraTick()
    _fishContext.delayDieTick = _fishDataParser:getDelayDie()
    _fishContext.specFlag = cfg.specFlag
    return _fishContext
end

function CmdGateIn:changeScene(proto)
    Fishery.instance.sceneStage = GameConst.boss_stage_small
    UIFishPage.instance:playChangeScene(proto.to_scene)
end
function CmdGateIn:changeSceneStage(proto)
    Fishery.instance.sceneStage = proto
    UIFishPage.instance:changeSceneStage(proto.stage,true)
end




