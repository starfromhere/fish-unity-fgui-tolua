function Seat:showGetGoodsEffect(data)
    local seatPosition = Vector2.New(self.globalCoinPosition.x, self.globalCoinPosition.y)
    local effect = GoodsFlyEffect.create(data.goodId, data.pos_x, data.pos_y, seatPosition.x, seatPosition.y, data.delay, data.rnd)
    data.useTime = effect:getEffectTime()
    GoodsFlyManager.instance:addFlyEffect(effect);
end

function Seat:showBigSingleCoin(pos)
    local seatPosition = Vector2.New(self.globalCoinPosition.x, self.globalCoinPosition.y)
    local box = GComponent.New();
    local image = AnimalManger.create("Assets/Res/UI/Animation/Animation",
            "Animation", "Coin", true)
    image:setPivot(0.5, 0.5)
    image:play(true)
    image:addTo(box)
    image:setScale(2, 2)
    box.position = pos
    FishLayer.instance.effectLayer:AddChild(box)
    local dx = pos.x - self.cannonPosition.x
    local dy = pos.y - self.cannonPosition.y
    local distance = math.sqrt(dx * dx + dy * dy)
    -- TweenMove的时间单位是秒,所以速度要调成h5版的1000倍
    local speed = 2
    GameTimer.once(1000, self, function()
        box:TweenMove(seatPosition, (distance / speed) / 1000)
        GameTimer.once(distance / speed + 100, self, function()
            image:destroy()
            box:RemoveFromParent()
            box:Dispose()
        end)
    end)

end

function Seat:showBossJueXing(fishx, fishy, showAwardInfo, bingoType, coinGet, fish, getCoinInfo, catchInfo, agentId, tick)
    Log.debug("showBossJueXing")
    local index = showAwardInfo["index"]
    local rate = showAwardInfo["consume"]
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(agentId)
    if not seatInfo then
        return
    end
    GameTimer.once(1500, self, function()
        if bingoType == BingoType.ZhangYuBoss then
            self.bingoController:showBingo(rate, bingoType,nil)
            ZhangYuAwakeC.instance:onZhangYuAwake(catchInfo:getFishUid(), self, Vector2.New(fishx, fishy), nil, coinGet, catchInfo, agentId, showAwardInfo)
            return
        end
        if bingoType == BingoType.EYuBoss then
            EYuAwakeC.instance:onEYuAwake(catchInfo:getFishUid(), showAwardInfo, agentId, Vector2.New(fishx, fishy))
            self.bingoController:showBingo(rate, bingoType,nil)
            return
        end
        if bingoType == BingoType.AnKangYuBoss then
            AnKangYuAwakeC.instance:onAnKangYuAwake(false, catchInfo:getFishUid(), showAwardInfo, agentId, Vector2.New(fishx, fishy))
            local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
            self.bingoController:showBingo(rate, bingoType,nil)
            return
        end
        if bingoType == BingoType.LongBoss then
            DragonAwakeC.instance:onDragonAwake(false, catchInfo:getFishUid(), showAwardInfo, agentId, Vector2.New(fishx, fishy), tick)
            local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
            self.bingoController:showBingo(rate, bingoType,nil)
            return
        end
        if bingoType == BingoType.FireDragonBoss then
            FireDragonAwakeC.instance:onDragonAwake(false, catchInfo:getFishUid(), showAwardInfo, agentId, Vector2.New(fishx, fishy), tick)
            local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
            self.bingoController:showBingo(rate, bingoType,nil)
            return
        end
    end)
end

function Seat:showGetSpecialPaoEffect(data)
    --TODO 获取结束的位置
    local endX = self.shootStartX
    local endY = self.shootStartY
    local effect = SpecialPaoEffect.create(data.pos_x, data.pos_y, endX, endY, data.goodId, data.seat_id, FishLayer.instance.effectLayer)
    effect:play()
end


function Seat:playBoom(x, y, skillId, completeFunc)
    local cfgSkill = cfg_skill.instance(skillId)
    if not self.boomSprite then
        self.boomSprite = GLoader.New()
        self.boomSprite.pivotX = 0.5
        self.boomSprite.pivotY = 0.5
        self.boomSprite.scale:Set(3, 3)
        self.boomSprite.pivotAsAnchor = true
        FishLayer.instance.effectLayer:AddChild(self.boomSprite)
    end
    self.boomSprite.visible = true
    self.boomSprite.url = cfgSkill.show
    self.boomSprite.x = self.shootStartX
    self.boomSprite.y = self.shootStartY
    self.boomSprite.rotation = 90 + MathTools.vecToAngle(x - self.boomSprite.x, y - self.boomSprite.y)
    local vecOrigin = Vector2.New(self.boomSprite.x, self.boomSprite.y)
    local vecTarget = Vector2.New(x, y)

    local distance = MathTools.distance(vecOrigin.x, vecOrigin.y, vecTarget.x, vecTarget.y)
    local speed = 1200
    local time = distance / speed
    GTween.To(vecOrigin, vecTarget, time):SetEase(EaseType.Linear):OnUpdate(function(tweener)
        self.boomSprite.x = tweener.value.x
        self.boomSprite.y = tweener.value.y
    end)  :OnComplete(function(tweener)
        self.boomSprite.visible = false
        self.boomSprite:Dispose()
        self.boomSprite = nil
        completeFunc()
    end)
    return time
end

function Seat:showDCPEffect()
    local aniUrl = "Forts/H5_diancipao_paotaishandain"
    local positon = Vector3.New(0, 0, 1000)
    local root = GGraph()
    root:SetPosition(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2, 1000)
    local guanxiaoAni = SpineManager.create(aniUrl, positon, 1, root)

    FishLayer.instance.effectLayer:AddChild(root)
    guanxiaoAni:play("animation", true)

    aniUrl = "Forts/diancipao"
    local diancipao = SpineManager.create(aniUrl, positon, 1, root)
    diancipao:play("animation", true)
end

---鳄鱼咬，掉零件
function Seat:showDropParts()
    if not self.fortPartSpine then
        local position = Vector3.New(0, 0, 0)
        self.fortPartSpine = SpineManager.create("Forts/lingjian", position, 1, self.fortPart)
    end
    self.fortPart.visible = true

    self.fortPartSpine:play("H5_lingjian", false, function()
        --Log.debug(self,"fuck",self.fortPart)
        self.fortPart.visible = false
    end)
end

---鳄鱼觉醒
function Seat:playEyuAwake()
    if not self.eyuAwake then
        self.eyuAwake = EYuAwake.create()
    end
    self.eyuAwake.visible = true
    self.eyuAwake:play(3)
end

function Seat:playAnKangYuAwake()
    AnKangYuAwakeC.instance:onAnKangYuAwake()
end

function Seat:playHammerAwake()
    HammerAwakeC.instance:onHammerAwake()
end

function Seat:initFishBoom(x, y, z)
    ---@type GGraph
    local fishBoomGraph = GGraph.New()
    fishBoomGraph.pivot = Vector2.New(0.5, 0.5)
    local boomWrapper = GameTools.createW
    rapper("Effects/Hit_Ankangyu")
    fishBoomGraph:SetNativeObject(boomWrapper)
    fishBoomGraph.position = Vector3.New(x, y, z or 1000)
    FishLayer.instance.effectLayer:AddChild(fishBoomGraph)
    SoundManager.PlayEffect("Music/ankang_boom.wav")

    GameTimer.once(1000, self, function()
        FishLayer.instance.effectLayer:RemoveChild(fishBoomGraph)
        fishBoomGraph:Dispose()
    end)
end

function Seat:ShowWhirlwind(bingoCount)
    self.bingoController:showBingo(nil, BingoType.WhirlwindFish,bingoCount)
    local pos = self.bingoController:getWhirlwindPosition(bingoCount)
    WhirlwindShake:ShowWhirlwind(pos)
end

