---@class ZuantoupaoEffect
---@field New ZuantoupaoEffect
ZuantoupaoEffect = class("ZuantoupaoEffect", EffectBase)
function ZuantoupaoEffect:ctor()
    ZuantoupaoEffect.super.ctor(self)
    --- @type GTextField
    self.numFt = nil
    --- @type Bullet
    self.bullet = nil
    --- @type NumChgEffect
    self.numChgEffect = nil
end

function ZuantoupaoEffect.create(bullet)
    --TODO 使用缓存池
    local item = ZuantoupaoEffect.New()
    ZuantoupaoEffect.super.InitInfo(item)
    item:init(bullet)
    return item
end

function ZuantoupaoEffect:reset()
    local seatId = -1
    if self.bullet and self.bullet.seat and self.bullet.seat.seatId > 0 then
        seatId = self.bullet.seat.seatId
    end
    FightC.instance:changeSkin(seatId)
    -- if self.bullet and self.bullet.seat and self.bullet.seat:isInState(StateSeatRange) then
    --     self.bullet.seat:changeToNormal()
    -- end
    if self.bullet then
        Fishery.instance:removeBullet(self.bullet)
        self.bullet:destroy()
    end
    SoundManager.StopEffectByUrl("Music/zuantoupao_hit1.wav")
    SoundManager.StopEffectByUrl("Music/zuantoupao_boom_ready.wav")
    self:clearTimer()
    local isRecovered = self[Pool.POOLSIGN]
    if not isRecovered then
        ZuantoupaoC.instance:reset()
    end
end

function ZuantoupaoEffect:recover()
    self:reset()
    Pool.recoverByClass(self)
end

function ZuantoupaoEffect:Destroy()
    ZuantoupaoEffect.super.Destroy(self)
    self:reset()
end

function ZuantoupaoEffect:clearTimer()
    GameTimer.clearTarget(self)
end

function ZuantoupaoEffect:init(bullet)
    self.bullet = bullet
end

function ZuantoupaoEffect:onFirstHitNumChg()
    --- 先用基础奖励做表现
    if self.bullet and self.bullet.seat then
        local seat = self.bullet.seat
        local initVal = 0
        local totalVal = self.bullet.skinCfg.base_award_rate * seat._batteryContext:consume()
        local totalTime = self.bullet.skinCfg.catch_count * 500
        seat.bingoController:startShowNum(BingoType.ZuanTouPangXie,nil, initVal, totalVal, totalTime, 0)
    end
end

function ZuantoupaoEffect:onZuantoupaoEffectCompletedNumChg(totalScore)
    if self.bullet and self.bullet.seat then
        local seat = self.bullet.seat
        local initVal = self.bullet.skinCfg.base_award_rate * seat._batteryContext:consume()
        local totalVal = totalScore
        seat.bingoController:startShowNum(BingoType.ZuanTouPangXie,nil, initVal, totalVal, 5000, 0)
    end
end

function ZuantoupaoEffect:playBulletEffect(agentGetInfo)
    SoundManager.StopEffectByUrl("Music/zuantoupao_hit1.wav")
    self.bullet:rmvEffects()
    self.bullet:clearRingTimer()
    local item = UIPackage.CreateObject("Fish", "CannonBurstItem")
    local rotateAni = item:GetTransition("rotateAni")
    local scaleAni = item:GetTransition("scaleAni")
    local loader = item:GetChild("loader")
    -- TODO 测试子弹，临时解决锚点不对的bug
    loader.url = "ui://BulletsFrames/" .. "zidan10_test"--self.skinCfg.name_down
    self.bullet.effectSp:AddChild(item)
    self.bullet:destroyBullet()
    rotateAni:Play()
    scaleAni:Play()
    local resUrl = "Music/zuantoupao_boom_ready.wav"
    SoundManager.PlayEffect(resUrl, true)
    GameTimer.once(3000, self, function()
        SoundManager.StopEffectByUrl(resUrl)
        rotateAni:Stop()
        scaleAni:Stop()
        item:RemoveFromParent()
        item:Dispose()
        local prefabUrl = 'Particle/Burst_Zuantoupao'
        local spineItem = GameTools.ResourcesLoad(prefabUrl)

        ---@type GoWrapper
        local wrapper = GoWrapper.New(spineItem)
        ---@type GGraph
        local graph = GGraph.New()
        graph:SetSize(800, 800)
        graph:SetNativeObject(wrapper)
        self.bullet.effectSp:AddChild(graph)
        self.bullet.fsm:changeState(StateBulletStop)

        local catchFishes = self:getCatchFishes(graph, self.bullet.rootSp.x, self.bullet.rootSp.y)
        local seat = self.bullet.seat
        local bRate = seat._batteryContext:consume()
        local totalVal = self.bullet.skinCfg.base_award_rate * bRate
        local num = 0
        if catchFishes then
            num = #catchFishes
        end
        ZuantoupaoC.instance:setTotalPoint(totalVal, num, bRate)
        --- 自己的表现时上传消息
        if SeatRouter.instance.mySeatId == seat.seatId then
            local agentId = 0
            if seat.seatInfo and seat.seatInfo.agent then
                agentId = seat.seatInfo.agent
            end
            self:endCatchFish(catchFishes, agentId)
        end
        SoundManager.PlayEffect("Music/zuantoupao_boom.wav")
        GameTools.fullScreenShake(10, 1)

        GameTimer.once(3000, self, function()
            graph:RemoveFromParent()
            graph:Dispose()
            self.bullet.seat:onZuantoupaoShowScore(agentGetInfo)
        end)
    end)
end

function ZuantoupaoEffect:getCatchFishes(aniSp, x, y)
    local aniSpWidth = aniSp.width * aniSp.scaleX
    local aniSpHeight = aniSp.height * aniSp.scaleY
    local rotation = aniSp.rotation

    -- 根据适配计算碰撞矩形宽高
    FightTools.TEMP_POINT1.x = aniSpWidth
    FightTools.TEMP_POINT1.y = aniSpHeight
    GameScreen.instance:designToAdapt(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1)
    aniSpWidth = FightTools.TEMP_POINT1.x
    aniSpHeight = FightTools.TEMP_POINT1.y

    local rect = CollisionRect.create(x, y, aniSpWidth, aniSpHeight, rotation)
    local fishes = Fishery.instance:rectCollision(rect)
    local len = 0
    if fishes then
        len = #fishes
    end
    local catchFishes = nil
    if len >= 1 then
        local index = 0
        for _, fish in ipairs(fishes) do
            --- 只有能移除的才移除
            if (fish and fish.fishCfg and fish.fishCfg.canRemove == 1) then
                index = table.indexOf(catchFishes, fish.uniId)
                if (index < 0) then
                    if not catchFishes then
                        catchFishes = {}
                    end
                    table.insert(catchFishes, fish.uniId)
                end
            end
        end
    end
    return catchFishes
end

function ZuantoupaoEffect:endCatchFish(catchFishes, agentId)
    local c2s = C2s_12122.create()
    c2s:init(catchFishes, FightConst.fish_death_type_drill_cannon_boom, true, agentId)
    c2s:sendMsg()
end