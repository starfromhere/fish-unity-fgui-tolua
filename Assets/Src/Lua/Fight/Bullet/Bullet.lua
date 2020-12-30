---@class Bullet
Bullet = class("Bullet")
function Bullet:ctor()
    ---子弹信息
    self.adaptStartPoint = Vector2.New()
    self.adaptEndPoint = Vector2.New()
    self.uid = nil
    self.seat = nil
    self.hitCount = nil
    ---@type ShootContext
    self.context = nil
    self.agentId = nil

    ---@type FSM
    self.fsm = FSM.New(self)

    ---@type GComponent
    self.bulletWrapper = nil
    --self.bulletWrapper.pivot = Vector2.New(0.5, 0.5)
    --self.bulletWrapper.pivotAsAnchor = true
    --子弹的挂载点    
    ---@type GComponent
    self.rootSp = GComponent.New()
    self.rootSp.pivot = Vector2.New(0.5, 0.5)
    self.rootSp.pivotAsAnchor = true
    --跟随子弹移动特效的挂载点    
    ---@type GComponent
    self.effectSp = GComponent.New()
    self.effectSp.pivot = Vector2.New(0.5, 0.5)
    self.effectSp.pivotAsAnchor = true
    --固定位置特效的挂载点    
    ---@type GComponent
    self.fixPosEffectSp = GComponent.New()
    self.fixPosEffectSp.pivot = Vector2.New(0.5, 0.5)
    self.fixPosEffectSp.pivotAsAnchor = true

    --bullet移动状态
    self.nextFramePos = Vector2.New()
    self.frameDeltaX = 0
    self.frameDeltaY = 0
    self.dirVec = Vector2.New(0, 0)

    --碰撞信息
    ---@type Fish2D
    self.hitFish = nil
    self.hitFishesIds = {}

    self.lockFishUid = nil

    --self.intervalTime = 0;
    ---@type GameTimer
    self.ringTimer = nil
end
function Bullet:reflect()
    if not GameScreen.instance:isXInScreen(self.nextFramePos.x) then
        self.dirVec.x = -self.dirVec.x
        self:onChangeDirVec()
    end
    if not GameScreen.instance:isYInScreen(self.nextFramePos.y) then
        self.dirVec.y = -self.dirVec.y
        self:onChangeDirVec()
    end
end

function Bullet:calcNextFramePos()
    self.nextFramePos.x = self.rootSp.x + self.frameDeltaX * Time.deltaTime
    self.nextFramePos.y = self.rootSp.y + self.frameDeltaY * Time.deltaTime
end

---@param shootContext ShootContext
function Bullet:init(shootContext)
    self.uid = shootContext.uid
    self.skinCfg = cfg_battery_skin.instance(shootContext.skinId)
    self.adaptStartPoint = shootContext.adaptStartPoint:Clone()
    self.adaptEndPoint = shootContext.adaptEndPoint:Clone()

    self.hitCount = shootContext.hitCount

    --配表速度为1280 * 720的配置，这里适配1920 * 1080
    self.speed = self.skinCfg.speed_down * 1.5
    self.agentId = shootContext.agentId
    -- 子弹速度在不同分辨率下的适配
    FightTools.TEMP_POINT1.x = self.speed
    FightTools.TEMP_POINT1.y = self.speed
    GameScreen.instance:designToAdapt(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1)
    self.speedX = FightTools.TEMP_POINT1.x
    self.speedY = FightTools.TEMP_POINT1.y

    self.bulletWrapper = Game.instance.fishPool:GetObject("ui://BulletsFrames/" .. self.skinCfg.name_down)
    -- UIPackage.CreateObject("BulletsFrames", self.skinCfg.name_down)
    self.bulletWrapper.pivot = Vector2.New(0.5, 0.5)
    self.bulletWrapper.pivotAsAnchor = true
    self.rootSp.x = self.adaptStartPoint.x
    self.rootSp.y = self.adaptStartPoint.y
    self.rootSp.visible = false
    self.rootSp:AddChild(self.bulletWrapper)
    self.rootSp:AddChild(self.effectSp)
    self.fixPosEffectSp.visible = false

    self.hitFishesIds = {}
    self.frameDeltaX = 0
    self.frameDeltaY = 0

    self.seat = SeatRouter.instance:getSeatById(shootContext.seatId)
    if self.seat.lockFish then
        self.lockFishUid = self.seat.lockFish.uniId
    end
    --子弹初始位置、方向
    self.dirVec.x = self.adaptEndPoint.x - self.adaptStartPoint.x
    self.dirVec.y = self.adaptEndPoint.y - self.adaptStartPoint.y
    self.dirVec = Vector2.Normalize(self.dirVec)
    self.rootSp.rotation = MathTools.vecToAngle(self.dirVec.x, self.dirVec.y)
    self:onChangeDirVec()
    local skinId = 0
    if self.skinCfg then
        skinId = self.skinCfg.id
    end
    self:initSpecialBullet(skinId)
    self:addTrail(skinId)
    self:addRingTimer(skinId)
    self:playBullet()
end

function Bullet:initSpecialBullet(skinId)
    if skinId == FightConst.skin_type_jiguangpao then
        if self.bulletWrapper:GetChild("effect") then
            local bullet = GameTools.createWrapper('Particle/JiGuangPaoBullet')
            self.bulletWrapper:GetChild("effect"):SetNativeObject(bullet)
        end
        -- 其它玩家隐藏发射的倒计时
        if self.seat then
            self.seat:onAutoShootTimerEnd()
            self.seat.rangeState = 2
        end        
    elseif skinId == FightConst.skin_type_zuantoupao then    
        -- 其它玩家隐藏发射的倒计时
        if self.seat then
            self.seat:onAutoShootTimerEnd()
            self.seat.rangeState = 2
        end        
    end
end

function Bullet:playBullet()
    if self.bulletWrapper:GetTransition("play") then
        SoundManager.PlayEffect("Music/jiguangpao_fs.wav")
        GameTools.fullScreenAllUIShake(10, 2)
        -- GameTimer.once(1000, self, function()
        --     self.fsm._currentState:bullet(self)
        -- end)
        self.bulletWrapper:GetTransition("play"):Play(function()
            -- self.fsm._currentState:bullet(self)
                self.fsm:changeState(StateBulletHit)
        end)
    end
end

function Bullet:lerpLookAt(x, y, angSpeed)
    local fromRotation = self.rootSp.rotation
    local targetRotation = MathTools.vecToAngle(x - self.rootSp.x, y - self.rootSp.y)

    angSpeed = angSpeed * Mathf.Sign(targetRotation - fromRotation)

    local offsetAngle = angSpeed * Time.deltaTime
    offsetAngle = Mathf.Clamp(offsetAngle, -Mathf.Abs(targetRotation - fromRotation), Mathf.Abs(targetRotation - fromRotation))
    local zAxis = Vector3.New(0, 0, 1)
    FightTools.Vec3_1:Set(self.dirVec.x, self.dirVec.y, 0)

    local vec1 = Quaternion.AngleAxis(offsetAngle, zAxis) * FightTools.Vec3_1
    self.dirVec.x = vec1.x
    self.dirVec.y = vec1.y
    self.dirVec = Vector2.Normalize(self.dirVec)

    self.frameDeltaX = self.dirVec.x * self.speedX
    self.frameDeltaY = self.dirVec.y * self.speedY
    self.rootSp.rotation = MathTools.vecToAngle(self.dirVec.x, self.dirVec.y)
end

function Bullet:lookAt(x, y)
    self.dirVec.x = x - self.rootSp.x
    self.dirVec.y = y - self.rootSp.y
    self.dirVec = Vector2.Normalize(self.dirVec)
    self:onChangeDirVec()
end

function Bullet:addRingTimer(skinId)
    self:addRing(skinId)
    if not self.ringTimer then
        self.ringTimer = GameTimer.loop(200, self, self.addRing, { skinId })
    end
end

function Bullet:clearRingTimer()
    if self.ringTimer then
        self.ringTimer:clear()
    end
end

function Bullet:addTrail(skinId)
    -- 钻头炮的拖尾
    if FightConst.skin_type_zuantoupao == skinId then
        local prefabUrl = 'Particle/Trail_Zuantoupao'
        local spineItem = GameTools.ResourcesLoad(prefabUrl)

        ---@type GoWrapper
        local wrapper = GoWrapper.New(spineItem)
        ---@type GGraph
        local graph = self.bulletWrapper:GetChild("trailGraph")-- GGraph.New()
        graph:SetNativeObject(wrapper)
        -- graph.x = -200
        -- self.effectSp:AddChild(graph)
    end
end

function Bullet:addRing(skinId)
    if FightConst.skin_type_zuantoupao == skinId then
        local prefabUrl = 'Particle/Hit_Zuantoupao'
        local prefabSign = prefabUrl
        local wrapperObj = Pool.getItemByCreateFun(prefabSign, function()
            local spineItem = GameTools.ResourcesLoad(prefabUrl)
            ---@type GoWrapper
            local wrapper = GoWrapper.New(spineItem)
            ---@type GGraph
            local graph = GGraph.New()
            graph:SetNativeObject(wrapper)

            local wrapperObj = {}
            wrapperObj.obj = wrapper
            return wrapperObj
        end, self)
        local wrapper = wrapperObj.obj
        wrapper.visible = true
        ---@type GGraph
        local graph = wrapper.gOwner
        graph.x = self.rootSp.x
        graph.y = self.rootSp.y
        self.fixPosEffectSp:AddChild(graph)
        -- 粒子播放完成后就移除粒子
        GameTimer.once(800, self, function ()
            graph:RemoveFromParent()
            -- wrapper:RemoveFromParent()
            -- wrapper:Dispose()            
            wrapper.visible = false
            Pool.recover(prefabSign, wrapperObj)
        end)
    end
end

function Bullet:addBurst(skinId)
    if FightConst.skin_type_zuantoupao == skinId then
    end
end

---@param parent GComponent
function Bullet:addToScene(parent)
    parent:AddChild(self.rootSp)
    parent:AddChild(self.fixPosEffectSp)
    self.rootSp.visible = true
    self.fixPosEffectSp.visible = true
    self.fsm:changeState(StateBulletMove)
end
--
-----@param context BulletContext
--function Bullet:init(context)
--    Log.debug("Bullet:init", context, context.parent)
--
--    if self.context then
--        self.context = context
--    else
--        self.context = context
--        self.bullet = GLoader.New()
--        self.bullet.url = "ui://Fish/bullet_1_1"
--        self.context.parent:AddChild(self.bullet)
--    end
--    self.hitFishesIds = {}
--    --self.bullet.visible = true
--    self:adaptScreen()
--    if self.context:isLockBullet() then
--        self.fsm:changeState(StateLockBulletMove)
--    else
--        self.fsm:changeState(StateBulletMove)
--    end
--    self:onChangeDirVec()
--    if self.context.lockFishUid > 0 then
--        self.lockFishPoint = Vector2.New(0, 0)
--        local fish = Fishery.instance:findFishByUniId(self.context.lockFishUid)
--        if fish then
--            self.lockFishPoint.x = fish.screenPoint.x
--            self.lockFishPoint.y = fish.screenPoint.y
--        end
--    end
--    self.seat = SeatRouter.instance:getSeatById(self.context.seatId)
--end
function Bullet:update(delta)
    self.fsm:update()
end

---@param fish Fish2D
function Bullet:hit(fish)
    if self:isHitFish(fish.uniId) then
        self.seat.laserLock = false 
        return
    end
    if self.seat:isMySeat() then
        CmdGateOut:bulletHitFish(self.uid, fish.uniId)
    elseif self.agentId and self.agentId < 0 then
        -- TODO 机器人打中的鱼也需要客户端发送消息,暂时用agent < 0来判断是机器人
        CmdGateOut:bulletHitFish(self.uid, fish.uniId)
    end
    self:addHitFish(fish.uniId, fish.fishId)
    self.hitFish = fish

    --self.hitFish.fsm:changeState(StateFishHit)
    self.fsm:changeState(StateBulletHit)
    if FightConst.skin_type_zuantoupao == self.skinCfg.id then
        SoundManager.PlayEffect("Music/zuantoupao_hit2.mp3")
    else
        -- SoundManager.PlayEffect("Music/hit")
    end
end

---@param fish Fish2D
function Bullet:checkHit(fish)
    if self.seat.fsm:isInState(StateSeatLockType) then
        --- 锁定炮闪电击中鱼的声音需要换一下
        self:hit(fish)
        return
    end
    
    self:lerpLookAt(fish.fishWrapper.x, fish.fishWrapper.y, 60)
    local isHit = fish:pointCollisionDetect(self.nextFramePos.x, self.nextFramePos.y)
    if isHit then
        self:hit(fish)
    end
end

function Bullet:hitFishs(fishArr)
    if self.seat:isMySeat() then
        local fishUids = {}
        local exclueFishUids = {}
        for _, fish in pairs(fishArr) do
            self:addHitFish(fish.uniId, fish.fishId)
            if (fish and fish.fishCfg and fish.fishCfg.canRemove == 1) then
                table.insert(exclueFishUids, fish.uniId)
            else
                table.insert(fishUids, fish.uniId)
            end
        end
        local dType = FightConst.fish_death_type_none
        local skinId = self.skinCfg.id
        if FightConst.skin_type_zuantoupao == skinId then
            dType = FightConst.fish_death_type_drill_cannon
        elseif FightConst.skin_type_jiguangpao == skinId then
            dType = FightConst.fish_death_type_laser_cannon
        end
        CmdGateOut:bulletHitFishs(self.uid, fishUids, exclueFishUids, dType)
    end
end

function Bullet:pos(x, y)
    self.rootSp.x = x
    self.rootSp.y = y
end

function Bullet:onChangeDirVec()
    self.rootSp.rotation = MathTools.vecToAngle(self.dirVec.x, self.dirVec.y)

    self.frameDeltaX = self.dirVec.x * self.speedX
    self.frameDeltaY = self.dirVec.y * self.speedY
end

function Bullet:rmvEffects(isDestroyed)
    self.effectSp:RemoveChildren(0, -1, true)
    if isDestroyed then
        self.effectSp:RemoveFromParent()
        self.effectSp:Dispose()
    end
end

function Bullet:rmvFixPosEffects(isDestroyed)
    self.fixPosEffectSp:RemoveChildren(0, -1, false)
    if isDestroyed then
        self.fixPosEffectSp:RemoveFromParent()
        self.fixPosEffectSp:Dispose()
    end
end

function Bullet:destroyBullet()
    self.bulletWrapper:RemoveFromParent()
    Game.instance.fishPool:ReturnObject(self.bulletWrapper)
    -- self.bulletWrapper:Dispose()
end

function Bullet:destroy()
    self:destroyBullet()
    self:rmvEffects(true)
    self:clearRingTimer()
    self:rmvFixPosEffects(true)
    self.rootSp:RemoveFromParent()
    self.rootSp:Dispose()
end

function Bullet:addHitFish(fishUid, fishId)
    table.insert(self.hitFishesIds, fishUid)


    --local hitEffect = ConfigManager.getConfValue("cfg_fish", fishId, "hitSound")
    --local EffectPath = ""
    --if hitEffect ~= "" then
    --    EffectPath = string.gsub(hitEffect,".mp3",""):gsub("^%l", string.upper);
    --else
    --    return;
    --end
    --if self.intervalTime == 0 then
    --    SoundManager.PlayEffect(EffectPath)
    --    self.intervalTime = 1
    --    GameTimer.once(3000, self, function ()
    --        self.intervalTime = 0
    --    end);
    --end
end

function Bullet:isHitFish(fishUid)
    return table.exist(self.hitFishesIds, fishUid)
end

function Bullet:isMyBullet()
    return self.seat == SeatRouter.instance.mySeat
end
