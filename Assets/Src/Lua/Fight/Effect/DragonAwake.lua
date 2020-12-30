---@class DragonAwake
DragonAwake = class("DragonAwake", EffectBase)

DragonAwake.LeftToRight = 0
DragonAwake.RightToLeft = 1
DragonAwake.UpToDown = 2
DragonAwake.DownToUp = 3
DragonAwake.UpperLeftToLowerRight = 4
DragonAwake.LowerRightToUpperLeft = 5


function DragonAwake.create(times, uid, startPos, seat, curStage)
    local ret = Pool.createByClass(DragonAwake)
    DragonAwake.super.InitInfo(ret)
    ret:init(times, uid, startPos, seat, curStage)
    return ret
end

function DragonAwake:ctor()
    DragonAwake.super.ctor(self)
    ---@type GComponent
    self.dragonAwake = UIPackage.CreateObject("Fish", "DragonBossAwake")
    self.dragonAwake:MakeFullScreen()
end

function DragonAwake:init(times, uid, startPos, seat, curStage)
    self.stage = curStage or 1
    self.endStage = times or 1
    self.seat = seat or SeatRouter.instance.mySeat
    self.uid = uid
    self.startPos = startPos or
            Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight)
    FishLayer.instance.awakeLayer:AddChild(self.dragonAwake)

    self.countItem = UIPackage.CreateObject("Fish", "ZhangYuAwakeLabel")
    self.countLabel = self.countItem:GetChild("count")
    self.countLabel.text = "x" .. self.stage
    self.countItem.position = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    self.countItem.visible = false
    FishLayer.instance.upEffectLayer:AddChild(self.countItem)

    ---@type GGraph
    ---全屏闪电
    self.LightningGra = self.dragonAwake:GetChild("LightningGra")
    local Wrapper = GameTools.createWrapper("Particle/Lightning_Zhangyu")
    self.LightningGra:SetNativeObject(Wrapper)
    self.LightningGra.visible = false

    ---@type GGraph
    ---球
    self.BallGra = self.dragonAwake:GetChild("BallGra")
    local ball = GameTools.createWrapper("Effects/LightSp")
    self.BallGra.position = startPos
    self.BallGra:SetNativeObject(ball)

    self.BallMoveAni = self.dragonAwake:GetTransition("BallMoveAni")
    self.BallScale = self.dragonAwake:GetTransition("BallScale")
end

function DragonAwake:play()
    self.countLabel.text = "x" .. self.stage
    self.BallMoveAni:SetValue("startPos", self.startPos.x, self.startPos.y)
    self.BallMoveAni:Play(function()
        self:ballInCenter()
    end)
end

function DragonAwake:ballInCenter()
    GameTimer.once(1000, self, function ()
        self.countItem.visible = true
        self.countItem:GetTransition("scaleAni"):Play()
        self.BallScale:Play()
        self.LightningGra.visible = true
    end)
    GameTimer.once(2000, self, function()
        self.LightningGra.visible = false
        self:leftAndRightShow()
    end)
end

function DragonAwake:ballChangeShow()
    GameTimer.once(660, self, function ()
        if self.stage + 1 <= self.endStage then
            self.stage = self.stage + 1
            self.countLabel.text = "x" .. self.stage
        end
        self.countItem:GetTransition("scaleAni"):Play()
        self.BallScale:Play()
    end)
end

function DragonAwake:leftAndRightShow()
    --- 左右两条龙
    self:initDragonAniByDir(DragonAwake.LeftToRight)
    self:initDragonAniByDir(DragonAwake.RightToLeft)
    self:ballChangeShow()
    GameTimer.once(2000, self, function ()
        self:upAndDownShow()
    end)
end

function DragonAwake:upAndDownShow()
    --- 上下两条龙
    self:initDragonAniByDir(DragonAwake.UpToDown)
    self:initDragonAniByDir(DragonAwake.DownToUp)
    self:ballChangeShow()
    GameTimer.once(2000, self, function ()
        self:upDownRightShow()
    end)
end

function DragonAwake:upDownRightShow()
    --- 上下右三条龙
    self:initDragonAniByDir(DragonAwake.UpToDown)
    self:initDragonAniByDir(DragonAwake.DownToUp)
    self:initDragonAniByDir(DragonAwake.RightToLeft)
    self:ballChangeShow()
    GameTimer.once(1330, self, function ()
        self:rightAndLeftUp()
    end)
end

function DragonAwake:rightAndLeftUp()
    --- 右 左上两条龙
    self:initDragonAniByDir(DragonAwake.RightToLeft)
    self:initDragonAniByDir(DragonAwake.UpperLeftToLowerRight)
    GameTimer.once(670, self, function()
        self:upRightUpLeft()
    end)
end

function DragonAwake:upRightUpLeft()
    --- 上 右下 左边三条龙
    self:initDragonAniByDir(DragonAwake.UpToDown)
    self:initDragonAniByDir(DragonAwake.LowerRightToUpperLeft)
    self:initDragonAniByDir(DragonAwake.LeftToRight)
    self:ballChangeShow()
    GameTimer.once(2000, self, function ()
        self:clearSmallFish()
    end)
end

function DragonAwake:clearSmallFish()
    self:ballChangeShow()
    self.LightningGra.visible = true
    for i = 1, self.endStage do
        self:sendMsg(i)
    end

    GameTimer.once(800, self, function ()
        self:playScreenBoom()
    end)
end


function DragonAwake:initDragonAniByDir(dir)
    local startPoint = Vector2.New()
    local centerPoint = Vector2.New()
    local endPoint = Vector2.New()

    local centerX = GameScreen.instance.centerX
    local centerY = GameScreen.instance.centerY
    centerPoint:Set(centerX, centerY)

    local item = GGraph.New()
    local Wrapper, animator = GameTools.createWrapper("Fish/dragonBoss_awake", 1)
    item:SetNativeObject(Wrapper)

    if dir == DragonAwake.LeftToRight then
        startPoint:Set(-350, centerY)
        endPoint:Set(GameScreen.instance.adaptWidth + 800, centerY)

        item.rotation = 0
    elseif dir == DragonAwake.RightToLeft then
        startPoint:Set(GameScreen.instance.adaptWidth + 1300, centerY)
        endPoint:Set(-GameScreen.instance.adaptWidth, centerY)

        item.rotation = -180
        Wrapper.wrapTarget.transform:GetChild(0).transform.localRotation = Quaternion.Euler(-1, 85, -135)
    elseif dir == DragonAwake.UpToDown then
        startPoint:Set(centerX, -800)
        endPoint:Set(centerX, GameScreen.instance.adaptHeight + 800)

        item.rotation = 90
    elseif dir == DragonAwake.DownToUp then
        startPoint:Set(centerX, GameScreen.instance.adaptHeight + 800)
        endPoint:Set(centerX, -800)

        item.rotation = -90
    elseif dir == DragonAwake.UpperLeftToLowerRight then
        startPoint:Set(-800, -800)
        endPoint:Set(GameScreen.instance.adaptWidth + 1300, GameScreen.instance.adaptHeight + 800)

        item.rotation = 45
    elseif dir == DragonAwake.LowerRightToUpperLeft then
        startPoint:Set(GameScreen.instance.adaptWidth + 800, GameScreen.instance.adaptHeight + 800)
        endPoint:Set(-800, -800)

        item.rotation = -135
    end

    item.x = startPoint.x
    item.y = startPoint.y
    item.visible = true

    self.dragonAwake:AddChildAt(item, 1)
    item:TweenMove(endPoint, 5):OnStart(function()
        animator:Update(0)
        animator:Play("swim") end):OnComplete(function()
            if dir == DragonAwake.RightToLeft then
                Wrapper.wrapTarget.transform.localRotation = Quaternion.Euler(-1, 85, -35)
            end
            item:RemoveFromParent()
            item:Dispose()
    end)
end

function DragonAwake:sendMsg(stage)
    local curCount = DragonAwakeC.instance:getStageCount(self.uid)
    local fishes, removeFishes = self:getCatchFishes(curCount)
    if stage < self.endStage then
        fishes = {}
        removeFishes = {}
    end
    DragonAwakeC.instance:sendMsg(self.uid, fishes, stage, removeFishes)
end

function DragonAwake:playScreenBoom()
    local totalTime = 10.8
    local tick = 0.04
    local currentTick = 0
    local exploreCount = math.random(1, 2)

    GameTimer.frameLoop(1, self, function ()
        totalTime = totalTime + Time.deltaTime
        if totalTime > 13 then
            GameTimer.clearTarget(self.playScreenBoom)
            return
        end
        if totalTime > 12 then
            tick = 0.04
            exploreCount = math.random(1, 2)
        elseif totalTime > 11.33 then
            tick = 0.02
            exploreCount = math.random(3, 4)
        elseif totalTime > 10.8 then
            tick = 0.04
            exploreCount = math.random(1, 2)
        end

        currentTick = currentTick - Time.deltaTime
        if currentTick < 0 then
            self:initSmallBoom(exploreCount)
            currentTick = currentTick + tick
        end
    end)
end

function DragonAwake:initSmallBoom(boomCount)
    for i = 1, boomCount do

        local x = math.random(0, GameScreen.instance.adaptWidth)
        local y = math.random(0, GameScreen.instance.adaptHeight)
        local z = 1000
        local pos = Vector3.New(x, y, z)
        ---@type GGraph
        local boomGra = GGraph.New()
        local boomWrapper = GameTools.createWrapper("Effects/Burst_Leitinglong")
        boomGra:SetNativeObject(boomWrapper)
        boomGra.position = pos

        self.dragonAwake:AddChild(boomGra)

        GameTimer.once(1000, self, function ()
            boomGra:RemoveFromParent()
            boomGra:Dispose()
        end)
    end
end

function DragonAwake:createDragon(parentGra)
    local Wrapper = GameTools.createWrapper("Fish/dragonBoss_awake")
    parentGra:SetNativeObject(Wrapper)
end

function DragonAwake:initData(stage, endStage, award)
    --self.stage = stage + 1
    self.endStage = endStage
    self.stageAward = award
    --self:play()
end

function DragonAwake:playEndScore(score, agentId, out_room)
    if out_room == 1 then
        self:recover()
        return
    end
    if self.seat then
        self.countItem:GetTransition("cicle"):Play(function()
            self.seat.bingoController:bingoEnd(BingoType.LongBoss,nil, math.ceil(tonumber(score) / tonumber(self.endStage)), self, function()
                local agentGetInfo = AgentGetInfo.New()
                agentGetInfo.t = FightConst.currency_coin
                agentGetInfo.v = score
                agentGetInfo.leftTime = 0
                agentGetInfo.ag = agentId
                GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
                self.seat.bingoController:resetUi(BingoType.LongBoss,nil);
            end, false)
            self.BallGra.visible = false
            local endVec = Vector2.New(self.seat.cannonPosition.x, self.seat.cannonPosition.y)
            self.countItem:TweenMove(endVec, 0.9)
            GameTimer.once(1500, self, function()
                self.countItem:Dispose()
                self.seat.bingoController:aloneSetFinalScore(BingoType.LongBoss,nil, score)

                GameTimer.once(3000, self, function ()
                    self.seat:bingoEndAutoState()
                    self:recover()
                end)
            end)
        end)
    end
end

function DragonAwake:getCatchFishes(count)

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

function DragonAwake:resetAni(tick)
    if tick < 1000 then
        return
    end

    GameTimer.clearTarget(self)
    self.stage = 1
    if tick >= 2000 and tick < 4000 then
        self:leftAndRightShow()
    elseif tick >= 4000 and tick < 6000 then
        if self.endStage > 2 then
            self.stage = 2
        end
        self:leftAndRightShow()
    elseif tick >= 6000 and tick < 7330 then
        if self.endStage > 3 then
            self.stage = 3
        else
            self.stage = self.endStage
        end
        self:upDownRightShow()
    elseif tick >= 7330 and tick < 8000 then
        if self.endStage > 4 then
            self.stage = 4
        else
            self.stage = self.endStage
        end
        self:rightAndLeftUp()
    elseif tick >= 8000 and tick < 10000 then
        if self.endStage > 5 then
            self.stage = 5
        else
            self.stage = self.endStage
        end
        self:upRightUpLeft()
    elseif tick >= 10000 then
        self:clearSmallFish()
    end
end

function DragonAwake:reset()
    self.seat:bingoEndAutoState()
    GameTimer.clearTarget(self)
    self.dragonAwake:RemoveFromParent()
    self.countItem:RemoveFromParent()
    self.uid = nil
    DragonAwakeC.instance.awake = nil
end

function DragonAwake:recover()
    self:reset()
    self.countItem:Dispose()
    self.dragonAwake:Dispose()
end

function DragonAwake:Destroy()
    DragonAwake.super.Destroy(self)
    self:reset()
    self.countItem:Dispose()
    self.dragonAwake:Dispose()
end


