XZEffect = class("XZEffect")

function XZEffect:ctor()
    self.wrapper = nil
    self.nowTag = 1
    self.startValue = 0
    self.awardArr = {}
    self.times = 0
    self.isAddCoin = true -- 是否加金币，有时候会只做表现，不加金币的表现,兼容原来的接口，默认给true
end

function XZEffect:showXZEffect(catchInfo, fish, coinGet, seatInfo, seat)
    local item = UIPackage.CreateObject("Fish", "CatchShowItem")

    local award = catchInfo:getShowAwardInfo()
    local agent = catchInfo:getAgent()
    -- TODO 有5个音效
    --SoundManager.PlayEffect("Music/score_change_3.mp3")
    ---@type GComponent
    ---
    self.wrapper = GComponent()
    self.wrapper:SetXY(fish.fishWrapper.x, fish.fishWrapper.y)

    ---@type GGraph
    self.bg = item:GetChild("textBg")
    self.numText = item:GetChild("numText")
    self.textAni = item:GetTransition("textAni")
    self.numText.text = 0
    --self.textAni:Play()

    self.bg.url = "ui://Fish/img_zi_d_" .. seatInfo.seat_id

    self.wrapper:AddChild(item)
    FishLayer.instance.effectLayer:AddChild(self.wrapper)

    local x = SeatRouter.instance:getSeatById(seatInfo.seat_id).cannonPosition.x
    local y = SeatRouter.instance:getSeatById(seatInfo.seat_id).cannonPosition.y

    local targetPos
    if Fishery.instance.XZFishNowType == 1 and not seat.bingoController:isBingoPlaying() then
        targetPos = Vector2.New(x, y)
    else
        if seat.showSeatId == 1 or seat.showSeatId == 2 then
            targetPos = Vector2.New(x, y - 100)
        else
            targetPos = Vector2.New(x, y + 100)
        end
    end

    self.wrapper:TweenMove(targetPos, 4)
        :OnComplete(function()
        self:coinFlyPlay(fish, agent, coinGet, targetPos, seatInfo.seat_id)
    end)

    self.nowTag = 1
    self.startValue = 0
    --- 测试数据
    --    award = {rate = 500, consume = 100, sk = 1, index = 3, award = { { 100, 100 }, { 200, 200 }, { 300, 300},{ 400, 400},{ 500, 500} }}
    if award.index == 1 then
        award.index = 2
        table.insert(award.award, 1, { award.award[1][1] * 0.75, award.award[1][1] * 0.75 })
    end
    -- 不能加金币时，强制置isAddCoin成false
    local seat = SeatRouter.instance:getSeatByAgent(agent)
    if seat and seat.isUnableAddCoin then
        self.isAddCoin = false
    end
    self:playNumChange(award, agent, coinGet)
end

function XZEffect:playNumChange(award, agent, coinGet)
    self.awardArr = award.award
    self.times = tonumber(string.format("%.2f", (4 - (0.4 * award.index + 0.1)) / award.index))
    if self.nowTag == award.index then
        self.nextValue = award.rate * award.consume
    else
        self.nextValue = self.awardArr[self.nowTag][1] * award.consume
    end
    GTween      .To(self.startValue, self.nextValue, self.times):OnUpdate(
            function(tweener)
                self.numText.text = math.modf(tweener.value.x);
            end):OnComplete(function()
        SoundManager.PlayEffect("Music/score_change_" .. self.nowTag .. ".mp3")
        self.wrapper:TweenScale(Vector2.New(1.3, 1.3), 0.2):OnComplete(function()
            self.wrapper:TweenScale(Vector2.New(1, 1), 0.2):SetDelay(0.1):OnComplete(function()
                if self.nowTag < award.index then
                    self.startValue = self.nextValue
                    self.nowTag = self.nowTag + 1
                    self:playNumChange(award, agent, coinGet)
                else
                    self.wrapper:TweenFade(0, 0.5):OnComplete(function()
                        self.wrapper:RemoveFromParent()
                        self.wrapper:Dispose()
                        self.wrapper:Destroy()

                        if Fishery.instance.XZFishNowType == 2 then
                            Fishery.instance.XZFishNowType = 1
                        end
                    end)
                end
            end)
        end)
    end)
end

function XZEffect:coinFlyPlay(fish, agent, coinGet, targetPos, seatId)
    local getCoinInfo = ShowGetCoinInfo.New()
    local randArray = {}
    local coinFly = fish.fishCfg.coin_fly
    local count = math.floor(#coinFly / 3)--12/3=4
    for j = 1, 8 do
        randArray[j] = math.random()
    end
    getCoinInfo.useTime = 0
    getCoinInfo.goodId = FightConst.currency_coin
    getCoinInfo.delay = 0
    getCoinInfo.rnd = randArray
    getCoinInfo.pos_x = 0
    getCoinInfo.pos_y = 0
    getCoinInfo.delay = 0
    local seat = SeatRouter.instance:getSeatById(seatId)
    for j = 1, count do

        getCoinInfo.pos_x = targetPos.x + coinFly[j * 3 - 1]
        getCoinInfo.pos_y = targetPos.y + coinFly[j * 3 - 1]
        getCoinInfo.delay = coinFly[j * 3]
        seat:showGetGoodsEffect(getCoinInfo)
    end

    if not self.isAddCoin then
        return
    end
    local agentGetInfo = AgentGetInfo.New()
    agentGetInfo.t = FightConst.currency_coin
    agentGetInfo.v = coinGet
    agentGetInfo.leftTime = getCoinInfo.useTime
    agentGetInfo.ag = agent
    GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
end