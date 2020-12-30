---@class EYuAwake
EYuAwake = class("EYuAwake", EffectBase)

EYuAwake.LeftToRight = 0
EYuAwake.RightToLeft = 1

function EYuAwake:ctor(index, uid, startPos, curStage)

    EYuAwake.super.ctor(self)
    self.stage = curStage or 0
    self.curTime = 0
    self.totalTime = index or 1
    self.startPos = startPos or Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight /2)
    self.uid = uid

    self.eyuAwake = UIPackage.CreateObject("Fish", "EyuAwake")
    self.eyuAwake:MakeFullScreen()
    FishLayer.instance.awakeLayer:AddChild(self.eyuAwake)

    ---@type GGraph
    self.eyuIce = self.eyuAwake:GetChild("eyuIce")
    ---@type GGraph
    self.eyu = self.eyuAwake:GetChild("eyu")

    local eyuIceWrapper = GameTools.createWrapper("Effects/Ice_Eyu")
    self.eyuIce:SetNativeObject(eyuIceWrapper)

    local eyuWrapper, animator = GameTools.createWrapper("Fish/eyuboss_awake", 2)
    self.eyu:SetNativeObject(eyuWrapper)
    ---@type Animator
    self.animator = animator

    self.eyuAni = self.eyuAwake:GetTransition("eyuSwim")
    self.eyuAni2 = self.eyuAwake:GetTransition("eyuSwim2")
    self.eyuScaleAni = self.eyuAwake:GetTransition("scaleAni")
    self.countFt = self.eyuAwake:GetChild("countFt")
    self.countBg = self.eyuAwake:GetChild("countBg")
    self.boomWrapper = self.eyuAwake:GetChild("boom")
    self.boomWrapper2 = self.eyuAwake:GetChild("boom2")
    self.StartAni = self.eyuAwake:GetTransition("StartAni")
    self.MoveAni = self.eyuAwake:GetTransition("MoveAni")

    self.spineItem2 = SpineManager.create('Effects/blue_light', Vector3.New(0, 0, 0), 1, self.boomWrapper2)
    self.boomWrapper2.visible = false
    self.boomWrapper.visible = false
end

---@return EYuAwake
function EYuAwake.create(index, uid, startPos)
    local ret = EYuAwake.New(index, uid, startPos)
    EYuAwake.super.InitInfo(ret)
    return ret
end

function EYuAwake:play()

    self.countFt.visible = false
    self.countBg.visible = false
    self.StartAni:SetValue("startPos", self.startPos.x, self.startPos.y)
    self.StartAni:Play()
    --self.uid = uid
    GameTimer.once(1000,self,function ()
        self.MoveAni:SetValue("startPos", self.startPos.x, self.startPos.y)
        self.MoveAni:Play(function ()
            self:_playEyuByTime(0)
        end)
    end)

end

---整套动画结束
function EYuAwake:onEnd()
    self.uid = 0
    self.eyu.visible = false
    self.eyuIce.visible = false
    self.countFt.visible = false
    self.countBg.visible = false

    self:recover()
    --    TODO
end

function EYuAwake:getCatchFishes(count)
    -- TODO 根据鳄鱼的位置获取捕获的鱼
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

---@param time number @第N次咬合结束
function EYuAwake:_onPlayEnd(time)
    if self.stage == 0 then
        self:_playEyuByTime(time + 1)
    else
        self:_playEyuByTime(self.curTime + 1)
    end

end

---@param time number @第N次开始咬合
function EYuAwake:_onAttack(time)
    self.eyuScaleAni:Play()
    self.spineItem = SpineManager.create('Effects/EffectLianHuanZhaDan/Burst_lianhuanzhadan', Vector3.New(0, 0, 0), 1, self.boomWrapper)
    self.boomWrapper.visible = true
    GameTools.fullScreenShake(10, 1)
    GameTimer.once(500, self, function()
        self.boomWrapper2.visible = true
        self.spineItem2:play("animation", false)
    end)
    self.countFt.text = math.min(time + 2, self.totalTime)

    local curCouont = EYuAwakeC.instance:getStageCount(self.uid)
    local fishes, removeFishes = self:getCatchFishes(curCouont)
    EYuAwakeC.instance:sendMsg(self.uid, fishes, self.curTime + 1, removeFishes)
end

---根据次数播放鳄鱼动画
function EYuAwake:_playEyuByTime(time)
    local isShowCount = time >= 0
    self.countFt.visible = isShowCount
    self.countBg.visible = isShowCount
    if isShowCount then
        self.countFt.text = time + 1
        self.curTime = time
    end
    if time == self.totalTime then
        self:onEnd()
    else

        local dir = nil
        self.eyu.visible = true
        GameTimer.once(1000, self, function ()
            SoundManager.PlayEffect("Music/eyu_awake_attack.mp3")
        end)
        if time % 2 == 0 then
            dir = EYuAwake.LeftToRight
        else
            dir = EYuAwake.RightToLeft
        end
        self:_playEyuAniByDir(dir, function()
            self:_onPlayEnd(time)
        end, function()
            self:_onAttack(time)
        end)
    end
end

---根据方向播放鳄鱼动画
function EYuAwake:_playEyuAniByDir(dir, onComplete, onComplete2)


    local startPoint = Vector2.New()
    local centerPoint = Vector2.New()
    local endPoint = Vector2.New()

    local centerX = GameScreen.instance.centerX
    local centerY = GameScreen.instance.centerY

    if dir == EYuAwake.LeftToRight then
        startPoint:Set(-200, centerY)
        centerPoint:Set(centerX, centerY)
        endPoint:Set(centerX * 5, centerY)

        self.eyu.rotation = 0
    elseif dir == EYuAwake.RightToLeft then
        startPoint:Set(GameScreen.instance.adaptWidth, centerY)
        centerPoint:Set(centerX, centerY)
        endPoint:Set(-GameScreen.instance.adaptWidth - 400, centerY)

        self.eyu.rotation = 180
    end

    self.eyu.x = startPoint.x
    self.eyu.y = startPoint.y
    self.eyu.visible = true

    self.eyu:TweenMove(centerPoint, 2.5):OnStart(function()
        self.animator:Play("eyu_swim03")
    end):OnUpdate(function(tween)
        ---@type GTweener
        local tweener = tween

        if Time.timeScale == 1 then
            if tweener.normalizedTime > 0.85 then
                Time.timeScale = 0.2
            end
        end
        if Time.timeScale == 0.2 then
            if tweener.normalizedTime > 0.90 then
                Time.timeScale = 1
            end
        end

    end):OnComplete(function()
        onComplete2()
        self.eyu:TweenMove(endPoint, 4):OnStart(function()
            self.animator:Play("swim")
        end):OnComplete(function()
            self.eyu.visible = false
            onComplete()
        end)
    end)
end

function EYuAwake:playEndScore(out_room)
    if out_room == 1 then
        self:onEnd()
    end
end


function EYuAwake:getComeBackData(stage)
    if stage == 0 then
        return
    end
    self:playSynchronize(stage)
end

function EYuAwake:playWithProtocol(stage)
    self.eyuIce.visible = true
    self:playSynchronize(stage)
end

function EYuAwake:playSynchronize(stage)
    self.stage = stage
    self.animator:Play("eyu_swim03", 0 , 0)
    self.animator:Update(0)
    self:_playEyuByTime(stage)
end

function EYuAwake:reset()
    GameTimer.clearTarget(self)
    --self:removeAll()
    self.eyuAwake:RemoveFromParent()
    EYuAwakeC.instance.awake = nil
    Time.timeScale = 1
    self.curTime = 0
    self.stage = 0
    SoundManager.StopEffectByUrl("Music/eyu_awake_attack.mp3")
end

function EYuAwake:recover()
    self:reset()
    self.eyuAwake:Dispose()
end


function EYuAwake:Destroy()
    EYuAwake.super.Destroy(self)
    self:reset()
    self.eyuAwake:Dispose()
end



