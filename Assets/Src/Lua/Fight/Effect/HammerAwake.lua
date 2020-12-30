---@class HammerAwake
HammerAwake = class("HammerAwake", EffectBase)

function HammerAwake.create(uid, crabPosition, seat)
    local ret = HammerAwake.New(uid, crabPosition, seat)
    HammerAwake.super.InitInfo(ret)
    return ret
end

function HammerAwake:ctor(uid, crabPosition, seat)

    HammerAwake.super.ctor(self)
    self.uid = uid
    self.crabPosition = crabPosition
            or Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    self.seat = seat or SeatRouter.instance.mySeat

    ---@type GComponent
    self.hammerAwake = UIPackage.CreateObject("Fish", "HammerAwake")
    self.hammerAwake:MakeFullScreen()
    FishLayer.instance.awakeLayer:AddChild(self.hammerAwake)

    self.PointGroup = self.hammerAwake:GetChild("PointGroup")
    self.PointGraphs = {}
    for i = 1, 5 do
        self.PointGraphs[i] = self.hammerAwake:GetChild("Point_" .. i)
        local linerWrapper = GameTools.createWrapper("Effects/Leishengzhichui_Connect")
        self.PointGraphs[i]:SetNativeObject(linerWrapper)
        self.PointGraphs[i].visible = false
    end

    self.FramePointGroup = self.hammerAwake:GetChild("FramePointGroup")
    self.FramePointGroups = {}
    for i = 1, 4 do
        self.FramePointGroups[i] = self.hammerAwake:GetChild("FramePoint_" .. i)
        local linerWrapper = GameTools.createWrapper("Effects/Leishengzhichui_Around")
        self.FramePointGroups[i]:SetNativeObject(linerWrapper)
    end

    ---@type GGraph
    self.CrabGraph = self.hammerAwake:GetChild("CrabGraph")
    ---@type GGraph
    self.HammerGraph = self.hammerAwake:GetChild("HammerGraph")
    self:initHammer()

    ---@type GGraph
    self.FullScreenHammer = self.hammerAwake:GetChild("FullScreenHammer")
    local fallHammerWrapper = GameTools.createWrapper("Effects/Burst_Leishenzhichui")
    self.FullScreenHammer:SetNativeObject(fallHammerWrapper)
    self.PointAni = self.hammerAwake:GetTransition("PointScaleAni")
    self.PointEndAni = self.hammerAwake:GetTransition("PointEndAni")
    self.CrabAni = self.hammerAwake:GetTransition("CrabAni")
    self.CrabRotAni = self.hammerAwake:GetTransition("CrabRotAni")
    self.HammerAni = self.hammerAwake:GetTransition("HammerAni")
    self.HammerRotAni = self.hammerAwake:GetTransition("HammerRotAni")
end
function HammerAwake:initData()

end
function HammerAwake:initHammer()
    local item = GameTools.ResourcesLoad("Effects/chuiziZaDi")

    local animator = nil
    if item.transform.childCount > 0 then
        animator = item.transform:GetChild(0).gameObject:GetComponent("Animator")
    end
    ---@type GoWrapper
    local hammerWrapper = GoWrapper.New(item)
    ---@type Animator
    self.hammerAnimator = animator
    self.HammerGraph:SetNativeObject(hammerWrapper)
    self.HammerGraph.scale = Vector3.New(3, 3, 3)
    self.HammerLightingItem = item.transform:GetChild(0).transform:GetChild(1).gameObject
    self.HammerLightingItem:SetActive(false)
end

function HammerAwake:initPointsAngle()
    local centerPos = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    for i = 1, 5 do
        self.PointGraphs[i].scale = Vector3.New(5, 5, 5)
        local position = self.PointGraphs[i].position
        local angle = MathTools.vecToAngle(position.x - centerPos.x, position.y - centerPos.y)
        self.PointGraphs[i].rotation = angle + 270
        self.PointGraphs[i].visible = false
    end
end

function HammerAwake:initFramePoints()

    for i = 1, 4, 2 do
        self.FramePointGroups[i].rotation = -90
        self.FramePointGroups[i].scale = Vector3.New(20, 22, 20)
        self.FramePointGroups[i + 1].rotation = 0
        self.FramePointGroups[i + 1].scale = Vector3.New(20, 10, 20)
    end
end

---play顺序 ：螃蟹旋转 & 座位标志飘动 --> 闪电三次 --> 锤子翻 --> 闪电一起 --> 锤子spine --> 分数
function HammerAwake:play()

    self:playCrabAndSeatHammerAni(self.crabPosition)
    self.HammerLightingItem:SetActive(false)
end

function HammerAwake:playCrabAndSeatHammerAni(crabPosition)
    local position = crabPosition or Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    self.CrabGraph.position = position
    self.CrabAni:SetValue("startPos", position.x, position.y)
    self.CrabGraph.visible = true
    self.CrabRotAni:Play()
    self:playSeatHammerAni(position)
    self.CrabAni:Play(function()
        self:crabAniCallBack()
    end)
end

function HammerAwake:playSeatHammerAni(startPos)
    SoundManager.PlayEffect("Music/hammer_slow.wav", true)
    self.seat.bingoController:showBingo(self.seat.fortLevel.text, BingoType.HammerPangXie, nil, startPos.x, startPos.y, self.seat.cannonPosition.x, self.seat.cannonPosition.y)
end

function HammerAwake:crabAniCallBack()
    self.CrabGraph.visible = false
    self.HammerRotAni:Play(function()
        self:playHammerAndPointsAni()
    end)
end

function HammerAwake:playHammerAndPointsAni()
    self:initFramePoints()
    self.HammerAni:Play()
    self:initPointsAngle()
    self.PointGroup.visible = true
    self.FramePointGroup.visible = true

    GameTimer.once(350, self, function()
        self.HammerLightingItem:SetActive(true)
    end)
    self.PointAni:Play(function()
        self:pointsAniCallBack()
    end)

    GameTimer.once(2000, self, function()
        SoundManager.PlayEffect("Music/hammer_electric.mp3")
    end)
    GameTimer.once(3000, self, function()
        --- 锤子第一次翻转动画
        self.hammerAnimator:Play("Spin")

    end)
end

function HammerAwake:pointsAniCallBack()

    self.PointEndAni:Play(function()
        self:pointEndAniCallBack()
    end)

    GameTimer.once(400, self, function()
        ---锤子砸地
        self.hammerAnimator:Play("Knock")
    end)
end

function HammerAwake:pointEndAniCallBack()
    --- 全屏爆炸动画
    SoundManager.StopEffectByUrl("Music/hammer_slow.wav")

    self.PointGroup.visible = false
    self.FramePointGroup.visible = false
    GameTimer.once(300, self, function()
        SoundManager.PlayEffect("Music/hammer_beat.wav")

        self.FullScreenHammer.visible = true
        SoundManager.PlayEffect("Music/hammer_lightning.wav")
        GameTools.fullScreenAllUIShake(10, 2)
    end)

    GameTimer.once(500,self,function ()
        local curCount = HammerAwakeC.instance:getStageCount(self.uid)
        local fishes, removeFishes = self:getCatchFishes(curCount)
        HammerAwakeC.instance:sendMsg(self.uid, fishes, 1,  removeFishes)
    end)


    GameTimer.once(3000, self, function()
        self.HammerGraph.visible = false
        self.FullScreenHammer.visible = false
        self:playEndScore(self.score)
    end)

end

function HammerAwake:playEndScore()
    self.score = self.score or 0
    self.seat.bingoController:bingoEnd(BingoType.HammerPangXie,nil, self.score, self, self.playEnd, false)
end

function HammerAwake:initEndScore(score,baseScore,agentId, out_room)
    self.score = score
    self.baseScore = baseScore
    self.agent = agentId
    if out_room == 1 then
        self:recover()
    end
end

function HammerAwake:playEnd()
    self.seat:bingoEndAutoState()
    self.seat:bossDeathAddCoin(self.score + self.baseScore, self.agent)
    self.seat.bingoController:resetUi(BingoType.HammerPangXie,nil)
    self.CrabGraph.visible = false
    self.HammerGraph.visible = false
    self.PointGroup.visible = false
    self.FramePointGroup.visible = false
    self.score = 0
    self:recover()
end

function HammerAwake:getCatchFishes(count)

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

function HammerAwake:reset()
    GameTimer.clearTarget(self)
    --self:removeAll()
    self.hammerAwake:RemoveFromParent()
    HammerAwakeC.instance.awake = nil
    HammerAwakeC.instance.tick = 0
    SoundManager.StopEffectByUrl("Music/hammer_slow.wav")
    SoundManager.StopEffectByUrl("Music/hammer_lightning.wav")
    SoundManager.StopEffectByUrl("Music/hammer_beat.wav")
    SoundManager.StopEffectByUrl("Music/hammer_electric.mp3")
end

function HammerAwake:recover()
    self:reset()
    self.hammerAwake:Dispose()
end

function HammerAwake:Destroy()
    HammerAwake.super.Destroy(self)
    self:reset()
    self.hammerAwake:Dispose()
end

function HammerAwake:resetAni(tick)
    if tick < 2000 then
        return
    end
    if tick >= 2000 and tick < 4000 then
        self.hammerAnimator:Play("Spin")
        GameTimer.once(1000, self, function()
            self:pointsAniCallBack()
        end)
    elseif tick >= 4000 and tick < 5400 then
        self:pointsAniCallBack()
    elseif tick >= 5400 then
        self.seat:changeToNormal()
        self.seat.bingoController:resetUi(BingoType.HammerPangXie,nil)
        self.CrabGraph.visible = false
        self.HammerGraph.visible = false
        self.PointGroup.visible = false
        self.FramePointGroup.visible = false
        self.score = 0

        self:recover()
    else
        self:pointsAniCallBack()
    end
end







