ZhangYuAwake = class("ZhangYuAwake", EffectBase)

function ZhangYuAwake:ctor(uid, seat, pos, allStage, curStage)
    ZhangYuAwake.super.ctor(self)
    self.uid = uid
    self.maxIndex = allStage
    self.curIndex = curStage or 1
    self.seat = seat
    self.juexing = UIPackage.CreateObject("Fish", "ZhangYuAwake")
    self.juexing.width = GameScreen.instance.adaptWidth
    self.juexing.height = GameScreen.instance.adaptHeight
    self.zhangYuAwakeLabel = UIPackage.CreateObject("Fish", "ZhangYuAwakeLabel")
    self.countLabel = self.zhangYuAwakeLabel:GetChild("count")
    self.countLabel.text = "x" .. self.curIndex
    self.zhangYuAwakeLabel.position = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    self.juexing:GetChild("light").position = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    local ball = GameTools.createWrapper("Effects/LightSp")
    self.ballgraph = self.juexing:GetChild("ball")
    self.ballgraph.position = pos
    self.ballgraph:SetNativeObject(ball)
    -- self:play(coinGet, catchInfo)
    FishLayer.instance.upEffectLayer:AddChild(self.zhangYuAwakeLabel)
    FishLayer.instance.awakeLayer:AddChild(self.juexing)
    self.lightwrapper = GameTools.createWrapper('Particle/Lightning_Zhangyu')
    local names = { "left_up", "right_down", "left_down", "right_up", "left_middle", "right_middle", "up_middle", "down_middle" }
    self.animations = {}
    for _, name in pairs(names) do
        local wrapper, animation = GameTools.createWrapper("Fish/" .. name)
        animation:Play("Stop")
        -- animation:Stop()
        table.insert(self.animations, animation)
        self.juexing:GetChild(name):SetNativeObject(wrapper)
    end
end

function ZhangYuAwake:reset()
    GameTimer.clearTarget(self)
    self.zhangYuAwakeLabel:RemoveFromParent()
    self.juexing:RemoveFromParent()
    self.uid = nil
    ZhangYuAwakeC.instance.awake = nil
end

function ZhangYuAwake:recover()
    self:reset()
    self.lightwrapper:Dispose()
    self.zhangYuAwakeLabel:Dispose()
    self.juexing:Dispose()
end

function ZhangYuAwake:Destroy()
    ZhangYuAwake.super.Destroy(self)
    self.lightwrapper:Dispose()
    self.zhangYuAwakeLabel:Dispose()
    self.juexing:Dispose()
    self:reset()
end

function ZhangYuAwake.create(uid, seat, pos, index)
    local ret = ZhangYuAwake.New(uid, seat, pos, index)
    return ret
end

function ZhangYuAwake:sendMsg(isLast)
    local curCount = ZhangYuAwakeC.instance:getStageCount(self.uid)
    local fishes = {}
    local removeFishes = {}
    if isLast then
        fishes, removeFishes = self:getCatchFishes(curCount)
    end
    ZhangYuAwakeC.instance:sendMsg(self.uid, fishes, self.count, removeFishes)
end

function ZhangYuAwake:getCatchFishes(count)

    local ret = {}
    local removeFishes = {}
    local fishes = Fishery.instance.fishes
    local num = 0
    for _, fish in pairs(fishes) do
        if not fish or num >= count then
            break
        end
        if fish.fishCfg.canRemove == 1 then
            table.insert(removeFishes, fish.uniId)
        else
            table.insert(ret, fish.uniId)
        end
        num = num + 1
    end
    return ret, removeFishes
end

function ZhangYuAwake:play(coinGet, catchInfo, agentId)
    self.coinGet = coinGet
    self.catchInfo = catchInfo
    self.agentId = agentId
    self.ballgraph:SetScale(0.1, 0.1)
    self.ballgraph:TweenScale(Vector2.New(1, 1), 1):OnComplete(function ()
        self.ballgraph:TweenMove(Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2), 1)
    end)

    GameTimer.once(2000, self, function()
        self.count = 0
        self:zhangYuAwakeStep1(coinGet, catchInfo)
    end)
end

function ZhangYuAwake:changeIndex()
    GameTimer.once(700, self, function()
        if self.curIndex < self.maxIndex and self.count > 1 then
            self.curIndex = self.curIndex + 1
            self.countLabel.text = "x" .. self.curIndex
        end
    end)

end

function ZhangYuAwake:zhangYuAwakeStep1(coinGet, catchInfo)
    self.count = self.count + 1

    if self.count >= self.maxIndex then
        self:zhangYuAwakeStep3(coinGet, catchInfo)
        return
    end
    self:changeIndex()
    self.juexing:GetTransition("ball"):Play()
    self.zhangYuAwakeLabel:GetTransition("ball"):Play()
    self.juexing:GetTransition("boom"):Play(function()
        GameTools.fullScreenShake(10, 1)
        self.juexing:GetChild("light").visible = true
        self.juexing:GetChild("light"):SetNativeObject(self.lightwrapper)
    end)
    self.animations[1]:Play("Take 001")
    self.animations[2]:Play("Take 001")
    SoundManager.PlayEffect("Music/zhangyu_awake.mp3")
    self.juexing:GetTransition("step1"):Play(function()
        self:sendMsg(false)
        if self.count < self.maxIndex then
            self:zhangYuAwakeStep2(coinGet, catchInfo)
        end
    end)
end

function ZhangYuAwake:zhangYuAwakeStep2(coinGet, catchInfo)
    self.count = self.count + 1
    self:changeIndex()
    self.juexing:GetTransition("ball"):Play()
    self.zhangYuAwakeLabel:GetTransition("ball"):Play()
    self.juexing:GetTransition("boom"):Play(function()
        GameTools.fullScreenShake(10, 1)
        -- local lightwrapper = GameTools.createWrapper('Particle/Burst_Zuantoupao')
        self.juexing:GetChild("light").visible = true
        self.juexing:GetChild("light"):SetNativeObject(self.lightwrapper)
    end)
    self.animations[3]:Play("Take 001")
    self.animations[4]:Play("Take 001")
    SoundManager.PlayEffect("Music/zhangyu_awake.mp3")
    self.juexing:GetTransition("step2"):Play(function()
        self:sendMsg(false)
        if self.count >= self.maxIndex then
            self:zhangYuAwakeStep3(coinGet, catchInfo)
        else
            self:zhangYuAwakeStep1(coinGet, catchInfo)
        end
    end)
end

function ZhangYuAwake:zhangYuAwakeStep3(coinGet, catchInfo)
    self:changeIndex()
    self.juexing:GetTransition("ball2"):Play()
    self.zhangYuAwakeLabel:GetTransition("ball2"):Play(function()
        self.zhangYuAwakeLabel:GetTransition("cicle"):Play(function()
            GameTimer.once(500, self, function()
                local agentId = 0
                if is_empty(catchInfo) then
                    agentId = self.agentId
                else
                    agentId = catchInfo:getAgent()
                end
                self.seat.bingoController:bingoEnd(BingoType.ZhangYuBoss,nil, tonumber(self.coinGet) / tonumber(self.maxIndex), self, function()
                    local agentGetInfo = AgentGetInfo.New()
                    agentGetInfo.t = FightConst.currency_coin
                    agentGetInfo.v = self.coinGet
                    agentGetInfo.leftTime = 0
                    agentGetInfo.ag =  agentId
                    GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
                    self.seat.bingoController:resetUi(BingoType.ZhangYuBoss, nil);
                end, false)
                local endVec = Vector2.New(self.seat.cannonPosition.x, self.seat.cannonPosition.y)
                self.zhangYuAwakeLabel:TweenMove(endVec, 0.9)
                GameTimer.once(1500, self, function()
                    self.juexing:Dispose()
                    self.zhangYuAwakeLabel:Dispose()
                    self.seat.bingoController:aloneSetFinalScore(BingoType.ZhangYuBoss, nil, self.coinGet)
                    self.seat:bingoEndAutoState()
                    GameTimer.once(6500, self, function ()

                        self:recover()
                    end)
                end)
            end)
        end)
    end)

    self.juexing:GetTransition("boom"):Play(function()
        GameTools.fullScreenShake(10, 1)
        local lightwrapper = GameTools.createWrapper('Particle/Burst_Zuantoupao')
        self.juexing:GetChild("light").visible = true
        self.juexing:GetChild("light"):SetNativeObject(lightwrapper)
    end)
    for _, animation in pairs(self.animations) do
        animation:Play("Take 001")
    end
    SoundManager.PlayEffect("Music/zhangyu_awake.mp3")
    GameTimer.once(2000,self,function()
        self:sendMsg(true)
    end)
    self.juexing:GetTransition("step3"):Play(function()

        self.ballgraph.visible = false

        --if self.seat.seatId == SeatRouter.instance.mySeatId then
        --    Fishery.instance:killAllSmallFish(FightConst.fish_death_type_boss_awake)
        --end
    end)

end

function ZhangYuAwake:endScore(out_room, award)
    if out_room == 1 then
        self.juexing:Dispose()
        self.zhangYuAwakeLabel:Dispose()
        self:recover()
        return
    end

    self.coinGet = award
end

function ZhangYuAwake:playWithProtocol(coinGet, agentId, curStage, endStage)
    self.coinGet = coinGet
    self.agentId = agentId
    self.curIndex = curStage
    self.maxIndex = endStage
    self.count = curStage
    self.countLabel.text = "x" .. self.curIndex

    if self.curIndex == 5 then
        self:zhangYuAwakeStep3(self.coinGet, nil , self.agentId)
    else
        if (self.curIndex + 1) % 2  == 0 then
            self:zhangYuAwakeStep2(self.coinGet, nil, self.agentId)
        else
            self:zhangYuAwakeStep1(self.coinGet, nil,  self.agentId)
        end
    end
end


function ZhangYuAwake:getComeBackData(data)
    if data.stage == 0 then
        return
    end
    GameTimer.clearTarget(self)
    self.count = data.stage
    self.curIndex = data.stage
    self.countLabel.text = "x" .. self.curIndex
    self.coinGet = data.award
    self.juexing:GetTransition("step1"):Stop()
    self.juexing:GetTransition("step2"):Stop()
    if data.stage == 5 then
        self:zhangYuAwakeStep3(self.coinGet, self.catchInfo)
    else
        if (data.stage + 1) % 2  == 0 then
            self:zhangYuAwakeStep2(self.coinGet, self.catchInfo)
        else
            self:zhangYuAwakeStep1(self.coinGet, self.catchInfo)
        end
    end

end