---@class Fishery
---@field public instance Fishery
Fishery = class("Fishery")

Fishery._minBulletUid = 0
Fishery._maxBulletUid = 1000
function Fishery:ctor()
    self.loopHandle = nil
    ---@type table<string,Fish2D>
    self.fishes = {}
    ---@type table<string,Bullet>
    self.bullets = {}
    -- 其它玩家的子弹
    self.otherBullets = {}
    self.curBulletUid = 0

    self.freezeTime = 0
    ---@type GImage
    self.freezeSprite = nil

    ---@type FSM
    self.fsm = FSM.New(self)

    self.fishNum = 0

    self.sceneId = nil
    self.sceneCfg = nil
    self.seatId = nil
    --是否是金币场
    self.isCoinScene = true
    self.isMatchScene = false

    self.multiGetCoinArrayX = { 0, -20, 20, -40, 40 }
    self.multiGetCoinArrayY = { 0, -20, 20, -40, 40 }

    -- 钻头炮上次表现的时间
    self.lstTestZuantoupaoTime = 0

    ---比赛场
    self.contestEndTime = 0

    self.fsmMatch = FSM.New()
    self.matchPlayerNum = 0
    self.matchPreparePlayerNum = 0
    self.matchHostSeatId = nil
    self.matchEndTime = 0

    self.matchPrepareBtn = nil
    self.matchStartBtn = nil
    ---@type GTextField
    self.matchWaitTimeText = nil
    ---@type GTextField
    self.matchWaitText = nil

    ---鳄鱼冰块
    self.EyuIce = nil
    ---当前打中的旋转鱼的位置
    self.XZFishNowType = 2

end

function Fishery:startMatch()
    if self.fsmMatch:isInState(MatchStateStart) then

    else
        self.fsmMatch:changeState(MatchStateWaitJoin)
    end
end

function Fishery:exitMatch()
    self.fsmMatch:changeState(MatchStateExit)
end

function Fishery:changeMatchPlayerNum(num)
    Log.debug("Fishery:changeMatchPlayerNum", num)
    self.matchPlayerNum = num
    if self.sceneId ~= 7 or self.fsmMatch:isInState(MatchStateStart) then
        return
    end
    if self.matchPlayerNum > 1 then
        self.fsmMatch:changeState(MatchStateWaitPrepare)
    else
        self.fsmMatch:changeState(MatchStateWaitJoin)
    end
end

function Fishery:changePrepareStatus(status)
    Log.debug("Fishery:changePrepareStatus", encode(status))
    local num = 0
    for index, status in ipairs(status) do
        local seat = SeatRouter.instance:getSeatById(index)
        if index == Fishery.instance.matchHostSeatId then
            seat.RoomHost.visible = true
            seat.NoReadyText.visible = false
            seat.AlreadyText.visible = false
        else
            seat.RoomHost.visible = false
            if status == 1 then
                num = num + 1
                seat.NoReadyText.visible = false
                seat.AlreadyText.visible = true
            else
                seat.NoReadyText.visible = true
                seat.AlreadyText.visible = false
            end
        end
    end
    self.matchPreparePlayerNum = num

    --if self.matchPlayerNum == 1  then
    --    self.fsmMatch:changeState(MatchStateWaitJoin)
    --elseif self.matchPlayerNum > 1 and self.matchPreparePlayerNum + 1 == self.matchPlayerNum then
    --    self.fsmMatch:changeState(MatchStateWaitStart)
    --else
    --    self.fsmMatch:changeState(MatchStateWaitPrepare)
    --end
end

function Fishery:startMatchGame()
    self.fsmMatch:changeState(MatchStateStart)
end

function Fishery:matchIsHost()
    return self.matchHostSeatId == SeatRouter.instance.mySeatId
end

function Fishery:waitPrepareMatchGame()
    self.fsmMatch:changeState(MatchStateWaitPrepare)
end

function Fishery:matchAllPrepare(seat_id, end_time)

    local seat = SeatRouter.instance:getSeatById(seat_id)

    self.matchEndTime = end_time
    if self.matchPreparePlayerNum == self.matchPlayerNum - 1 then
        if not UIManager:UIInCache("MatchSettlePage") then
            self.fsmMatch:changeState(MatchStateWaitStart)
        end
    else
        if not self.matchIsHost then
            self.fsmMatch:changeState(MatchStateWaitCountDown)
        end
    end

end

function Fishery:init(seatId, sceneId)
    self.seatId = seatId
    self.sceneId = sceneId
    self.sceneCfg = cfg_scene.instance(self.sceneId)
    self.isCoinScene = self.sceneCfg.resource == 1
    self.isMatchScene = not self.isCoinScene
    self.sceneStage = GameConst.boss_stage_small
    
    SeatRouter.instance:setMySeatId(seatId)
    --SeatRouter.instance.mySeat.coin_rate = coinRate
    --SeatRouter.instance.mySeat.chance_rate = chanceRate

    self:screenResize()

    FisheryTick:init()
    self:playFisheryMusic()

    self.fsm:changeState(StateFisheryRunning)
end


function Fishery:playFisheryMusic()
    local musicUrl = cfg_scene.instance(self.sceneId).backMusic
    SoundManager.PlayMusic(musicUrl)
end

function Fishery:updateUtil(arr, delta)
    if not arr then
        return
    end
    for k, v in pairs(arr) do
        v:update(delta)
    end
end

function Fishery:startLoop()
    if not self.loopHandle then
        self.loopHandle = GameTimer.frameLoop(1, self, self.frameUpdate, { Time.deltaTime });
    end
end

function Fishery:stopLoop()
    if self.loopHandle ~= nil then
        self.loopHandle:clear()
        self.loopHandle = nil
    end
end

function Fishery:frameUpdate(delta)
    FightM.instance:agentGetInfoUpdate(delta)
    self:updateUtil(Fishery.instance.fishes, delta)
    self:updateUtil(Fishery.instance.bullets, delta)

    if self.freezeTime > 0 then
        self.freezeTime = self.freezeTime - Time.deltaTime
        if self.freezeTime <= 0 then
            self.freezeSprite.visible = false
        end
    end

    self:updateSeats()
    self.fsm:update()
    self.fsmMatch:update()
    GameEventDispatch.instance:Event(FightEvent.FightUpdate)
    GoodsFlyManager.instance:loop(delta)
    FontClipEffect:updateFontClipEffect(delta)
    UIFishPage.instance:frameLoop()
    MeshSharing.instance:frameUpdate()
end

function Fishery:updateSeats()
    SeatRouter.instance:getSeatById(SeatRouter.SEAT_INX_1):update()
    SeatRouter.instance:getSeatById(SeatRouter.SEAT_INX_2):update()
    SeatRouter.instance:getSeatById(SeatRouter.SEAT_INX_3):update()
    SeatRouter.instance:getSeatById(SeatRouter.SEAT_INX_4):update()
end

---@param shootCtx ShootContext
function Fishery:addBullet(shootCtx)
    local bullet = BulletFactory.createBullet(shootCtx)
    local root = FishLayer.instance.bulletLayer
    local mySeat = SeatRouter.instance.mySeat
    if mySeat and mySeat:isInState(StateSeatRange) then
        root = FishLayer.instance.effectLayer
    end
    bullet:addToScene(root)
    if shootCtx and shootCtx.uid then
        self.bullets[shootCtx.uid] = bullet
    else
        table.insert(self.otherBullets, bullet)
    end
end

---@param bullet Bullet
function Fishery:removeBullet(bullet)
    self.bullets[bullet.uid] = nil
end
function Fishery:getBulletUid()
    if self.curBulletUid > Fishery._maxBulletUid then
        self.curBulletUid = Fishery._minBulletUid
    end
    self.curBulletUid = self.curBulletUid + 1;
    return self.curBulletUid;
end

---@return Fish2D
function Fishery:findFishByUniId(fishUid)
    return self.fishes[tostring(fishUid)]
end

---getFishByGroupDown 获取场上屏幕内活着的某一类型的所有鱼， 如果没有则返回空
---@public
---@param groupType number
---@return table<Fish2D>
function Fishery:getFishByGroupLock(groupType)
    local ret = {}
    ---@param fish Fish2D
    for key, fish in pairs(self.fishes) do
        if fish.groupLock == groupType and fish:isValid() and not fish.isCatch and fish:isInScreen() then
            ret[key] = fish
        end
    end
    return ret
end

function Fishery:syncKillFish(fish, data, boosType, hasAward)

    local pos = fish:screenPoint()
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(data:getAgent())
    -- 有奖励的鱼不播金币动画
    if not seatInfo or hasAward then
        return
    end
    -- local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
    -- seat:showBigSingleCoin(pos)
    -- 不再使用大的金币效果，改成使用普通的金币
    local getCoinInfo = ShowGetCoinInfo.New()
    local delayShow = 1
    local coinNum = 0
    local aniType = FightConst.playCoin
    local seat = SeatRouter.instance:getSeatByAgent(data:getAgent())
    coinNum = 1
    if FightConst.fish_death_type_none == boosType then
        coinNum = 0
        ---只显示飘金币的效果，实际不加金币
        EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seatInfo.seat_id, delayShow, pos, coinNum, data:getAgent(), nil, nil, boosType, aniType, false);
    else    
        if seat and seat.fortLevel and seat.fortLevel.text then
            coinNum = tonumber(seat.fortLevel.text) or 1
            local coinRate = 1
            if #fish.fishCfg.weight > 1 then
                coinRate = tonumber(fish.fishCfg.weight[1]) or 1
            end
            coinNum = coinNum * coinRate
            aniType = FightConst.playNumAndCoin
        end
        -- 激光炮打中鱼的金币用的是其它的动画，为了避免出现两波金币，改成和打中鱼的金币动画一样
        if FightConst.fish_death_type_laser_cannon == boosType then
            -- 没有奖励，客户端自己构造一个消息
            local catchInfo = ProtoCatchFish.New()
            catchInfo.p = { data:getUniId(), {{ FightConst.currency_coin, coinNum }}, data:getAgent(), 0, {} }
            ShadowShake.create(seat, pos, { coinGet = coinNum, fish = fish, getCoinInfo = getCoinInfo, catchInfo = catchInfo },1000)
        else
            ---只显示飘金币的效果，实际不加金币
            EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seatInfo.seat_id, delayShow, pos, coinNum, data:getAgent(), nil, nil, boosType, aniType, false);
        end
    end
end

function Fishery:syncSerialFryingKillFish(fish, data, boosType)
    local pos = fish:screenPoint()
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(data:getAgent())
    if not seatInfo then
        return
    end
    local getCoinInfo = ShowGetCoinInfo.New()
    local delayShow = 1
    ---只显示飘金币的效果，实际不加金币
    local coinNum = SerialFryingC.instance:getShowPointEx()

    EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seatInfo.seat_id, delayShow, pos, coinNum, data:getAgent(), nil, nil, boosType, nil, false);
end

function Fishery:syncZuantoupaoKillFish(fish, data, boosType)
    local pos = fish:screenPoint()
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(data:getAgent())
    if not seatInfo then
        return
    end
    local getCoinInfo = ShowGetCoinInfo.New()
    local delayShow = 1
    ---只显示飘金币的效果，实际不加金币
    local coinNum = ZuantoupaoC.instance:getShowPointEx()
    EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seatInfo.seat_id, delayShow, pos, coinNum, data:getAgent(), nil, nil, boosType, nil, false);
end

---@param fish Fish2D
function Fishery:addFish(fish)
    self.fishes[tostring(fish.uniId)] = fish
    if fish.fishCfg and fish.fishCfg.special_layer and FishLayer.instance.specialLayer[fish.fishCfg.special_layer] then
        fish:addToScene(FishLayer.instance.specialLayer[fish.fishCfg.special_layer])
    else
        fish:addToScene(FishLayer.instance.fishLayer)
    end

    if self.fsm:isInState(StateFisheryBoom) then
        fish:showBoomFlag()
    end
    self.fishNum = self.fishNum + 1
end
---@param fish Fish2D
function Fishery:removeFish(fish)
    self.fishes[tostring(fish.uniId)] = nil
    self.fishNum = self.fishNum - 1
end

function Fishery:changeOut()
    for _, fish in pairs(self.fishes) do
        if not fish.isCatch then
            fish:changeOut()
            -- self:removeFish(fish)
        end
    end
end

function Fishery:killAllSmallFish(type)
    local allFishId = {}
    for _, fish in pairs(self.fishes) do
        if fish:isInScreen() and fish.fishCfg.sizeType == 1 then
            table.insert(allFishId, fish.uniId)
        end
    end
    CmdGateOut:killFishs(type, allFishId)
end

---@return Fish2D
function Fishery:pointCollision(x, y)
    ---@param fish Fish2D
    for i, fish in pairs(self.fishes) do
        if fish:pointCollisionDetect(x, y) then
            return fish
        end
    end
    return nil
end

-- 矩形碰撞鱼检测
function Fishery:rectCollision(rect)
    local ret = {};
    for i, fish in pairs(self.fishes) do
        if fish:rectCollisionDetect(rect) then
            table.insert(ret, fish)
        end
    end
    return ret;
end

function Fishery:obbCollision(o1)
    local ret = {};
    for i, fish in pairs(self.fishes) do
        if fish:obbCollision(o1) then
            table.insert(ret, fish)
        end
    end
    return ret;
end

--function Fishery:pointCollision(x, y)
--    local rays = Camera.main:ScreenPointToRay(Input.mousePosition)
--    --local rays = Camera.main:ScreenPointToRay(Vector2.New(x,y))
--
--    local hit = RaycastHit.New()
--    local isRaycast, hit = Physics.Raycast(rays, hit.out)
--    if isRaycast then
--        if hit.collider then
--            return self.fishes[hit.collider.gameObject.transform.parent.name]
--        else
--            return nil
--        end
--    end
--end

function Fishery:exitFight()
    FisheryTick:setCanShowOldFreeze(true);
    self:stopLoop()
    if self.freezeSprite then
        self.freezeSprite.visible = false
        self.freezeTime = 0
    end

    self:cleanAllBullet()
    self:cleanAllFish()
    FontClipEffect:updateFontClipEffect(Time.deltaTime, true)

    if Fishery.instance.sceneId ~= 7 then
        SeatRouter.instance:changeToExit()
    else
        self:exitMatch()
    end
    --EffectFactory:clearAllEffect();
    self.fsm:changeState(StateFisheryExit)
    FishLayer.instance:exitFight()
    FishFactory.instance:clearAll()
    Game.instance.fishPool:Clear()
    UnityEngine.Resources.UnloadUnusedAssets()
end

function Fishery:cleanAllFish()
    ---@param fish Fish2D
    for _, fish in pairs(self.fishes) do
        fish.fsm:changeState(StateFishStop)
    end
    self.fishes = {}
end

function Fishery:cleanAllBullet()
    for _, bullet in pairs(self.bullets) do
        bullet:destroy()
    end
    self.bullets = {}
    SeatRouter.instance.mySeat:addBulletNum(-100)
    for _, bullet in ipairs(self.otherBullets) do
        bullet:destroy()
    end
    self.otherBullets = {}
end

function Fishery:setFreeze(time)
    self.freezeTime = time
    if not self.freezeSprite then
        self.freezeSprite = FishLayer.instance.freezeSprite
    end
    self.freezeSprite.visible = true
    ---@param fish Fish2D
    for _, fish in pairs(self.fishes) do
        fish:changeToFreezeState(time)
    end

end

function Fishery:cancelBoom()
    self.fsm:changeState(StateFisheryRunning)
    local mySeat = SeatRouter.instance.mySeat
    mySeat:changeToNormal()
end

function Fishery:changeToRunning()
    self.fsm:changeState(StateFisheryRunning)
end

function Fishery:changeToBoom()
    self.fsm:changeState(StateFisheryBoom)
end

function Fishery:setBatteryById(seatId, batteryContext)
    SeatRouter.instance:seatConfigChange(seatId, batteryContext.skinId, batteryContext.batteryId)
    local seat = SeatRouter.instance:getSeatById(seatId)
    if seat then
        seat:batteryContext(batteryContext)
    end
end

function Fishery:screenResize()

    --EffectFactory:screenResize()
    --if ~FightContext.instance.is3D then
    --    self._bgImgMove:screenResize()
    --else
    --    FishLayer.instance:bgSceneScreenResize()
    --end
end

function Fishery:syncCacheInfo(fishUid, info, tick)
    local fish = self:findFishByUniId(fishUid)
    if not fish then
        return
    end
    --传渔场信息
    local catchInfo = Pool.createByClass(ProtoCatchFish)
    catchInfo.p = info;
    local agentId = catchInfo:getAgent()
    fish:agentId(agentId)
    Pool.recoverByClass(catchInfo)

    --播奖励动画
    local effect = FishDeadEffect.new()
    effect:create(info)
    effect:syncCacheAward(tick)


    -- 捕获的鱼才切换为死亡状态,聚宝盆打不死，特殊处理
    if fish and fish.isCatch then
        fish.fsm:changeState(StateFishDead)
    end
end

---@param showSeatId number
---@param fishId number
---@return Vector3
function Fishery:getCatchShowPos(showSeatId, fishId)
    local ret = Vector3.New()
    --local arr = ConfigManager.instance:getConfValue("cfg_fish", fishId, "catch_show_range")
    local cfg = cfg_fish.instance(fishId)
    local arr = cfg.catch_show_range
    local startX = arr[1]
    local endX = arr[2]
    local startY = arr[3]
    local endY = arr[4]
    ret.x = startX + (endX - startX) * math.random()
    ret.y = startY + (endY - startY) * math.random()
    ret.z = 10
    if 2 == showSeatId then
        ret.x = GameScreen:getDesignWidth() - ret.x
    else
        if 3 == showSeatId then
            ret.x = GameScreen:getDesignWidth() - ret.x
            ret.y = GameScreen:getDesignHeight() - ret.y
        else
            if 4 == showSeatId then
                ret.y = GameScreen:getDesignHeight() - ret.y
            end
        end
    end
    return ret
end

---选择一条锁定优先级最高的鱼
function Fishery:chooseLockFish()
    ---@type Fish2D
    local chooseFish = nil

    ---@param fish Fish2D
    for _, fish in pairs(self.fishes) do
        if fish:canBeLock() then
            if not chooseFish then
                chooseFish = fish
            else
                if fish.fishCfg.lock_pri > chooseFish.fishCfg.lock_pri then
                    chooseFish = fish
                end
            end
        end
    end
    return chooseFish
end

---@param seatId integer 玩家的座位id
function Fishery:setRange(seatId)
    local seat = SeatRouter.instance:getSeatById(seatId)
    if seat then
        -- seat:changeToRange()
    end
end

---@param awards array 类似specAward [{"agent":1,"sk":101,"award",[1,1000],"base":400,"extra":600}]的结构体
function Fishery:syncSpecialAward(awards)
    for _, award in pairs(awards) do
        local seatInfo = SeatRouter.instance:getSeatInfoByAgent(award.agent)
        if not seatInfo then
            return
        end
        local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)

        if seat and award and award.award then
            if FightConst.currency_coin == award.award[1] then
                local agentGetInfo = AgentGetInfo.New()
                agentGetInfo.t = FightConst.currency_coin
                agentGetInfo.v = award.award[2]
                agentGetInfo.leftTime = 0
                agentGetInfo.ag = award.agent
                seat:playExtraAward(award.award[2], award.sk, agentGetInfo)
                break
            end
        end
    end

end

function Fishery:canTestZuantoupao()
    -- 第二关才开启测试
    local ret = false
    -- if 3 == self.sceneId then
    --     local nowSec = TimeTools:getCurSec()
    --     -- 60秒开启一次
    --     ret = nowSec - self.lstTestZuantoupaoTime > 20
    -- end
    return ret
end

function Fishery:checkIsExistLockFish(groupLockType)
    ---@param fish Fish2D
    for _, fish in pairs(self.fishes) do
        if fish.groupLock == groupLockType and fish:isValid() and fish:isInScreen() then
            return true
        end
    end
    return false
end

