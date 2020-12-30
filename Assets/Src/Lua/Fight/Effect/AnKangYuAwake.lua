---@class AnKangYuAwake
AnKangYuAwake = class("AnKangYuAwake", EffectBase)

function AnKangYuAwake.create(times, uid, startPos, seat, curStage)
    local ret = Pool.createByClass(AnKangYuAwake)
    AnKangYuAwake.super.InitInfo(ret)
    ret:init(times, uid, startPos, seat, curStage)
    return ret
end

function AnKangYuAwake:ctor()

    AnKangYuAwake.super.ctor(self)
    ---@type GComponent
    self.ankangyuAwake = UIPackage.CreateObject("Fish", "AnKangYuAwake")
    self.ankangyuAwake:MakeFullScreen()

    ---中间数字及背景
    self.n3 = self.ankangyuAwake:GetChild("n3")

    ---@type GGraph
    ---球背景
    self.BackgroundGraph = self.ankangyuAwake:GetChild("BackgroundGraph")
    local backWrapper = GameTools.createWrapper("Effects/Background_Ankangyu")
    self.BackgroundGraph:SetNativeObject(backWrapper)

    ---@type GGraph
    ---球
    self.iceHockey = self.ankangyuAwake:GetChild("iceHockeyLoader")
    local iceHockeyWrapper = GameTools.createWrapper("Effects/Liuxingchui_Ankangyu")
    self.iceHockey:SetNativeObject(iceHockeyWrapper)

    ---@type GGraph
    ---蓄力的光
    self.LightGraph = self.ankangyuAwake:GetChild("LightGraph")
    local LightHockeyWrapper = GameTools.createWrapper("Effects/Burst_Liuxingchui_Ankangyu")
    self.LightGraph:SetNativeObject(LightHockeyWrapper)

    self.LinerGraph = {}
    for i = 1, 8 do
        self.LinerGraph[i] = self.ankangyuAwake:GetChild("LinerGraph" .. i)
        local linerWrapper = GameTools.createWrapper("Effects/Trail_Bullet_Ankangyu")
        self.LinerGraph[i]:SetNativeObject(linerWrapper)
    end
    self.n18 = self.ankangyuAwake:GetChild("n18")
    self.PointAni1 = self.ankangyuAwake:GetTransition("PointAni1")
    self.PointAni2 = self.ankangyuAwake:GetTransition("PointAni2")

    self.StartAni = self.ankangyuAwake:GetTransition("StartAni")
    self.MoveAni = self.ankangyuAwake:GetTransition("MoveAni")
    self.ScaleAni = self.ankangyuAwake:GetTransition("ScaleAni")
    self.AlphaAni = self.ankangyuAwake:GetTransition("AlphaAni")
    self.ReadyAni = self.ankangyuAwake:GetTransition("ReadyAni")
    self.WaitReadyAni = self.ankangyuAwake:GetTransition("WaitReadyAni")

    self.countFt = self.ankangyuAwake:GetChild("countFt")
    self.countBg = self.ankangyuAwake:GetChild("n0")

    ---@type GGraph
    self.boomGraph = self.ankangyuAwake:GetChild("boomGraph")
    local boomWrapper = GameTools.createWrapper("Effects/Hit_Ankangyu")
    self.boomGraph:SetNativeObject(boomWrapper)

    self.BoomGraph_1 = {}
    for i = 1, 8 do
        self.BoomGraph_1[i] = self.ankangyuAwake:GetChild("boom_1_" .. i)
    end
    self.BoomGraph_2 = {}
    for i = 1, 8 do
        self.BoomGraph_2[i] = self.ankangyuAwake:GetChild("boom_2_" .. i)
    end

end

function AnKangYuAwake:init(times, uid, startPos, seat, curStage)
    self.stage = curStage or 0
    self.endStage = times or 1
    self.seat = seat or SeatRouter.instance.mySeat
    self.uid = uid
    self.startPos = startPos or
            Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight)
    FishLayer.instance.awakeLayer:AddChild(self.ankangyuAwake)
end

function AnKangYuAwake:initBoomAni(isShowBoom)
    GameTools.fullScreenAllUIShake(5, 2)
    SoundManager.PlayEffect("Music/ankang_boom.wav")
    -- 修正爆炸效果会播放两遍的bug
    if isShowBoom then
        self:showBoom(self.BoomGraph_1)
        GameTimer.once(200, self, function()
            self:showBoomGroup()
        end)
    end
end

function AnKangYuAwake:showBoomGroup()
    SoundManager.PlayEffect("Music/ankang_boom.wav")
    self:showBoom(self.BoomGraph_2)
    GameTimer.once(3000, self, function()
        self:hideBoom(self.BoomGraph_2)
        self:hideBoom(self.BoomGraph_1)
    end)
end

function AnKangYuAwake:showBoom(list)
    for i = 1, 8 do
        GameTimer.once((i - 1) * 50, self, function()
            local prefabUrl = "Effects/Hit_Ankangyu"
            local prefabSign = prefabUrl
            local wrapperObj = Pool.getItemByCreateFun(prefabSign, function ()
                local boomWrapper =GameTools.createWrapper(prefabUrl)
                ---@type GGraph
                local graph = GGraph.New()
                graph:SetNativeObject(boomWrapper)
                
                local wrapperObj = {}
                wrapperObj.obj = boomWrapper
                return wrapperObj
            end, self)

            local boomWrapper = wrapperObj.obj
            list[i].visible = true
            boomWrapper.visible = true
            local graph = boomWrapper.gOwner
            graph.x = list[i].x
            graph.y = list[i].y
            list[i].parent:AddChild(graph)
            GameTimer.once(800, self, function ()
                boomWrapper.visible = false
                Pool.recover(prefabSign, wrapperObj)
            end)
        end)
    end
end

function AnKangYuAwake:hideBoom(list)
    for i = 1, 8 do
        list[i].visible = false
    end
end

function AnKangYuAwake:initData(stage, endStage, award)
    --self.stage = stage
    self.endStage = endStage
    self.stageAward = award
end

function AnKangYuAwake:getComeBackData(stage)
    if stage == 0 then
        return
    end
    self.stage = stage + 1
    self.countFt.text = self.stage
    self:initBoomAni(true)
    self.PointAni1:Stop()
    self.PointAni2:Stop()
    self:isLastPlayEffect()
end

function AnKangYuAwake:sendMsg()
    local curCount = AnKangYuAwakeC.instance:getStageCount(self.uid)
    local fishes, removeFishes= self:getCatchFishes(curCount)
    AnKangYuAwakeC.instance:sendMsg(self.uid, fishes, self.stage, removeFishes)
end

---play顺序：1.StartAni 球旋转 -> 2.MoveAni 移动到屏幕中央 -> 3.ReadyAni 等待蓄力动画 (球消失光出现）
---      -> 4.PointAni1 爆炸  -> 5.PointAni2 爆炸 -> 6.WaitReadyAni 蓄力动画（球出现光消失）
---      -> 7. 若为最后一次AlphaAni 否则处12外循环
function AnKangYuAwake:play()

    self:hideBoom(self.BoomGraph_1)
    self:hideBoom(self.BoomGraph_2)

    self:refreshCountNum()
    self.StartAni:SetValue("startPos", self.startPos.x, self.startPos.y)
    self.StartAni:Play()
    GameTimer.once(1000, self, function()
        self.n3.visible = true
        self.n18.visible = true
        self.MoveAni:SetValue("startPos", self.startPos.x, self.startPos.y)
        self.MoveAni:Play(function()
            self:MoveAniCallBack()
        end)
    end)
end

function AnKangYuAwake:refreshCountNum()
    self.stage = self.stage + 1
    if self.stage <= self.endStage then
        self.countFt.text = self.stage
    end
    self.ScaleAni:Play()
end

function AnKangYuAwake:MoveAniCallBack()
    if not self.n3.visible then
        return
    end
    self.BackgroundGraph.visible = true
    GameTimer.once(1500, self, function()
        self.ReadyAni:Play(function()
            self:playEffect()
        end)
    end)

end

function AnKangYuAwake:playEffect()
    if not self.n3.visible then
        return
    end
    self.boomGraph.visible = true
    for i = 1, 8 do
        self.LinerGraph[i].visible = true
    end

    self:initBoomAni(true)
    self.PointAni1:Play(function()
        self:initBoomAni(false)
        self:sendMsg()
        self.PointAni2:Play(function()
            self:refreshCountNum()
            self.boomGraph.visible = false
            for i = 1, 8 do
                self.LinerGraph[i].visible = false
                self.LinerGraph[i].position = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
            end
            self:isLastPlayEffect()
        end)
    end)

end

function AnKangYuAwake:getCatchFishes(count)

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

function AnKangYuAwake:isLastPlayEffect()
    if self.stage - 1 >= self.endStage then
        self.AlphaAni:Play(function()
            self:playEnd()
        end)
    else
        self.WaitReadyAni:Play()
        GameTimer.once(2500, self, function()
            self:MoveAniCallBack()
        end)
    end
end

function AnKangYuAwake:playEndScore(score,agentId, out_room)
    if out_room == 1 then
        self:recover()
        return
    end
    if self.seat then
        self.seat.bingoController:startShowNum(BingoType.AnKangYuBoss,nil, nil, score, 3000, 0)
        self.seat.bingoController:bingoEnd(BingoType.AnKangYuBoss,nil, score, self, function ()

            GameTimer.once(2000, self, function ()
                self.seat.isUnableAddCoin = false
            end)
            self.seat.bingoController:resetUi(BingoType.AnKangYuAwake,nil);
            self.seat:bossDeathAddCoin(score,agentId)
            self.seat:bingoEndAutoState()
        end, true)
    end
end

function AnKangYuAwake:playEnd()
    self.countBg.alpha = 1
    self.countFt.alpha = 1
    self.n3.visible = false
    self.BackgroundGraph.visible = false
    self.iceHockey.visible = false
    self.boomGraph.visible = false
    self.LinerGraph.visible = false
    self.countFt.text = 1
    self.stage = 0
    self.endStage = 0
    GameTimer.once(3000, self, function()
        self:hideBoom(self.BoomGraph_1)
        self:hideBoom(self.BoomGraph_2)
        self:recover()
    end)
end

function AnKangYuAwake:reset()
    GameTimer.clearTarget(self)
    --self:removeAll()
    self.ankangyuAwake:RemoveFromParent()
    -- self.ankangyuAwake:Dispose()
    AnKangYuAwakeC.instance.awake = nil
    SoundManager.StopEffectByUrl("Music/ankang_boom.wav")
    SoundManager.StopEffectByUrl("Music/ankang_shoot.wav")    
end

function AnKangYuAwake:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function AnKangYuAwake:Destroy()
    AnKangYuAwake.super.Destroy(self)
    self:reset()
    -- ankangyuAwake被Dispose的时候，挂载的粒子也会被清除，要从对象池里移除
    local prefabUrl = "Effects/Hit_Ankangyu"
    local prefabSign = prefabUrl
    Pool.clearBySign(prefabSign)
    self.ankangyuAwake:Dispose()    
end

function AnKangYuAwake:addCoin(score,agent)
    local agentGetInfo = AgentGetInfo.New()
    agentGetInfo.t = FightConst.currency_coin
    agentGetInfo.v = score
    agentGetInfo.leftTime = 0
    agentGetInfo.ag = agent
    GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
end








