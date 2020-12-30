---@class WhirlwindShake
---@field public instance WhirlwindShake
WhirlwindShake = class("WhirlwindShake")

function WhirlwindShake:ctor(count, seat, pos, data)
    self.seat = seat
    self.data = data
    self.bingoCount = count
    seat:ShowWhirlwind(self.bingoCount)
    self.catchInfo = data.catchInfo
    for _, v in pairs(data.fishUids) do
        local fish = Fishery.instance:findFishByUniId(v)
        if fish then
            fish.fishAniComponent.visible = false
            local item = UIPackage.CreateObject("FishDeathAni", "WhirlwindShake")

            local FishGraph = self:initDeathFish(fish.fishCfg.aniName_down, item)
            local rateTxt = item:GetChild("rate")
            GameTools.setTxtBySeatId(rateTxt, data.coinGet, seat.seatId)
            item.visible = true
            local beginr = math.random(0, 360)
            local endr = math.random(0, 360) + 180
            local FishAni = item:GetTransition("FishAni")
            local ani = item:GetTransition("deathani")

            FishAni:Play(-1, 0, nil)
            FishLayer.instance.effectLayer:AddChild(item)
            item.position = fish:screenPoint()
            local endPos = seat.bingoController:getWhirlwindPosition(self.bingoCount)
            endPos.x = endPos.x + Mathf.Random(0, 50)
            endPos.y = endPos.y + Mathf.Random(-40, 40)
            item:TweenMove(endPos, 2):OnComplete(function()
                fish.fishPosition = item.position
                GameTimer.once(1000, self, function()
                    fish.fishPosition = item.position
                    self:PlayCoin(item, fish)
                end)
            end)

        end
    end

    GameTimer.once(5000, self, function()
        self:HideWhirlwind()
        self:HideWhirlwindCoin()
    end)

    self.seat.bingoController:bingoEnd(BingoType.WhirlwindFish, self.bingoCount, data.totalCoin, self, function()
        self.seat.bingoController:resetUi(BingoType.WhirlwindFish,self.bingoCount)
        local agentGetInfo = AgentGetInfo.New()
        agentGetInfo.t = FightConst.currency_coin
        agentGetInfo.v = data.totalCoin
        agentGetInfo.leftTime = 0
        agentGetInfo.ag = self.catchInfo:getAgent()
        GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
    end, true)
end

function WhirlwindShake:initDeathFish(fishName, item)
    local FishGraph = item:GetChild("fishGraph")

    local prefabUrl = "Fish/" .. fishName
    local fish3dAni = GameTools.ResourcesLoad(prefabUrl)
    fish3dAni.transform.localPosition = Vector3.New(0, 0, fish3dAni.transform.localPosition.z + 1300)
    local wrapper = GoWrapper.New(fish3dAni)
    FishGraph:SetNativeObject(wrapper)

    return FishGraph
end

function WhirlwindShake:ShowWhirlwind(pos)
    if not self.Whirlwind then
        self.Whirlwind = SpecialEffect.playWhirlwind()
        self.Whirlwind.visible = false
    end
    self.Whirlwind.visible = true
    self.Whirlwind.position = pos
    SoundManager.PlayEffect("Music/Wind.mp3", false)
end

function WhirlwindShake:HideWhirlwind()
    SoundManager.StopEffectByUrl("Music/Wind.mp3")
    self.Whirlwind.visible = false
    self.Whirlwind.position = Vector2.New(-500, -500)
end

function WhirlwindShake:ShowWhirlwindGetCoin(pos)
    SoundManager.PlayEffect("Music/Score.mp3", false)
    if not self.WhirlwindCoin then
        self.WhirlwindCoin = EffectManager.playBurstCoin(pos)
    end
    self.WhirlwindCoin.visible = true
    self.WhirlwindCoin.position = pos
end

function WhirlwindShake:HideWhirlwindCoin()
    self.WhirlwindCoin.visible = false
    self.WhirlwindCoin.position = Vector2.New(-500, -500)
end

function WhirlwindShake.create(count, seat, pos, data)
    local ret = WhirlwindShake.New(count, seat, pos, data)
    return ret
end

function WhirlwindShake:PlayCoin(item, fish)

    local pos = fish:screenPoint()
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(self.catchInfo:getAgent())
    if not seatInfo then
        return
    end
    local getCoinInfo = ShowGetCoinInfo.New()
    local delayShow = 1
    ---只显示飘金币的效果，实际不加金币
    local coinNum = 1 --ZuantoupaoC.instance:getShowPointEx()
    EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seatInfo.seat_id, delayShow, pos, coinNum, self.catchInfo:getAgent(), nil, nil, nil, FightConst.playCoin, false);
    fish.fsm:changeState(StateFishStop)
    item:RemoveFromParent()
    item:Dispose()
end