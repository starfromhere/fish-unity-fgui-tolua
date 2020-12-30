---@param data S2C_12026
function CmdGateIn:roomGetIn(data)
    local protoData = data
    if protoData then
        if protoData.scene_id == 9 then
            Fishery.instance.isMergeScene = true
            Fishery.instance:init(protoData.seat_id, protoData.cur_scene_id)
        else
            Fishery.instance.isMergeScene = false
            Fishery.instance:init(protoData.seat_id, protoData.scene_id)
        end

        Fishery.instance.sceneStage = protoData.stage
        FightM.instance.seatId = Fishery.instance.seatId
        FightM.instance.sceneId = Fishery.instance.sceneId
        
        local mySeat = SeatRouter.instance.mySeat
        if Fishery.instance.isMatchScene then
            mySeat.contest_coin = protoData.ccoin
            mySeat.contest_score = protoData.cscore
            Fishery.instance.contestEndTime = protoData.end_time
        end

        UIManager:ClosePanel("MainPage")
        if UIManager:UIInCache("MatchPage") then
            UIManager:ClosePanel("MatchPage")
        end

        if Game.instance.fsm:isNotInStates({ StateGameFish }) then
            Game.instance:loading(ResourceManifest.instance:getSceneRes(protoData.scene_id), StateGameFish)
        end
    end
end

---@param data S2C_12021
function CmdGateIn:roomPLayerGetOut_12021(data)
    local seat = SeatRouter.instance:getSeatById(data.seat_id)
    seat.fsm:changeState(StateSeatExit)
end

function CmdGateIn:roomPlayerSyncOtherPlayer_12022(data)
    local arr = data["players"]
    local bUid = data["buid"]
    if arr then
        for i, seatInfo in pairs(arr) do
            Log.debug("CmdGateIn:roomPlayerSyncOtherPlayer_12022", seatInfo.seat_id)
            local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
            seat:initSeatInfo(seatInfo)
            FightM.instance.setBattery(seatInfo.cskin, seatInfo.battery, seatInfo.seat_id)
            --SeatRouter.instance:inSeatInfo(seatInfo.seat_id, seatInfo)
        end
    end
    --Fishery.instance:setBulletUidInfo(bUid)
    --GameEventDispatch.instance:event("FightPlayerUpdate")
end

---@param seatInfo ProtoSeatInfo
function CmdGateIn:roomPlayerGetIn_12013(seatInfo)
    local seat_id = seatInfo.seat_id

    local seat = SeatRouter.instance:getSeatById(seat_id)
    seat:initSeatInfo(seatInfo)

    FightM.instance.setBattery(seatInfo.cskin, seatInfo.battery, seatInfo.seat_id)
    --SeatRouter.instance:inSeatInfo(seatInfo.seat_id, seatInfo)
    --GameEventDispatch.instance:event("FightPlayerUpdate")

end

function CmdGateIn:roomStopFight_12018()
    local preSceneId = Fishery.instance.sceneId

    Game.instance.fsm:changeState(StateGameMain, preSceneId)
end

function CmdGateIn:syncRes()

end

---@param protoData S2C_12015
function CmdGateIn:shootBulletRet_12015(protoData)
    local ret = protoData
    if ret.code == 0 then
        if not Fishery.instance.isCoinScene then
            RoleInfoM.instance:setContestCoin(ret.ccoin)
        else
            RoleInfoM.instance:setCoin(ret.coin)
            RoleInfoM.instance:setBindCoin(ret.bcoin)
        end
        GameEventDispatch.instance:event(GameEvent.UpdateProfile)
        --GameEventDispatch.instance:event(GameEvent.FightCoinUpdate)
    elseif 5 == ret.code then


    else
        if GameConst.shoot_bullet_fail_action_sub_allow == ret.ac then

        elseif GameConst.shoot_bullet_fail_action_open_shop == ret.ac then
            GameEventDispatch.instance:event(GameEvent.MsgTip, 3)
            GameEventDispatch.instance:event(GameEvent.Shop, GameConst.shop_tab_coin)
        end
        GameEventDispatch.instance:event(GameEvent.ShootError, {})
    end
end

function CmdGateIn:onlineDataSync(data)

    local syncInfo = data
    if syncInfo.maxTick then
        FisheryTick.instance:syncTick_12017(syncInfo)
    end
    if syncInfo.tick then
        FishLayer.instance:playBossZhangYuAni(syncInfo.tick)
    end

    if syncInfo.fish then
        self:syncFishData(syncInfo.fish)
    end
    if syncInfo.fish then
        self:syncDataCompleted(syncInfo.fish, syncInfo.cInfo)
    end
    if syncInfo.cInfo then
        for _, value in pairs(syncInfo.cInfo) do
            self._catchInfoParser.p = value
            --Fishery.instance:syncCacheAward(self._catchInfoParser.p)
            Fishery.instance:syncCacheInfo(self._catchInfoParser:getFishUid(),self._catchInfoParser.p, syncInfo.t)
        end
    end
    if syncInfo.specAward then
        Fishery.instance:syncSpecialAward(syncInfo.specAward)
    end

end

function CmdGateIn:newBullet(data)

    self._bulletInfoParser.p = data.p
    local seat = SeatRouter.instance:getSeatById(self._bulletInfoParser:getSeatId())

    if not seat:isMySeat() then
        local mySeat = SeatRouter.instance.mySeat
        local seat = SeatRouter.instance:getSeatById(self._bulletInfoParser:getSeatId())

        ---@type ShootContext
        local ctx = ShootContext.New()
        ctx.seatId = self._bulletInfoParser:getSeatId()
        ctx.adaptStartPoint.x = self._bulletInfoParser:getStartX() * GameScreen.instance.designRatio
        ctx.adaptStartPoint.y = self._bulletInfoParser:getStartY() * GameScreen.instance.designRatio
        ctx.adaptEndPoint.x = self._bulletInfoParser:getEndX() * GameScreen.instance.designRatio
        ctx.adaptEndPoint.y = self._bulletInfoParser:getEndY() * GameScreen.instance.designRatio
        FightTools.TEMP_POINT1.x = ctx.adaptEndPoint.x - ctx.adaptStartPoint.x
        FightTools.TEMP_POINT1.y = ctx.adaptEndPoint.y - ctx.adaptStartPoint.y
        local relativeMirrorFlag = MirrorMapper.getRelativeMirrorFlag(mySeat.mirrorFlag, seat.mirrorFlag)
        MirrorMapper.mapVec2(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1, relativeMirrorFlag)
        GameScreen.instance:designToAdapt(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1)
        ctx.adaptStartPoint.x = seat.shootStartX
        ctx.adaptStartPoint.y = seat.shootStartY
        ctx.adaptEndPoint.x = ctx.adaptStartPoint.x + FightTools.TEMP_POINT1.x * 100
        ctx.adaptEndPoint.y = ctx.adaptStartPoint.y + FightTools.TEMP_POINT1.y * 100

        ctx.skinId = self._bulletInfoParser:getSk()
        ctx.hitCount = self._bulletInfoParser:getHitCount()
        ctx.uid = self._bulletInfoParser:getUniId()
        ctx.isMain = self._bulletInfoParser:getM()
        ctx.agentId = self._bulletInfoParser:getAgent()
        ctx.fuid = self._bulletInfoParser:getFuid()
        if ctx.fuid and ctx.fuid > 0 then
            seat.lockFish = Fishery.instance:findFishByUniId(ctx.fuid)
            if seat.lockFish then
                seat.lockType = seat.lockFish.groupLock
                seat:checkLaserShoot()
            end
        end
        seat:shoot(ctx)
    end

    if Fishery.instance.isCoinScene then
        seat:addCoin(self._bulletInfoParser:getCoin(), true, true)
        --SeatRouter.instance:seatAddCoin(self._bulletInfoParser:getSeatId(), self._bulletInfoParser:getAgent(), self._bulletInfoParser:getCoin(), true)
    else
        --SeatRouter.instance:seatAddContestCoin(self._bulletInfoParser:getSeatId(), self._bulletInfoParser:getAgent(), self._bulletInfoParser:getCoin())
        seat:addContestCoin(self._bulletInfoParser:getCoin())
    end
    --GameEventDispatch.instance:event("FightCoinUpdate")

end

---@param protoData S2C_12023
function CmdGateIn:fishForm(protoData)
    Fishery.instance:playForm(protoData.d, protoData.t)
end

function CmdGateIn:onSyncAutoTime(data)
    SeatAuto.instance.autoTime = data.time

end

function CmdGateIn:syncSkipCoin(data)
    local seat = SeatRouter.instance.mySeat;
    if seat then
        seat:addCoin(data.coin, false)
    end
    --SeatRouter.instance:setSkipCoin(SeatRouter.instance.mySeatId, data.coin)
    --GameEventDispatch.instance:event("FightCoinUpdate", null)
end

function CmdGateIn:onBatteryChange(data)
    local protoData = data
    FightM.instance.setBattery(protoData.cskin, protoData.battery, protoData.seat_id)
    GameEventDispatch.instance:event(GameEvent.FightPlayerUpdate)
    --GameEventDispatch.instance:event(GameEvent.FinishChangeSkin)
end

---@param protoData ProtoFightPlayerCoint
function CmdGateIn:fightEatCoinRet(protoData)
    Log.debug("CmdGateIn:fightEatCoinRet", protoData.coin)

    local seat = SeatRouter.instance:getSeatById(protoData.seat_id)

    if Fishery.instance.isMatchScene then
        seat:addContestCoin(protoData.coin)
    else
        seat:addCoin(protoData.coin, true)
        --SeatRouter.instance:seatAddCoin(protoData.seat_id, protoData.agent, protoData.coin)
    end
    --GameEventDispatch.instance:event("FightCoinUpdate", info)
end
