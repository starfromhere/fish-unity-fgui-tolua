---@class Fish2D
Fish2D = class("Fish2D")
function Fish2D:ctor()

    ---@type FSM
    self.fsm = FSM.New(self)
    self.fishPosition = Vector2.New()
    ---鱼配置信息
    self.fishId = nil
    self.uniId = nil
    ---@type cfg_fish
    self.fishCfg = nil

    ---鱼动画
    ---@type Object
    self.fish3dAni = nil

    --- 锁定组
    self.groupLock = nil

    ---@type AnimalManger
    self.fishAni = nil
    self.parent = nil
    ---@type GComponent
    self.fishWrapper = GComponent.New()
    ---@type GComponent
    self.fishAniComponent = nil
    ---路径
    ---@type BezierPath2D
    self.path = nil
    ---@type PathResult
    self.pathResult = PathResult.New()
    self.fishRunTime = 0

    ---碰撞信息
    self.collisionWidth = 0
    self.collisionHeight = 0
    ---@type CollisionRectangle
    self.collisionRect = nil
    self.isCatch = false

    self.lockPointArr = {}
    ---延迟死亡
    self.delayRemove = false
    ---技能数据
    self.freezeTime = 0

    self.canBoom = false
    ---@type GComponent
    self.boomSprite = nil
    ---@type GTween
    self.boomTween = nil

    self.isBoss = false
    self.startingInfo = { startTick = 0, freezeStartTick = 0, extraTick = 0, delayDieTick = 0 };
    --死亡动画时间
    self.deathAniTime = 0
    --旋风标记
    self.whirlwindSprite = nil;
    --类比2d鱼模型宽高
    self.fishAniW = 0;
    self.ffishAniH = 0;

    self._agentId = nil
    self.iswind = false

    self._designPos = Vector2.New()
    self._curAdaptPos = Vector2.New()
    self.meshPosition = nil
end

function Fish2D:resetInfo()
    self.deathAniTime = 0
    self.iswind = false
    self._agentId = nil
    self.isBoss = false
    self.fishWrapper.alpha = 1
end

---@param path BezierPath2D
function Fish2D:init(fishId, uniId, path, isCatch, startingInfo, offvec, iswind)
    --鱼
    self.iswind = iswind
    self.fishId = fishId
    self.uniId = uniId
    self.isCatch = isCatch
    self.fishCfg = cfg_fish.instance(self.fishId)
    self.isBoss = self.fishCfg.fishType == 2
    self.offvec = FightTools.Vec3_1
    self.offvec = offvec or Vector3.New(0, 0, 0)
    self.deathAniTime = 0
    if self.startingInfo then
        self.startingInfo = startingInfo;
    end
    self.meshFlag = MeshSharing.instance:isMeshFish(self.fishCfg.aniName_down .. "_swim", self.iswind)
    if not self.fishAniComponent then
        self.fishAniComponent = Game.instance.fishPool:GetObject("ui://FishFrames/" .. self.fishCfg.aniName_down)
    end
    -- self.fishAniComponent = Game.instance.fishPool:GetObject("ui://FishFrames/jianzuiyu_down")
    -- UIPackage.CreateObject("FishFrames", self.fishCfg.aniName_down)
    if not self.fishAniComponent then
        Log.error("self.fishCfg.aniName_down", self.fishCfg.aniName_down)
    end
    self.fishAniComponent.visible = true
    self.fishAniComponent.position = self.offvec
    if self.fishWrapper.numChildren == 0 then
        self.fishWrapper:AddChild(self.fishAniComponent)
    end
    self.lockPointArr = {}
    if #self.fishCfg.lock_point > 0 then
        self.lockPointArr = string.split(self.fishCfg.lock_point, ",")
    end
    -- if self.fishCfg.is3d > 0 then
    if self.fishAniComponent:GetChild("ani") then
        self.fishAniComponent:GetChild("ani").visible = false
    end
    if self.fishAniComponent:GetChild("shadow") then
        self.fishAniComponent:GetChild("shadow").visible = false
    end
    if not self.fish3dAni then
        ---- 对象池
        local shape = self.fishAniComponent:GetChild("3dbox").shape
        if not (shape == nil) then
            self:create3DAni()
        else
            ---@type GoWrapper
            self.wrapper = self.fishAniComponent:GetChild("3dbox").displayObject
            self.fish3dAni = self.wrapper.wrapTarget
            self.fish3dAni.transform.localPosition = Vector3.New(0, 0, self.fish3dAni.transform.localPosition.z)
            self.fishOriRot = self.fish3dAni.transform:GetChild(0).transform.localRotation
            ---@type  Animator
            self.animator = self.fish3dAni.transform:GetChild(0).gameObject:GetComponent("Animator")
            self.swimDuration = Arthas.Tools.GetClipLength(self.animator, "swim")
            self.animator.speed = 1
            self.animator:Play("swim")
            local graph = self.fishAniComponent:GetChild("3dbox")
            self.fishAniW = graph.width;
            self.fishAniH = graph.height;
        end
    end
    if self.meshFlag == 2 then
        MeshSharing.instance:addFish(self.fish3dAni.transform:GetChild(0).transform:Find("fishBody"), self.fishCfg.aniName_down .. "_swim")
        self.fish3dAni.transform:GetChild(0).transform.localPosition = self.fish3dAni.transform:GetChild(0).transform.localPosition:Add(self.offvec)
    end
    self.meshPosition = Vector3.New(0, 0, self.fish3dAni.transform.localPosition.z + 1300 + math.random(0, 50))

    self.fish3dAni.transform.localPosition = self.meshPosition
    self.fish3dAni:SetActive(true)

    if self.fishCfg.fishname ~= "zhangyu" then
        self.fish3dAni.transform.localScale = Vector3.New(1, 1, 1):Mul(self.fishCfg.scale_down)
        if self.wrapper then
            self.wrapper:CacheRenderers()
        end
    end
    -- else
    --     self:create2DAni()
    -- end
    -- self.fishAni = AnimalManger.createByAni(self.fishAniComponent:GetChild("ani"))

    --初始化碰撞块
    self.collider = self.fishAniComponent:GetChild("collider")
    self.collider:SetScale(self.fishCfg.scale_down, self.fishCfg.scale_down)
    self.collider.visible = false
    self.fishAniW = self.collider.width;
    self.fishAniH = self.collider.height;
    if FightContext.instance.drawCollisionRect then
        self.collider.visible = true
    end
    self.collisionWidth = self.collider.width * self.fishCfg.scale_down
    self.collisionHeight = self.collider.height * self.fishCfg.scale_down
    if not self.collisionRect then
        self.collisionRect = CollisionRectangle.New(self.collisionWidth, self.collisionHeight)
    end

    self.fishWrapper.visible = false
    self.directionFlag = GameConst.fish_from_left
    self.isWhirlwind = false
    -- self.fishAniComponent:GetChild("collider"):SetScale(self.fishCfg.scale_down, self.fishCfg.scale_down)
    -- self.fishAni:setScale(self.fishCfg.scale_down, self.fishCfg.scale_down)

    --路径
    self.fishRunTime = 0
    self.runOver = false;
    self.path = path
    if self.fish3dAni then
        -- self.fish3dAni.transform.localPosition = self.fish3dAni.transform.localPosition:Add(Vector3.New(0, 0, self.path.depth))
    end
    -- 章鱼触手镜像特殊处理,不镜像
    if self.fishCfg.fishname == "zhangyu" then
        self.path.needMirror = false
    end
    self.canBoom = self.fishCfg.boom == 1
    self.fsm:changeState(StateFishRunning)
    if Fishery.instance.fsm:isInState(StateFisheryBoom) then
        self:showBoomFlag()
    end

    self:syncOnlineData()

    self.deathAniTime = 0;
    if self.fishAni then
        self.fishAni.ani.alpha = 1;
        if self.fishShadow then
            self.fishShadow.ani.frame = self.fishAni.ani.frame
        end
    end

    self.groupLock = self.fishCfg.group_lock
    --Rotate
end

function Fish2D:syncOnlineData()
    if self.startingInfo == nil then
        return
    end

    local createTick = self.startingInfo.startTick; --鱼的创建时间
    local runTick = FisheryTick.instance:getRunTick(createTick);

    local freezeStartTick = self.startingInfo.freezeStartTick;

    local extraMaxTick = self.startingInfo.extraTick;
    local _delayDie = self.startingInfo.delayDieTick; --为了产生黑洞做的死亡延迟
    --//冰冻同步
    local freezeLeftTick = FisheryTick.instance:getFreezeLeftTick(freezeStartTick);


    --//同步路径
    local pathRunTick = runTick - extraMaxTick + freezeLeftTick - _delayDie;
    if (pathRunTick <= 0) then
        pathRunTick = 0;

    end

    self.fishRunTime = FightConst.fixed_update_time * pathRunTick;
    self:pathUpdate(0)
end

function Fish2D:create2DAni()
    self.fishAni = AnimalManger.createByAni(self.fishAniComponent:GetChild("ani"))

    local mirrorScaleY = self:getMirrorScaleY()

    self.fishAni:setScale(self.fishCfg.scale_down, self.fishCfg.scale_down * mirrorScaleY)
    self.fishAniW = self.fishAni.ani.width;
    self.fishAniH = self.fishAni.ani.height;
    if self.fishAniComponent:GetChild("shadow") then
        self.fishShadow = AnimalManger.createByAni(self.fishAniComponent:GetChild("shadow")) --self.fishAniComponent:GetChild("shadow")
        --self.fishShadow.scaleX = self.fishCfg.scale_down
        --self.fishShadow.scaleY = self.fishCfg.scale_down * mirrorScaleY
        self.fishShadow:setScale(self.fishCfg.scale_down, self.fishCfg.scale_down * mirrorScaleY)
        self.fishShadow.ani.alpha = 0.6;
        self.fishShadow.ani.frame = 0
        self.fishAni.ani.frame = 0
        self.fishShadow.ani.y = self.fishAni.ani.y + self.fishShadow.ani.height * self.fishCfg.scale_down * mirrorScaleY * 0.4
        self.fishShadow:setVisible(true)
        self.fishShadow.ani.filter = Arthas.Tools.GetColorFilter(0, 0, 0, 1)
        self.fishShadow:resume()
        --self.fishShadow:RemoveFromParent()
        --self.fishShadow:Dispose()
    end

    if not self.fishAni then
        Log.debug("ani not exist", self.fishCfg.aniName_down)
    end
end

function Fish2D:create3DAni()
    local prefabUrl = "Fish/" .. self.fishCfg.aniName_down
    --Log.debug("Fish2D:create3DAni", prefabUrl)
    if self.meshFlag == 2 then
        prefabUrl = "Fish/" .. self.fishCfg.aniName_down .. "_mesh"
    end
    self.fish3dAni = GameTools.ResourcesLoad(prefabUrl)
    self.baselocalPosition = self.fish3dAni.transform.localPosition
    self.basePosition = self.fish3dAni.transform:GetChild(0).transform.localPosition

    self.fishOriRot = self.fish3dAni.transform:GetChild(0).transform.localRotation
    -- = Vector3.New(0, 0, 1500)
    ---@type  Animator
    self.animator = self.fish3dAni.transform:GetChild(0).gameObject:GetComponent("Animator")
    self.swimDuration = Arthas.Tools.GetClipLength(self.animator, "swim")

    --self.animator.speed = 0.5
    local graph = self.fishAniComponent:GetChild("3dbox")
    if self.meshFlag == 0 then
        self.wrapper = GoWrapper.New(self.fish3dAni)
        graph:SetNativeObject(self.wrapper)
    end
    self.fishAniW = graph.width;
    self.fishAniH = graph.height;
    if not self.fish3dAni then
        Log.debug("ani not exist", self.fishCfg.aniName_down)
    end
end

function Fish2D:freezeIn()
    if self.fishAni then
        self.fishAni:pause()
        if self.fishShadow then
            self.fishShadow:pause()
        end
    elseif self.fish3dAni then
        self.lastSpeed = self.animator.speed
        self.animator.speed = 0
    end
end

function Fish2D:freezeOut()
    if self.fishAni then
        self.fishAni:resume()
        if self.fishShadow then
            self.fishShadow:resume()
        end
    elseif self.fish3dAni then
        self.animator.speed = self.lastSpeed
    end
end

function Fish2D:addToScene(parent)
    self.parent = parent
    self.parent:AddChild(self.fishWrapper)
    -- if self.meshFlag ~= 2 then
    --     self.parent = parent
    --     self.parent:AddChild(self.fishWrapper)
    -- else
    if self.meshFlag == 2 then
        self.fish3dAni.transform.parent = parent:GetChild("meshLayer").displayObject.wrapTarget.transform
        parent:GetChild("meshLayer").displayObject:CacheRenderers()
        self.fish3dAni.transform.localScale = Vector3.New(1, 1, 1):Mul(self.fishCfg.scale_down)
    end

end

function Fish2D:update(delta)
    self.fsm:update()
end

function Fish2D:pathUpdate(delta)
    --local scaleX = 1
    --if self._fish.scaleX < 0 then
    --    scaleX = -1
    --end
    self.fishRunTime = self.fishRunTime + delta
    self.path:move(self.fishRunTime, self.pathResult)

    if self.path.needMirror then
        local seatMirrorFlag = SeatRouter.instance.myMirrorFlag
        MirrorMapper.mapVec2(self.pathResult.dirVec, self.pathResult.dirVec, seatMirrorFlag)
        MirrorMapper.map2DPoint(self.pathResult.position, self.pathResult.position, seatMirrorFlag)
    end
    local angle = MathTools.vecToAngle(self.pathResult.dirVec.x, self.pathResult.dirVec.y)

    self:specialFishAngle(angle)
    if self.meshFlag == 2 then
        self.fish3dAni.transform.localRotation = Quaternion.Lerp(Quaternion.New(0, 0, 0, 1), Quaternion.Euler(0, 0, -angle), 1);
    end
    self.fishWrapper.rotation = angle
    self:updateCollisionRect(self.pathResult)
    if self.fish3dAni then
        if not is_empty(self.fishCfg.decorate_path) then
            self:updateCollisionRect3D(self.pathResult)
        end
    end

    self:setAniSpeed(delta)
    if self.meshFlag == 2 then
        self.meshPosition.x = self.pathResult.position.x
        self.meshPosition.y = -self.pathResult.position.y
        self.fish3dAni.transform.localPosition = self.meshPosition
    end
    self.fishWrapper:SetPosition(self.pathResult.position.x, self.pathResult.position.y, 1)
    self.fishWrapper:SetPosition(self.pathResult.position.x, self.pathResult.position.y, 1)
    self.fishWrapper.visible = true

    if self.decorate then
        if self.fishCfg.aniName_down == "ankangyu_down" then
            FishLayer.instance:updatePoint(self.decorate.position.x, self.decorate.position.y)
            self.fishPosition = self.fishWrapper.position
        else
            self.fishPosition = self.decorate.position
            -- self.collisionRect:reset(FightTools.TEMP_POINT1, self.pathResult.rotation)
            FightTools.TEMP_POINT1.x = FightTools.TEMP_POINT1.x + self.offvec.x
            FightTools.TEMP_POINT1.y = FightTools.TEMP_POINT1.y + self.offvec.y
            self.collisionRect:reset(FightTools.TEMP_POINT1, self.pathResult.rotation)
        end
    else
        self.fishPosition = self.fishWrapper.position
    end
    if not self.obb then
        self.obb = obb.New(Vector2.New(self.pathResult.position.x, self.pathResult.position.y), Vector2.New(self.collisionRect.width, self.collisionRect.height), self.collisionRect.rotation)
    end
    self.obb:updatePos(self.fishWrapper.position, self.fishWrapper.rotation)

    self:changeFishColor()
end

function Fish2D:setAniSpeed(delta)
    if self.fishCfg.refL > 0 and delta > 0 and self.swimDuration > 0 then
        self._curAdaptPos:Set(self.pathResult.position.x, self.pathResult.position.y)
        self.swimLen = 0
        self.swimLen = Vector2.Distance(self._curAdaptPos, self._designPos);
        if self.swimLen > 0 then
            self.animator.speed = self.swimDuration * self.swimLen / self.fishCfg.refL / delta;
        end
    end
    self._designPos:Set(self.pathResult.position.x, self.pathResult.position.y)
end

function Fish2D:specialFishAngle(angle)
    --章鱼朝向特殊处理
    if self.fishCfg.aniName_down == "zhangyu_down" then
        self.fishAniComponent.rotation = -angle

        if self.fishPosition.x > self.pathResult.position.x then
            if self.directionFlag == GameConst.fish_from_left then
                self.fish3dAni.transform:GetChild(0).transform.localRotation = Quaternion.Euler(180, 180, 200)
            end
            self.directionFlag = GameConst.fish_from_right
        else
            if self.directionFlag == GameConst.fish_from_right then
                self.fish3dAni.transform:GetChild(0).transform.localRotation = Quaternion.Euler(180, 0, 200)
            end
            self.directionFlag = GameConst.fish_from_left
        end
    end

    -- 雷龙
    if self.fishCfg.fishname == "dragonBoss" then

        if self.fishPosition.x > self.pathResult.position.x then
            if self.directionFlag == GameConst.fish_from_left then
                self.fish3dAni.transform:GetChild(0).transform.localRotation = Quaternion.Euler(-1, 85, -135)
            end
            self.directionFlag = GameConst.fish_from_right
        else
            if self.directionFlag == GameConst.fish_from_right then
                self.fish3dAni.transform:GetChild(0).transform.localRotation = Quaternion.Euler(-1, 85, -35)
            end
            self.directionFlag = GameConst.fish_from_left
        end
    end
end

---@param pathResult PathResult @更新碰撞信息
function Fish2D:updateCollisionRect(pathResult)
    FightTools.TEMP_POINT1.x = pathResult.position.x + self.offvec.x
    FightTools.TEMP_POINT1.y = pathResult.position.y + self.offvec.y
    self.collisionRect:reset(FightTools.TEMP_POINT1, pathResult.rotation)
end

function Fish2D:updateCollisionRect3D(pathResult)

    local screenPos = self.wrapper.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:Find(self.fishCfg.decorate_path).position)
    screenPos.y = UnityEngine.Screen.height - screenPos.y;
    local pos = GRoot.inst:GlobalToLocal(Vector2.New(screenPos.x, screenPos.y));
    -- pos =  GRoot.inst:LocalToRoot(Vector2.New(screenPos.x, screenPos.y),GRoot.inst)
    FightTools.TEMP_POINT1.x = pos.x
    FightTools.TEMP_POINT1.y = pos.y
    if not self.decorate then
        self.decorate = GGraph.New()
        -- self.decorate = UIPackage.CreateObject("Fish", "lock").asImage
        self.decorate.pivot = Vector2.New(0.5, 0.5)
        self.decorate.pivotAsAnchor = true
        -- self.decorate.url =  GameTools.transLayaUrl(self.fishCfg.decorate_url)\
        Log.debug(self.fishCfg.decorate_url)
        if not is_empty(self.fishCfg.decorate_url) then
            FishLayer.instance.fishLayer:AddChild(self.decorate)
            local prefabUrl = self.fishCfg.decorate_url
            local item = GameTools.ResourcesLoad(prefabUrl)
            local wrapper = GoWrapper.New(item)
            -- local graph = GGraph.New()
            self.decorate:SetNativeObject(wrapper)
        end
    end

    -- local a = math.rad(self.parent.parent.rotation)
    -- local x1 = (pos.x - self.parent.width/2)*math.cos(a) - (pos.y - self.parent.height/2)*math.sin(a) + self.parent.width/2 ;
    -- local y1 = (pos.y - self.parent.width/2)*math.sin(a) + (pos.y - self.parent.height/2)*math.cos(a) + self.parent.height/2 ;
    -- self.decorate:SetPosition(screenPos.x,screenPos.y,1)
    self.decorate:SetPosition(pos.x, pos.y, 1)

    -- if self.fishCfg.aniName_down == "ankangyu_down" then
    --     FishLayer.instance:updatePoint(pos.x, pos.y)
    -- else
    --     Log.error("fishposiiton",self.fishPosition.x,self.fishPosition.y)
    --     self.fishPosition = self.decorate.position
    --     self.collisionRect:reset(FightTools.TEMP_POINT1, pathResult.rotation)
    -- end
    -- local pos2 = self.collider:RootToLocal(pos,GRoot.inst)
end

---@return Vector3
function Fish2D:screenPoint()
    -- if self.decorate then
    --     return self.decorate.position
    -- else
    --     return self.fishWrapper.position
    -- end
    return self.fishPosition
end

---@return Vector2
function Fish2D:getLockPoint(launchPos)
    if launchPos and #self.lockPointArr > 0 and self.fish3dAni then
        local screenPos
        local pos
        local tempLen = 2000
        local lockIndex = 1
        local wrap2 = FishLayer.instance.fishLayer:GetChild("meshLayer").displayObject
        for i = 1, #self.lockPointArr do
            if string.find(self.lockPointArr[i], "fishBody", 1) then
                if self.meshFlag == 2 then
                    screenPos = wrap2.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:GetChild(0).transform:Find("fishBody").position)
                else
                    screenPos = self.wrapper.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:GetChild(0).transform:Find("fishBody").position)
                end
            else
                if self.meshFlag == 2 then
                    screenPos = wrap2.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:Find(self.lockPointArr[i]).position)
                else
                    screenPos = self.wrapper.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:Find(self.lockPointArr[i]).position)
                end
            end
            screenPos.y = UnityEngine.Screen.height - screenPos.y;
            pos = GRoot.inst:GlobalToLocal(Vector2.New(screenPos.x, screenPos.y));
            if tempLen > math.abs(Vector2.Distance(launchPos, pos)) then
                tempLen = Vector2.Distance(launchPos, pos)
                lockIndex = i
            end
        end
        if string.find(self.lockPointArr[lockIndex], "fishBody", 1) then
            if self.meshFlag == 2 then
                screenPos = wrap2.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:GetChild(0).transform:Find("fishBody").position)
            else
                screenPos = self.wrapper.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:GetChild(0).transform:Find("fishBody").position)
            end
        else
            if self.meshFlag == 2 then
                screenPos = wrap2.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:Find(self.lockPointArr[lockIndex]).position)
            else
                screenPos = self.wrapper.parent:GetRenderCamera():WorldToScreenPoint(self.fish3dAni.transform:Find(self.lockPointArr[lockIndex]).position)
            end
        end
        screenPos.y = UnityEngine.Screen.height - screenPos.y;
        pos = GRoot.inst:GlobalToLocal(Vector2.New(screenPos.x, screenPos.y));
        return pos
    else
        return self.fishPosition
    end
end

function Fish2D:playSwim()
    --TODO playSwim
    --self.animator:Play("swim")
end
function Fish2D:playHit()
    --TODO playHit
    --self.animator:Play("hit")
end

function Fish2D:changeDelayRemove()
    GameTimer.once(1200, self, function()
        self.delayRemove = true
    end)
end
function Fish2D:playDeath()
    --TODO playDeath
    self:hideWhirlwindFlag()
    if self.fishCfg.catch_show == nil or self.fishCfg.catch_show < 1 then
        -- if self.fishAni then
        --     GTween.To(self.fishAni.ani.alpha, 0, 2):OnUpdate(
        --             function(tweener)
        --                 self.fishAni.ani.alpha = tweener.value.x;
        --                 if tweener.value.x <= 0 then
        --                     self.deathAniTime = 1;
        --                 end
        --             end
        --     )
        -- else
        if self.fish3dAni and (self.fishCfg.ctype >= FightConst.fish_catch_type_boss_awake
                and self.fishCfg.ctype <= FightConst.fish_catch_type_boss_max_awake and self.fishCfg.ctype ~= FightConst.fish_catch_type_leishenchui_awake) then

            Log.error("play shake")
            self.animator.speed = 0
            self.gtweener = GTween.Shake(self.fishWrapper.position, 5, 2):OnUpdate(
                    function(tweener)
                        self.fishWrapper.position = tweener.value.vec3
                        -- self.fish3dAni.transform.position = tweener.value.vec3
                    end
            )                     :OnComplete(function()
                local bossDeathAni = SpecialEffect.new()
                bossDeathAni:playBossDeathAni(self, self.fishCfg.bingoType)
                self.deathAniTime = 1;
            end)                  :SetTarget(self.fishWrapper)

            if self.fishCfg.ctype ~= FightConst.fish_catch_type_leishenchui_awake then
                SoundManager.PlayEffect("Music/" .. self.fishCfg.fishname .. "_death.mp3")
            end
        elseif self.fish3dAni and self.fishCfg.ctype == FightConst.fish_catch_type_award_change then
            local seat = SeatRouter.instance:getSeatByAgent(self:agentId())
            if seat then
                local x = seat.cannonPosition.x
                local y = seat.cannonPosition.y

                local targetPos
                local beginPos

                if Fishery.instance.XZFishNowType == 1 and not seat.bingoController:isBingoPlaying() then
                    targetPos = Vector3.New(x, y, 0)
                else
                    if seat.showSeatId == 1 or seat.showSeatId == 2 then
                        targetPos = Vector3.New(x, y - 100, 0)
                    else
                        targetPos = Vector3.New(x, y + 100, 0)
                    end
                end
                if self.meshFlag == 2 then
                    MeshSharing.instance:changeDeath(self.fish3dAni.transform:GetChild(0).transform:Find("fishBody"), self.fishCfg.aniName_down .. "_death")
                    targetPos.y = -targetPos.y
                    targetPos.z = self.fish3dAni.transform.localPosition.z
                    beginPos = Vector3.New(self.fish3dAni.transform.localPosition.x, self.fish3dAni.transform.localPosition.y, self.fish3dAni.transform.localPosition.z)
                else
                    self.animator:Play("death")
                    beginPos = self.fishWrapper.position
                end

                self.gtweener = GTween.To(beginPos, targetPos, 4.2):OnUpdate(
                        function(tweener)
                            if self.meshFlag == 2 then
                                self.fish3dAni.transform.localPosition = tweener.value.vec3
                            else
                                self.fishWrapper.position = tweener.value.vec3
                            end
                        end
                )                     :OnComplete(function()
                    self.deathAniTime = 1;
                end)
            else
                self.deathAniTime = 1;
            end
        else

            self.fishWrapper:TweenFade(0, 1.5):OnComplete(function()
            end)

            local randomRotate = self.fishWrapper.rotation + (math.random(90, 180))
            local pos = self.fishWrapper.position
            if self.meshFlag == 2 then
                pos = self.fish3dAni.transform.localPosition
            end

            self.fishWrapper:TweenRotate(randomRotate, 1.6):OnComplete(function()
                self.deathAniTime = 1
            end):OnUpdate(
                    function(tweener)
                        if self.meshFlag == 2 then
                            self.fish3dAni.transform.localRotation = Quaternion.Lerp(Quaternion.New(0, 0, 0, 1), Quaternion.Euler(0, 0, -tweener.value.x), 1);
                        end
                    end
            )

            --特殊处理--海龟死亡时停止游动动画
            if self.fishCfg.aniName_down == "haigui_down" and self.fish3dAni then
                self.animator.speed = 0
            end
        end
    end

end

function Fish2D:getDeathAniTime()
    if self.fishCfg.catch_show > 0 then
        return 1;
    end
    return self.deathAniTime;
end

function Fish2D:playAttack()
    self.animator:Play("eyu_swim03")
    GameTimer.once(1000, self, function()
        SoundManager.PlayEffect("Music/eyu_attack.wav")
    end)
end

function Fish2D:changeOut()
    self.fishWrapper:TweenFade(0, 1)
    GameTimer.once(1100, self, function()
        self.fsm:changeState(StateFishStop)
        Fishery.instance:removeFish(self)
    end)
end

function Fish2D:destroy()
    GTween.Kill(self.fishWrapper)
    if self.boomSprite then
        self.boomSprite.visible = false
    end
    if self.gtweener then
        self.gtweener:Kill()
        self.gtweener = nil
    end
    if self.windTimer then
        self.windTimer:clear()
    end

    if self.fishShadow then
        self.fishShadow:pause()
        self.fishShadow:setVisible(false)
    end
    if self.fish3dAni then

        if self.fishCfg.aniName_down == "zhangyu_down" then
            self.fish3dAni.transform.localRotation = Quaternion.Euler(0, 0, 0)
        end
        if self.fishOriRot then
            self.fish3dAni.transform:GetChild(0).transform.localRotation = self.fishOriRot
        end
        if self.decorate then
            self.decorate:RemoveFromParent()
            self.decorate:Dispose()
            self.decorate = nil
        end
        if self.fishCfg.aniName_down == "ankangyu_down" then
            FishLayer.instance:updatePoint(-1000, 0)
        end


        -- if self.meshFlag == 2 then
        --     self.fish3dAni:SetActive(false)
        --     UnityEngine.GameObject.Destroy(self.fish3dAni)
        --     self.fish3dAni = nil
        -- end
        self.animator.speed = 1
        if self.meshFlag ~= 2 then
            self.animator:Play("swim")
        end
        self.fish3dAni:SetActive(false)

        if self.basePosition then
            self.fish3dAni.transform:GetChild(0).transform.localPosition = self.basePosition
        end
        if self.baselocalPosition then
            self.fish3dAni.transform.localPosition = self.baselocalPosition
        end

    end
    self.fishAniComponent.rotation = 0
    self.fishAniComponent.visible = false
    self:hideWhirlwindFlag()
    -- Game.instance.fishPool:ReturnObject(self.fishAniComponent)
    self.fishWrapper:RemoveFromParent()
    -- self.fishWrapper:Dispose()
    if self.iswind then
        self:dispose()
    else
        self:resetInfo()
        FishFactory.instance:returnFish(self.fishCfg, self)
    end
end

function Fish2D:dispose()
    if self.fish3dAni then
        if self.decorate then
            self.decorate:RemoveFromParent()
            self.decorate:Dispose()
            self.decorate = nil
        end

        UnityEngine.GameObject.Destroy(self.fish3dAni)
        self.fish3dAni = nil
    end

    self.fishWrapper:RemoveFromParent()
    self.fishWrapper:Dispose()
end

function Fish2D:agentId(value)
    if nil == value then
        return self._agentId
    else
        self._agentId = value
    end
end

function Fish2D:isValid()
    return self.fsm:isNotInStates({ StateFishStop, StateFishDead })
end

function Fish2D:pointCollisionDetect(x, y)
    if self.isCatch then
        return false
    end
    FightTools.TEMP_POINT1.x = x
    FightTools.TEMP_POINT1.y = y
    return self.collisionRect:contains(FightTools.TEMP_POINT1)
end

function Fish2D:rectCollisionDetect(rect)
    if self.isCatch then
        return false
    end
    local fishRect = CollisionRect.create(self.pathResult.position.x, self.pathResult.position.y, self.collisionRect.width, self.collisionRect.height, self.collisionRect.rotation)
    return CollisionRect:OBBrectRectIntersect(rect, fishRect)
end

function Fish2D:obbCollision(o1)
    if self.isCatch then
        return false
    end
    if not self:isInScreen() then
        return false
    end
    -- Log.error(self.pathResult.position.x, self.pathResult.position.y)
    -- local o2 = obb.New(Vector2.New(self.pathResult.position.x, self.pathResult.position.y),Vector2.New(self.collisionRect.width, self.collisionRect.height),self.collisionRect.rotation)
    return collision:isOBBOverlap(o1, self.obb)
end

function Fish2D:changeToFreezeState(time)
    self.freezeTime = time
    if self.fsm:isNotInStates({ StateFishDead, StateFishStop }) then
        self.fsm:changeState(StateFishFreeze)
    end
end

function Fish2D:changeToDead()
    self.fsm:changeState(StateFishDead)
end
function Fish2D:hideWhirlwindFlag()
    if self.whirlwindSprite then
        self.whirlwindSprite:RemoveFromParent()
        self.whirlwindSprite:Dispose()
    end
end

function Fish2D:showWhirlwindFlag()
    if not self.whirlwindSprite then

        local prefabUrl = "Effects/EffectXuanfengyu/BodyEffect_Xuanfengyu"
        local aniWind = GameTools.ResourcesLoad(prefabUrl)
        local wrapper = GoWrapper.New(aniWind)
        self.whirlwindSprite = GGraph.New()
        self.whirlwindSprite:SetNativeObject(wrapper)
        self.fishWrapper:AddChild(self.whirlwindSprite)
    end
    self:addToScene(FishLayer.instance.boomLayer)
    self.whirlwindSprite.visible = true
    self.whirlwindSprite.position = self.offvec
    if self.fishAniW > 0 and self.fishAniH > 0 then
        local fishW = self.fishAniW * self.fishCfg.scale_down
        local fishH = self.fishAniH * self.fishCfg.scale_down * self:getMirrorScaleY()
        local flagW = 150
        local dif = fishW
        if fishW < fishH then
            dif = fishH
        end
        self.whirlwindSprite.scaleX = dif / flagW
        self.whirlwindSprite.scaleY = dif / flagW
    end
    self.isWhirlwind = true
    --- 锁定
    self.groupLock = FightConst.fish_group_lock_whirlwind


end

local _loopChangeColor = loopChangeColor(191, 191, 34, 3)

function Fish2D:changeFishColor()
    if self.fish3dAni and self.isWhirlwind then
        if not self.mesh then
            local child = self.fish3dAni.transform:GetChild(0)
            local gobj = child.transform:Find("fishBody")
            if not gobj then
                return
            end
            self.mesh = gobj.transform:GetComponent("SkinnedMeshRenderer")
            if not self.mesh then
                return
            end
            -- self.texture = self.mesh.material:GetTexture("_tex")
            -- self.mesh.material = Resource:loadAssert("Assets/Res/Shaders/ShadowAllphaBlendDepth.shader", ResourceType.shader)
            -- self.mesh.material:SetTexture("_tex", self.texture)
            self.texture = self.mesh.sharedMaterial:GetTexture("_tex")
            self.mesh.sharedMaterial = Resource:loadAssert("Assets/Res/Shaders/ShadowAllphaBlendDepth.shader", ResourceType.shader)
            self.mesh.sharedMaterial:SetTexture("_tex", self.texture)
            self.wrapper:CacheRenderers()
        else
            local r, g, b = _loopChangeColor()
            self.mesh.sharedMaterial:SetFloat("_Brightness", 7.2)
            self.mesh.sharedMaterial:SetFloat("_Saturation", 1)
            self.mesh.sharedMaterial:SetColor("_Main_Color", Color.New(r / 255, g / 255, b / 255, 1))
        end

    end
end

function Fish2D:showBoomFlag()
    if self.canBoom then
        if not self.boomSprite then
            self.boomSprite = UIPackage.CreateObject("Fish", "lockCircle")
            self.boomTween = self.boomSprite:GetTransition("lock")
            self.fishWrapper:AddChild(self.boomSprite)
        end
        self.boomTween:Play()
        self.boomSprite.visible = true

        self:addToScene(FishLayer.instance.boomLayer)
    end
end

function Fish2D:hideBoomFlag()
    if self.boomSprite then
        self.boomSprite.visible = false
    end
    if self.fishCfg and self.fishCfg.special_layer and FishLayer.instance.specialLayer[self.fishCfg.special_layer] then
        self:addToScene(FishLayer.instance.specialLayer[self.fishCfg.special_layer])
    else
        self:addToScene(FishLayer.instance.fishLayer)
    end
end

function Fish2D:canBeLock()
    return self.fsm:isInStates({ StateFishRunning, StateFishFreeze, StateFishHit }) and self:isInScreen()
end

function Fish2D:isInScreen()
    return GameScreen.instance:isInScreen(self.fishPosition.x, self.fishPosition.y)
end

function Fish2D:getMirrorScaleY()
    local pathMirror = 0
    local pathScaleY = 1
    local seatScaleY = 1
    local rotationScaleY = 1
    local seatMirrorFlag = SeatRouter.instance.myMirrorFlag
    local isMirrorX = MirrorMapper.getMirrorXByFlag(seatMirrorFlag)
    local isMirrorY = MirrorMapper.getMirrorYByFlag(seatMirrorFlag)
    if isMirrorX and isMirrorY then
        if 1 == pathMirror then
            pathScaleY = -1
        else
            pathScaleY = 1
        end
    elseif isMirrorX or isMirrorY then
        if 1 == pathMirror then
            pathScaleY = 1
        else
            pathScaleY = -1
        end
    else
        if 1 == pathMirror then
            pathScaleY = -1
        else
            pathScaleY = 1
        end
    end
    if isMirrorY then
        seatScaleY = -1
    end
    local angle = self.fishWrapper.rotation
    if angle >= 90 and angle <= 270 then
        rotationScaleY = -1
    else
        rotationScaleY = 1
    end
    -- Log.debug("fish seatMirrorFlag is: ", seatMirrorFlag)
    -- Log.debug("fish pathScaleY is: ", pathScaleY)
    -- Log.debug("fish seatScaleY is: ", seatScaleY)
    -- Log.debug("fish rotationScaleY is: ", rotationScaleY)
    return pathScaleY * seatScaleY * rotationScaleY
end
