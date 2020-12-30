---@class SerialFryingEffect
---@field New SerialFryingEffect
SerialFryingEffect = class("SerialFryingEffect", EffectBase)

function SerialFryingEffect:ctor()
    SerialFryingEffect.super.ctor(self)
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    self.midX = 0
    self.midY = 0
    self.startScale = 0
    self.endScale = 0
    self.midScale = 0
    self.flyObj = nil
    self.step = 0
    self.spentTime = 0
    self.totalTime = 0
    self.curCount = 0
    self.showCount = 0
    self.agentId = 0
    self.bRate = 0
    self.totalPoint = 0
    self.sceneId = 0
    self.spRoot = nil
    self.ANI_SCALE_STEP1 = 0.6
    self.ANI_SCALE_STEP3 = 1.2
    self.ANI_SCALE_STEP4 = 0.6
    self.ANI_TIME_STEP1 = 1000
    self.ANI_TIME_STEP2 = 2000
    self.ANI_TIME_STEP3 = 1500
    self.ANI_TIME_STEP4 = 1000
    self.ANI_TIME_END = 1500
    self.ANI_SPINE_INTERVAL = 1000
    self.ANI_ROTATION = 360
    self.ANI_ROTATION_TIME = 2000
    self.ANI_STEP_BEG = 1
    self.ANI_STEP1 = 1
    self.ANI_STEP2 = 2
    self.ANI_STEP3 = 3
    self.ANI_STEP4 = 4
    self.ANI_STEP_END = 5
    self.BLUE_LIGHT_SPINE = "Effects/blue_light"
    self.YELLOW_LIGHT_SPINE = "Effects/yellow_light"
    self.LIGHT_SPINE2 = "Effects/EffectLianHuanZhaDan/select_lianhuanzhadan"
    self.BOOM_SPINE = "Effects/bao"
    self.BOOM_SPINE2 = "Effects/EffectLianHuanZhaDan/Burst_lianhuanzhadan"
    self.countPoints = {}
    self.tmpPoint = Vector2.New()
    self.onceTimer = nil
    self.loopTimer = nil
    --- @type NumChgEffect
    self.numChgEffect = nil
    self.spineRoot = GComponent.New()
    self.spineRoot.pivot = Vector2.New(0.5, 0.5)
    self.spineRoot.pivotAsAnchor = true
    self.lightWrapper = nil
    self.boomWrapper = nil
end

function SerialFryingEffect.create(startX, startY, endX, endY, flyObj, countPoints, agentId, bRate, tp, sceneId, parent)
    local item = Pool.createByClass(SerialFryingEffect)
    item:InitInfo()
    item:init(startX, startY, endX, endY, flyObj, countPoints, agentId, bRate, tp, sceneId, parent)
    -- 连环炸弹掉落的音效
    GameTools.playRandomMusic("zhadan_get", ".mp3", 1, 3)
    return item
end

function SerialFryingEffect:clearOnceTimer()
    if self.onceTimer then
        self.onceTimer:clear()
        self.onceTimer = nil
    end
end

function SerialFryingEffect:clearLoopTimer()
    if self.loopTimer then
        self.loopTimer:clear()
        self.loopTimer = nil
    end
end

function SerialFryingEffect:clearNumChgEffect()
    if self.numChgEffect then
        self.numChgEffect:recover()
    end
end

function SerialFryingEffect:reset()
    local seat = SeatRouter.instance:getSeatByAgent(self.agentId)
    if seat and seat:isInState(StateSeatWait) then
        seat:changeToNormal()
        seat:onSerialFryingShowScore(self.totalPoint, self.totalPoint, self.agentId)
        -- 表现结束后把金币加上去
    end
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    self.startScale = 0
    self.endScale = 0
    if self.flyObj then
        self.flyObj:recover()
    end
    self.spRoot = nil
    self.step = self.ANI_STEP_BEG
    self.spentTime = 0
    self.curCount = 0
    self.agentId = 0
    self.bRate = 0
    self.totalPoint = 0
    self.countPoints = nil
    self:clearOnceTimer()
    self:clearLoopTimer()
    GameTimer.clearTarget(self)
    self:clearNumChgEffect()
    if self.lightWrapper then
        self.lightWrapper:RemoveFromParent()
        self.lightWrapper:Dispose()
        self.lightWrapper = nil
    end
    if self.boomWrapper then
        self.boomWrapper:RemoveFromParent()
    end
    if self.spineRoot then
        self.spineRoot:RemoveFromParent()
        self.spineRoot:RemoveChildren(0, -1, false)
        -- self.spineRoot:Dispose()
    end
    local isRecovered = self[Pool.POOLSIGN]
    if not isRecovered then
        SerialFryingC.instance:reset()
    end
end

function SerialFryingEffect:Destroy()
    SerialFryingEffect.super.Destroy(self)
    self:reset()
    if self.boomWrapper then
        self.boomWrapper:Dispose()
    end
    if self.spineRoot then
        self.spineRoot:Dispose()
    end
end

function SerialFryingEffect:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function SerialFryingEffect:init(startX, startY, endX, endY, flyObj, countPoints, agentId, bRate, tp, sceneId, parent)
    self.startX = startX
    self.startY = startY
    self.endX = endX
    self.endY = endY
    self.flyObj = flyObj
    self.curCount = 1
    self.showCount = 1
    self.flyObj:init(self.showCount, true)
    self.countPoints = countPoints
    self.agentId = agentId
    self.bRate = bRate
    self.totalPoint = tp
    self.sceneId = sceneId
    self.spRoot = parent
    -- 中途退出的时候，item的visible会被设置成false,需要设置回来
    self.spineRoot.visible = true
    parent:AddChild(self.spineRoot)
    parent:AddChild(self.flyObj:getItem())
    self:updateMidPoint()
end

function SerialFryingEffect:play()
    self.step = self.ANI_STEP_BEG
    local root = self.flyObj
    root:pos(self.startX, self.startY)
    root:setAniScale(self.ANI_SCALE_STEP1)
    self:doFlyRotate()
    self:doAction()
end

function SerialFryingEffect:gotoNextStep()
    -- 可能会多次播放第三个步骤
    if (self.ANI_STEP3 == self.step) then
        self.step = self.step + 1
    elseif (self.ANI_STEP4 == self.step) then
        -- 可能会多次播放第三个步骤
        self.curCount = self.curCount + 1
        -- 播放次数不满的话,进入下一个阶段;已经满了的话，就跳到动画的结尾
        if (self.curCount <= #self.countPoints) then
            self.step = self.ANI_STEP3
        else
            self.step = self.ANI_STEP_END
        end
    else
        self.step = self.step + 1
    end
    self:doAction()
end

function SerialFryingEffect:updateMidPoint()
    self.midX = self.endX
    self.midY = self.startY
end

function SerialFryingEffect:getShowPoint(x, y)
    local ret = self.tmpPoint
    ret:Set(0, 0)
    local seat = SeatRouter.instance:getSeatByAgent(self.agentId)
    -- 根据显示位置做镜像
    if (seat) then
        local showSeatId = seat.showSeatId
        local mirrorFlag = MirrorMapper.getMirrorFlagBySeatId(showSeatId)
        self.tmpPoint:Set(x, y)
        MirrorMapper.map2DPoint(ret, ret, mirrorFlag)
        GameScreen.instance:designToAdapt(ret, ret)
    end
    return ret
end

function SerialFryingEffect:getTotalTime()
    local count = #self.countPoints
    local totalTime = self.ANI_TIME_STEP3 * count + self.ANI_TIME_STEP4 * count
    return totalTime
end

function SerialFryingEffect:doAction()
    local step = self.step
    if (self.ANI_STEP1 == step) then
        self:doStep1()
    elseif self.ANI_STEP2 == step then
        self:doStep2()
    elseif self.ANI_STEP3 == step then
        self:doStep3()
    elseif self.ANI_STEP4 == step then
        self:doStep4()
    else
        self:doStepEnd()
    end
end

function SerialFryingEffect:doStep1()
    self.spentTime = 0
    self.totalTime = self.ANI_TIME_STEP1
    local showPoint = self:getShowPoint(self.startX, self.startY)
    -- 玩家中途退出时，seat为nil,此时清掉表现
    if showPoint.x == 0 and showPoint.y == 0 then
        self:recover()
        return
    end
    self.startX = showPoint.x
    self.startY = showPoint.y
    showPoint = self:getShowPoint(self.endX, self.endY)
    self.endX = showPoint.x
    self.endY = showPoint.y
    self:updateMidPoint()
    self:startTimer()
    local seat = SeatRouter.instance:getSeatByAgent(self.agentId)
    local showSeatId = 0
    if (seat) then
        -- showSeatId = seat.showSeatId
        -- local totalTime = self:getTotalTime()
        -- GameEventDispatch.instance.event(FightEvent.PlaySerialBoom, {["seat_id"] = showSeatId, ["aniTime"] = self.ANI_TIME_STEP1, ["pos_x"] = self.startX, ["pos_y"] = self.startY, ["rate"] = self.bRate, ["tp"] = self.totalPoint, ["tt"] = totalTime })
        local seat = SeatRouter.instance:getSeatByAgent(self.agentId)
        if seat then
            seat.bingoController:showBingo(seat.fortLevel.text, BingoType.SerialBoomPangXie, nil, self.startX, self.startY, seat.cannonPosition.x, seat.cannonPosition.y)
        end
    end
end

function SerialFryingEffect:onStep2Completed()
    self:gotoNextStep()
    -- FightEventDispatch.instance.event(FightEvent.PlayNumChg)
    self:clearNumChgEffect()
    local seat = SeatRouter.instance:getSeatByAgent(self.agentId)
    if seat then
        local totalTime = self:getTotalTime()
        GameTimer.once(self.ANI_SPINE_INTERVAL / 2, self, function()
            seat.bingoController:startShowNum(BingoType.SerialBoomPangXie, nil, 0, self.totalPoint, totalTime, 0)
        end)
    end
end

function SerialFryingEffect:doStep2()
    self.onceTimer = GameTimer.once(self.ANI_TIME_STEP2, self, self.onStep2Completed)
    self:catchFish(self.ANI_TIME_STEP2)
end

function SerialFryingEffect:doStep3()
    self.spentTime = 0
    local item = self.flyObj:getItem()
    self.startX = item.x
    self.startY = item.y
    local curPoint = self.countPoints[self.curCount]
    -- 根据显示位置做镜像
    local showPoint = self:getShowPoint(curPoint.x, curPoint.y)
    -- 玩家中途退出时，seat为nil,此时清掉表现
    if showPoint.x == 0 and showPoint.y == 0 then
        self:recover()
        return
    end
    self.endX = showPoint.x
    self.endY = showPoint.y
    self.totalTime = self.ANI_TIME_STEP3
    self:updateMidPoint()
    self:startTimer()
    self:doFlyScaleStep1()
end

function SerialFryingEffect:startTimer()
    if not self.loopTimer then
        self.loopTimer = GameTimer.frameLoop(1, self, self.updatePath)
    end
end

function SerialFryingEffect:doStep4()
    self:catchFish(self.ANI_SPINE_INTERVAL)
    self.onceTimer = GameTimer.once(self.ANI_TIME_STEP4, self, self.gotoNextStep)
end

function SerialFryingEffect:catchFish(delay)
    local item = self.flyObj:getItem()
    local x = item.x
    local y = item.y
    local spRoot = self.spineRoot
    self:playLightSpine(x, y, spRoot, delay)
end

function SerialFryingEffect:generateEffectFish(x, y)
    -- local tmp = self.tmpPoint
    -- tmp:Set(x, y)
    -- GameScreen.instance:adaptToDesign(tmp, tmp)
    -- local effect = nil
    -- local randomAngle = FightTools.getRandomNumber(-45, 45)
    -- local cfgScene = cfg_scene.instance(self.sceneId)
    -- local fishId = 0
    -- if (cfgScene and cfgScene.boomGeneratedFishes and #cfgScene.boomGeneratedFishes >= 1) then
    --     local arr = cfgScene.boomGeneratedFishes
    --     local index = FightTools.getRandomNumber(1, #arr)
    --     fishId = arr[index]
    -- end
    -- for i = 1, 4, 1 do
    --     for j = 1, 5, 1 do
    --         effect = SwimFishEffect.create(fishId, tmp.x, tmp.y, 90 * i + randomAngle, 400 * j)
    --         effect.play()
    --     end
    -- end
end

function SerialFryingEffect:playLightSpine(x, y, spRoot, delay)
    -- local spineName = self.BLUE_LIGHT_SPINE
    -- local position = Vector3.New(0, 0, 0)
    -- local graph = GGraph.New()
    -- local spineItem = SpineManager.create(spineName, position, 1, graph)
    -- spRoot:AddChild(graph)
    -- graph.x = x
    -- graph.y = y
    -- spineItem:play("animation", false, self.onLightSpineCompleted)
    local seat = SeatRouter.instance:getSeatByAgent(self.agentId)
    -- 玩家中途退出时，seat为nil,此时清掉表现
    if not seat then
        self:recover()
        return
    end
    local wrapper = self.lightWrapper
    if not self.lightWrapper then

        self.lightWrapper = EffectManager.playLightSpine(x, y, spRoot,seat.seatId)
    else
        local graph = nil

        graph = self.lightWrapper.gOwner
        graph.x = x
        graph.y = y
        self.lightWrapper.visible = true
        spRoot:AddChild(graph)
    end

    self.onceTimer = GameTimer.once(delay, self, function()
        local myAgentId = FightM.instance:getOwnAgent()
        --- 检测鱼的碰撞
        self.flyObj:updPos(x, y)
        -- 更新显示的鱼分数数组
        SerialFryingC.instance:setSinglePoint(self.totalPoint, #self.countPoints, self.curCount, #self.flyObj.catchFishes, self.bRate)
        --- 自己的表现时上传消息
        -- if (myAgentId == self.agentId) then
        -- 防止玩家切后台的时候，其它玩家没有移除鱼和飘金币的表现
        self.flyObj:endCatchFish(self.agentId, self.curCount == #self.countPoints)
        -- end
        self:generateEffectFish(x, y)
        self:playBoomSpine(x, y, spRoot)
        -- wrapper:RemoveFromParent()
        -- wrapper:Dispose()
        self.lightWrapper.visible = false
        -- 第二阶段爆炸了一次，因此显示的次数要比实际的次数多1
        self.showCount = math.min(self.showCount + 1, #self.countPoints + 1)
        self.flyObj:showCount(self.showCount)
    end)
end

function SerialFryingEffect:playBoomSpine(x, y, spRoot)
    -- local spineName = self.BOOM_SPINE
    -- local position = Vector3.New(0, 0, 0)
    -- local graph = GGraph.New()
    -- spRoot:AddChild(graph)
    -- local spineItem = SpineManager.create(spineName, position, 1, graph)
    -- graph.x = x
    -- graph.y = y
    -- spineItem:play("bao", false, self.onBoomSpineCompleted)

    if not self.boomWrapper then
        self.boomWrapper = EffectManager.playBoomSpine(x, y, spRoot)
    else
        local graph = nil
        graph = self.boomWrapper.gOwner
        graph.x = x
        graph.y = y
        spRoot:AddChild(graph)
        -- TODO 暂时通过改变visible让粒子重头开始播放
        self.boomWrapper.visible = false
        self.boomWrapper.visible = true
    end
    SoundManager.PlayEffect("Music/zhadan_boom.mp3")
    GameTools.fullScreenShake(10, 1)
end

function SerialFryingEffect:onLightSpineCompleted()
    local spine = self
    if (spine) then
        spine:stop()
        spine:destroy()
    end
end

function SerialFryingEffect:onBoomSpineCompleted()
    local spine = self
    if (spine) then
        spine:stop()
        spine:destroy()
    end
end

function SerialFryingEffect:doFlyScaleStep1()
    local ani = self.flyObj:getScaleAni()
    ani:Play()
end

function SerialFryingEffect:doFlyRotate()
    local ani = self.flyObj:getRotateAni()
    ani:Play()
end

function SerialFryingEffect:calQuadraticBezier(p0, p1, p2, t)
    return FightTools:calQuadraticBezier(p0, p1, p2, t)
end

function SerialFryingEffect:onBezierEnd()
    self:clearLoopTimer()

    self:gotoNextStep()
end

function SerialFryingEffect:updatePath()
    self.spentTime = self.spentTime + UnityEngine.Time.deltaTime * 1000
    if (self.spentTime >= self.totalTime) then
        self:onBezierEnd()
        return
    end
    local t = self.spentTime / self.totalTime
    local x = self:calQuadraticBezier(self.startX, self.midX, self.endX, t)
    local y = self:calQuadraticBezier(self.startY, self.midY, self.endY, t)
    self.flyObj:pos(x, y)
end

function SerialFryingEffect:doStepEnd()
    -- 暂时注释掉，避免反复Dispose造成的crash
    -- if self.flyObj then
    --     self.flyObj:recover()
    -- end
    self.onceTimer = GameTimer.once(self.ANI_TIME_END, self, self.recover)
end