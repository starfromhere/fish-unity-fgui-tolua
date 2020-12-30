---@class FireDragonAwake
FireDragonAwake = class("FireDragonAwake", EffectBase)

function FireDragonAwake.create(times, uid, startPos, seat, curStage)
    local ret = Pool.createByClass(FireDragonAwake)
    FireDragonAwake.super.InitInfo(ret)
    ret:init(times, uid, startPos, seat, curStage)
    return ret
end

function FireDragonAwake:ctor()
    FireDragonAwake.super.ctor(self)
    ---@type GComponent
    self.fireDragonAwake = UIPackage.CreateObject("Fish", "FireDragonBossAwake")
    self.fireDragonAwake:MakeFullScreen()
end


function FireDragonAwake:init(times, uid, startPos, seat, curStage)
    self.stage = curStage or 1
    self.endStage = times or 1
    self.seat = seat or SeatRouter.instance.mySeat
    self.uid = uid
    self.startPos = startPos or
            Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight)
    FishLayer.instance.awakeLayer:AddChild(self.fireDragonAwake)

    self.countItem = UIPackage.CreateObject("Fish", "ZhangYuAwakeLabel")
    self.countLabel = self.countItem:GetChild("count")
    self.countLabel.text = "x" .. self.stage
    self.countItem.position = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    self.countItem.visible = false
    FishLayer.instance.upEffectLayer:AddChild(self.countItem)

    ---@type GGraph
    ---全屏闪电
    self.LightningGra = self.fireDragonAwake:GetChild("LightningGra")
    local Wrapper = GameTools.createWrapper("Effects/EffectLianHuanZhaDan/Burst_lianhuanzhadan")
    self.LightningGra:SetNativeObject(Wrapper)
    self.LightningGra.visible = false

    ---@type GGraph
    ---球
    self.BallGra = self.fireDragonAwake:GetChild("BallGraph")
    local ball = GameTools.createWrapper("Effects/LightSp")
    self.BallGra.position = startPos
    self.BallGra:SetNativeObject(ball)

    ---@type GGraph
    ---龙  1:右 2:左 3:上 4:下
    self.DragonGraph = {}
    for i = 1, 4 do
        self.DragonGraph[i] = self.fireDragonAwake:GetChild("Dragon_" .. i)
        local Wrapper, animator = GameTools.createWrapper("Fish/dragonBoss_awake", 1)
        self.DragonGraph[i]:SetNativeObject(Wrapper)
        self.DragonGraph[i].visible = false
    end

    self.BallMoveAni = self.fireDragonAwake:GetTransition("BallMoveAni")
    self.BallScaleAni = self.fireDragonAwake:GetTransition("BallScaleAni")

    self.D_Move_1 = self.fireDragonAwake:GetTransition("D_Move_1")
    self.D_Move_2 = self.fireDragonAwake:GetTransition("D_Move_2")
    self.D_Move_3 = self.fireDragonAwake:GetTransition("D_Move_3")
    self.D_Move_4 = self.fireDragonAwake:GetTransition("D_Move_4")
end


function FireDragonAwake:getCatchFishes(count)

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


function FireDragonAwake:sendMsg()
    local curCount = FireDragonAwakeC.instance:getStageCount(self.uid)
    local fishes, removeFishes = self:getCatchFishes(curCount)
    if self.stage < self.endStage then
        fishes = {}
        removeFishes = {}
    end
    FireDragonAwakeC.instance:sendMsg(self.uid, fishes, self.stage, removeFishes)
end


function FireDragonAwake:ballInCenter()
    self:sendMsg()
    if self.stage + 1 <= self.endStage then
        self.stage = self.stage + 1
    end
    self.countLabel.text = "x" .. self.stage
    self.BallScaleAni:Play()
    self.countItem:GetTransition("scaleAni"):Play()
    self.LightningGra.visible = true
end

function FireDragonAwake:play()
    self.countLabel.text = "x" .. self.stage
    self.BallMoveAni:SetValue("startPos", self.startPos.x, self.startPos.y)
    self.BallMoveAni:Play(function()
        self.countItem.visible = true
        --- 1.43秒
        GameTimer.once(1430, self, function()
            self:startDragonShow()
        end)
    end)
end

function FireDragonAwake:startDragonShow()
    if self.stage <= self.endStage then
        self.DragonGraph[1].visible = true
        self.DragonGraph[2].visible = true

        self:timeShow()
    end
end

function FireDragonAwake:timeShow()
    --- 1.69秒
    GameTimer.once(260, self, function()
        self.DragonGraph[3].visible = true
        self.DragonGraph[4].visible = true
        self.D_Move_3:Play()
        self.D_Move_4:Play()
        self.D_Move_1:Play(function ()
            for i = 1, 4 do
                self.DragonGraph[i].visible = false
            end
            GameTimer.once(2410, self, function()
                --- 5.92秒 新一轮开始
                self:startDragonShow()
            end)

            GameTimer.once(730, self, function()
                  self.LightningGra.visible = false
            end)
        end)
        self.D_Move_2:Play()
    end)

    --- 1.99秒
    GameTimer.once(560, self, function ()
        self:ballInCenter()
    end)


    --- 3.71秒时，分数准备消失，金币准备出现
    --- 4.24秒时，火球的爆炸效果完全消失
end


function FireDragonAwake:reset()
    self.seat:bingoEndAutoState()
    GameTimer.clearTarget(self)
    self.fireDragonAwake:RemoveFromParent()
    self.countItem:RemoveFromParent()
    self.uid = nil
    DragonAwakeC.instance.awake = nil
end

function FireDragonAwake:recover()
    self:reset()
    self.countItem:Dispose()
    self.fireDragonAwake:Dispose()
end

function FireDragonAwake:Destroy()
    FireDragonAwake.super.Destroy(self)
    self:reset()
    self.countItem:Dispose()
    self.fireDragonAwake:Dispose()
end


