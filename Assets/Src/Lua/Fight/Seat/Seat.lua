---@class Seat
Seat = class("Seat")

function Seat:ctor()
    self.seatId = nil

    --镜像标志
    self.mirrorFlag = nil
    --相对自身座位的镜像标志
    self.relativeMirrorFlag = nil
    --展示的座位ID
    self.showSeatId = nil

    --最外层玩家节点
    self.playerComponent = nil
    --玩家金币数、钻石数、名字、人物等级、头像、炮等级
    ---@type GTextField
    self.coinCountText = nil
    --分数挂接点节点
    ---@type GComponent
    self.coinCount3dText = nil
    self.fortLev3dText = nil
    self.coinWrapper = nil
    ---@type GTextField
    self.diamondCountText = nil
    ---@type GTextField
    self.playerNameText = nil
    ---@type GLoader
    self.playerAvatarGloader = nil
    ---@type GLoader
    self.DiamondLoader = nil
    ---@type GLoader
    self.CoinLoader = nil

    self.fortLevel = nil
    self.scoreBg = nil
    self.scoreFont = nil
    self.rateFont = nil

    --等待加入
    self.waitComponent = nil
    --皮肤id
    self.skinId = nil
    self.skinCfg = nil
    self.skinScale = 0.65

    --特殊炮总分数
    self.bingoTotalNum = nil
    --钻头炮效果
    self.zuantoupaoEffect = nil
    --钻头炮计时器
    self.zuantoupaoTimer = nil

    ---@type BingoControl
    self.bingoController = nil

    self.cskin = nil
    --炮等级
    self.battery = nil
    self.batteryCfg = nil
    --炮id
    self.batteryId = nil


    --炮 挂接点节点
    ---@type GComponent
    self.paoMount = nil
    --分数挂接点节点
    ---@type GComponent
    self.scoreMount = nil
    --炮底座
    self.paoDi3d = nil
    self.paoDiTransform=nil
    self.paoDiAnimator = nil
    self.paoDiLeftObject = nil
    self.paoDiRightObject = nil
    --self.bulletClip = nil
    --炮动画
    ---@type SpineManager
    self.batterySpine = nil
    self.battery3dAni = nil
    self.fire = nil
    self.fire_paoshen = nil
    ---@type GGraph
    self.laserBattery = nil
    ---@type GLoader
    self.laserFishImg = nil
    ---@type Object
    self.laser = nil
    ---@type GGraph
    self.laserWrapper = nil
    ---@type GGraph
    self.laserEndPosWrapper = nil
    self.laserLock = false
    self.laserLastImgUrl = ""

    ---@type Animator
    self.battery3dAnimator = nil
    self.wrapper = nil

    self.batterySpineEffect = nil

    ---@type BatteryContext
    self._batteryContext = nil
    self.shootIntervalSecond = 0

    self.shootStartX = 0
    self.shootStartY = 0

    ---@type FSM
    self.fsm = FSM.New(self, StateSeatExit)

    self.bulletNum = 0


    --技能数据
    ---@type table<number,number>
    self.skillInfoMap = {}

    --待使用的炸弹ID
    self.boomSkillId = nil
    ---@type GLoader
    self.boomSprite = nil

    --是否开启自动
    self.isOpenAuto = false

    --锁定的鱼
    ---@type Fish2D
    self.lockFish = nil
    self.lockFishUid = 0
    self.lockFishSid = 0
    self.lockCircle = nil
    self.lockLine = nil
    self.lockLineSpriteNum = 27
    self.lockLineSprites = {}

    --锁定一类鱼的相关参数
    self.lockType = nil

    --鼠标位置
    self.mouseX = nil
    self.mouseY = nil

    --狂暴两个动画
    self.violentPaoTai = nil
    self.violentPaoSheng = nil
    --炮零件
    ---@type GGraph
    self.fortPart = nil
    self.fortPartSpine = nil

    self.minBulletUId = nil
    self.maxBulletUid = nil
    self.curBulletUid = nil

    --比赛信息
    self.contest_coin = 0
    self.contest_score = 0

    ----------***************************--------
    self.paoBaseMount = nil
    self.mapperContext = nil
    self.lockRemainTime = 0

    self.seatInfo = nil
    self.seatViolent = nil
    self.lastLockUid = 0
    self.tipSwich = true

    self.powerBox = nil
    self.proMountGlobalPoint = nil

    self.avatar = nil

    self.isOutsidesCanShoot = true
    self.bContext = nil

    self.isMouseDown = false
    self.isAutoOpen = false

    self.bulletMaxTip = false
    self.coin_rate = 1
    self.chance_rate = 1

    self.autoShootPoint = nil--[TODO] new Point(0,0)


    self.violentTime = 0
    self.skillId = 0
    self.fireRate = 1
    self.seat = nil

    self.globalCoinPosition = nil
    self.globalAvatarPosition = nil

    self.AlreadyText = nil
    self.NoReadyText = nil
    self.WaitGroup = nil
    self.WaitTimeText = nil
    self.RoomHost = nil

    self.rangeState = 0
    --显示金币数量
    self.myCoinCount = 0
    --实际金币数量
    self.myCoinCount2 = 0
    self.isUnableAddCoin = false --是否不能加金币

    self.autoShootItem = nil --钻头炮、激光炮自动发射倒计时组件
    self.autoShootTimeText = nil --钻头炮、激光炮自动发射倒计时
    self.autoShootTimer = nil --钻头炮、激光炮自动发射的计时器
    self.autoShootEndTime = nil --钻头炮、激光炮自动发射倒计时的结束时间戳
    self.AUTO_SHOOT_TIME = 10000 --钻头炮、激光炮自动发射倒计时的总时间

    self.bingoFinalAuto = false

    GameEventDispatch.instance:on(GameEvent.FightCoinUpdate, self, self.updateUserInfo)
end

--初始化座位ID
function Seat:init(seatId)
    self.seatId = seatId
    self.mirrorFlag = MirrorMapper.getMirrorFlagBySeatId(self.seatId)
    self.relativeMirrorFlag = MirrorMapper.getRelativeMirrorFlag(SeatRouter.instance.myMirrorFlag, self.mirrorFlag)
    self.showSeatId = MirrorMapper.getSeatIdByMirrorFlag(self.relativeMirrorFlag)

    Log.debug("Seat:init", self.seatId, self.mirrorFlag, self.relativeMirrorFlag, self.showSeatId)
    self.mapperContext = MirrorContext.New(seatId)

    self.minBulletUId = (seatId - 1) * 200 + 1
    self.maxBulletUid = seatId * 200
    self.curBulletUid = self.minBulletUId



    --self:onChangeBattery(1, 1)
    --self:changeToNormal()
    --GameEventDispatch.instance:on("SystemReset", self, self.gameReset)
    if self.playerComponent then
        self:resetUI()
    end
end

function Seat:resetUI()
    self.scoreBg.url = "ui://Fish/pao_bg" .. self.seatId
    self.bingoController:resetUi();
    self.rangeBox.visible = false
    self:_stopViolent()
    self:showAutoShoot(false)
end

function Seat:getPlayerInfoNode()
    local DetailInfo = self.playerComponent:GetChild("DetailInfo")
    self.diamondCombination = DetailInfo:GetChild("diamond")
    self.coinCountText = DetailInfo:GetChild("CoinNum")
    self.CoinLoader = DetailInfo:GetChild("CoinLoader")
    self.diamondBox = DetailInfo:GetChild("diamond")
    self.DiamondLoader = DetailInfo:GetChild("DiamondLoader")
    self.diamondCountText = DetailInfo:GetChild("DiamondNum")
    self.playerNameText =DetailInfo:GetChild("NameText")
    --self.playerAvatarGloader = DetailInfo:GetChild("Avatar")
    self.fortLevel = self.playerComponent:GetChild("FortLevel")
    self.scoreBg = self.playerComponent:GetChild("scoreBg")
    self.scoreFont = self.playerComponent:GetChild("scoreFont")
    self.rateFont = self.playerComponent:GetChild("rateFont")

    self.AlreadyText = DetailInfo:GetChild("AlreadyText")
    self.NoReadyText = DetailInfo:GetChild("NoReadyText")
    self.WaitGroup = DetailInfo:GetChild("WaitGroup")
    self.WaitTimeText = DetailInfo:GetChild("WaitTimeText")
    self.RoomHost = DetailInfo:GetChild("RoomHost")
    if not self.bingoController then
        self.bingoController = BingoControl.creatBingoControl(self.playerComponent, self.relativeMirrorFlag, self.seatId)
        --self.bingoController = BingoEffect:creatBingo(self.playerComponent)
    end

    self.globalCoinPosition = self.CoinLoader:LocalToRoot(Vector2.zero, GRoot.inst)
    --self.globalAvatarPosition = self.playerAvatarGloader:LocalToRoot(Vector2.zero, GRoot.inst)
    self.cannonPosition = self.playerComponent:GetChild("bingoTitle"):LocalToRoot(Vector2.zero, GRoot.inst)
    self.autoShootItem = self.playerComponent:GetChild("autoShootItem")
    self.autoShootTimeText = self.autoShootItem:GetChild("timeTxt")
end



--初始化挂接点
---@param parent GComponent
---@param waitComponent GComponent
function Seat:assemble(parent, waitComponent)
    self.playerComponent = parent
    self:getPlayerInfoNode()

    --self.waitComponent = waitComponent
    --if waitComponent then
    --    self.waitComponent.visible = true
    --end
    --self.playerComponent.visible = false

    self.paoMount = self.playerComponent:GetChild("battery")
    self.paoMount.rotation = 0
    self.scoreMount = self.playerComponent:GetChild("scoreMount")
    self:create3DScore()
    self:changeSkin(3, true)
    local globalPosition = self.paoMount:LocalToRoot(Vector2.New(0, 0), GRoot.inst)
    self.shootStartX = globalPosition.x
    self.shootStartY = globalPosition.y

    self.fortPart = self.playerComponent:GetChild("FortPart")
    self.PaoDiImg = self.playerComponent:GetChild("PaoDiImg")
    self.PaoDiImg.visible = false;
    self.rangeBox = self.paoMount:GetChild("rangeBox")
    self:setCoin(self.contest_coin)
    self:setFortLev(cfg_battery.instance(1).comsume)

    self:showAutoShoot(false)
    --self.seatViolent = SeatViolent.New()
    --self.seatViolent:init(self)

    --self.powerBox = parent:getChildByName("powerBox")
    --self.powerBox.zOrder = 100
    --self.powerBox:addChild(self.powerFontClip)


    --self:screenResize()
end



--初始化用户数据
---@param seatInfo ProtoSeatInfo
function Seat:initSeatInfo(seatInfo)
    self.seatInfo = seatInfo
    -- 特殊状态进入渔场时,会改变状态机的状态为StateSeatRange,因此需要先调用changeToNormal(),避免被修改状态
    self:changeToNormal()
    self:changeSkin(seatInfo.cskin, true)
    self:changeBattery(seatInfo.battery)
    if not self.lockType then
        self.lockType = seatInfo.group_lock ~= 0 and seatInfo.group_lock or nil
    end
    self.contest_coin = seatInfo.contestCoin
    self.contest_score = seatInfo.contestScore

    self:setFortLev(cfg_battery.instance(seatInfo.battery).comsume)
    if Fishery.instance.isCoinScene then
        --Log.info("金币数值变动initSeatInfo",seatInfo.coin)
        self:setCoin(seatInfo.coin)
        local mySeat = SeatRouter.instance.mySeat;
        self.myCoinCount = seatInfo.coin;
        self.myCoinCount2 = self.myCoinCount
        if self.seatId == mySeat.seatId then
            self.diamondBox.visible = true
            self.diamondCountText.text = RoleInfoM.instance:getDiamond()
            self.myCoinCount = RoleInfoM.instance:getCoin() + RoleInfoM.instance:getBindCoin();
            self.myCoinCount2 = self.myCoinCount
        else
            self.diamondBox.visible = false
        end
    else
        self.diamondBox.visible = true
        self:setCoin(self.contest_coin)
        self.diamondCountText.text = tostring(self.contest_score)
    end
    self.playerNameText.text = seatInfo.name
    self.avatar = seatInfo.avatar or ""

    FightM.instance:setBattery(seatInfo.cskin, seatInfo.battery, seatInfo.seat_id)

    --Log.debug(self.avatar, self.avatar == nil, type(self.avatar))
    --GameTools.loadHeadImage(self.playerAvatarGloader, self.avatar)
    self:initCurrency()
end

function Seat:initCurrency()
    if Fishery.instance.isCoinScene then
        self.CoinLoader.url = "ui://CommonComponent/unit_coin"
        self.DiamondLoader.url = "ui://CommonComponent/unit_diamond"
    end
    if Fishery.instance.isMatchScene then
        self.CoinLoader.url = "ui://CommonComponent/zidan"
        self.DiamondLoader.url = "ui://CommonComponent/jifen"
        self.diamondCombination.visible = true
    end
end

function Seat:updateUserInfo()

    if Fishery.instance.isCoinScene then
        if self.diamondCountText ~= nil then

            local mySeat = SeatRouter.instance.mySeat
            if self.seatId == mySeat.seatId then
                if self.myCoinCount > (RoleInfoM.instance:getCoin() - RuleM.instance:coinCount() + RoleInfoM.instance:getBindCoin()) then
                    --Log.info("金币数值变动updateUserInfo",self.myCoinCount)
                    self:setCoin(self.myCoinCount)
                    self.diamondCountText.text = RoleInfoM.instance:getDiamond();
                end
            else
                --Log.info("金币数值变动updateUserInfo/else",self.myCoinCount)
                self:setCoin(self.myCoinCount)
            end
            --self.fortLevel.text = cfg_battery.instance(seatInfo.battery).comsume
        end
    end
end

--function Seat:_setBatteryInfo(cskin, battery)
--    self._batteryContext = BatteryContext.create(self.cskin, self.battery)
--
--    local position = Vector3.New(0, 0, 1000)
--    self.batterySpine = SpineManager.create(self.batteryContext.aniPath, position, 0.65, self.paoSpineMount)
--    self:_playBatteryStand()
--    self.shootIntervalSecond = 0.2
--end

function Seat:changeBattery(batteryId)
    -- self.battery = batteryId
    self.scoreBg.url = "ui://Fish/pao_bg" .. self.seatId
    self.battery = 1
    self.batteryCfg = cfg_battery.instance(batteryId)
    if not self.batteryCfg then
        Log.debug("不存在的battery", batteryId)
    end
end

function Seat:isLockPao()
    return self.skinId == FightConst.skined_pao_lock
end

function Seat:changeSkin(skinId, isInit)
    if self.skinId ~= skinId then
        self.skinId = skinId
        self.skinCfg = cfg_battery_skin.instance(skinId)
        if not self.skinCfg then
            Log.debug("不存在的皮肤ID", skinId)
            return
        end
        if self.rangeBox then
            if self.lizi then
                self.lizi:Dispose()
                self.lizi = nil
            end
        end
        --每次换皮肤的时候需要把火焰清除
        self.fire = nil
        self.fire_paoshen = nil
        if self.skinCfg.is3d > 0 then
            self:create3DBattery(skinId)
        else
            self:create2DBattery(skinId)
        end

        local isMirror = false;
        if MirrorMapper.getMirrorYByFlag(self.relativeMirrorFlag) then
            self.paoMount.rotation = 180
            isMirror = true;
        end
        if self:isLockPao() then
            self.paoMount.rotation = isMirror and self.paoMount.rotation or 0
            self:dealLockFishImg()
            self.laserFishImg.visible = true
        else
            if self.laserFishImg then
                self.laserFishImg.visible = false
            end
        end
        -- 进入渔场后，如果是initSeatInfo设置的皮肤id,判断为其他玩家的激光炮和钻头炮已经发射，StateSeatRange不再倒计时
        if FightConst.skin_type_zuantoupao == skinId then
            self:changeToRange(skinId, BingoType.ZuanTouPangXie, isInit)
            -- 锁定炮不会改变炮的朝向，使用锁定炮打中钻头炮后，炮的朝向与实际的朝向不一致
            if self.mouseX and self.mouseY then
                self:lookAt(self.mouseX, self.mouseY)
            end
        elseif FightConst.skin_type_jiguangpao == skinId then
            local rand = math.random(1, 3)
            SoundManager.PlayEffect("Music/jiguangpao_hq_" .. rand .. ".wav")
            self:changeToRange(skinId, BingoType.JiGuangPangXie, isInit)
            -- 锁定炮不会改变炮的朝向，使用锁定炮打中激光炮后，炮的朝向与实际的朝向不一致
            if self.mouseX and self.mouseY then
                self:lookAt(self.mouseX, self.mouseY)
            end
        elseif self:isInState(StateSeatRange) then
            --self.bingoController:resetStartCannonUi()
            self:onSpecialPaoTimeout()
            self:changeToNormal()
        elseif self:isInState(StateSeatLockType) then
            self:changeToNormal()
        end

        self:playBatteryStand()
    end
end

function Seat:create3DScore()
    if not self.coinCount3dText then
        local prefabUrl = "Forts/pao_di"
        self.paoDi3d = GameTools.ResourcesLoad(prefabUrl)

        -- self.coinCount3dText = paoDi3d.transform:GetChild(0).transform:GetChild(0).transform:GetChild(0).gameObject:GetComponent("TextMesh")
        self.coinWrapper = GoWrapper.New(self.paoDi3d)
        local scoreMount = self.scoreMount
        scoreMount:SetNativeObject(self.coinWrapper)
        self.paoDiTransform = self.paoDi3d.gameObject:GetComponent("Transform")
        if self.playerComponent.name == "Player_3" or self.playerComponent.name == "Player_4" then
            --上下对称处理
            self.paoDiTransform.localScale = Vector3.New(1, 1, -1);
        end
        --获取炮台底座特效挂载点
        self.paoDiAnimator = self.paoDi3d.transform:GetChild(0).gameObject:GetComponent("Animator");
        self.paoDiLeftObject = self.paoDi3d.transform:Find("kuaisupao/Dummy001/Dummy005/Dummy006").gameObject
        self.paoDiRightObject = self.paoDi3d.transform:Find("kuaisupao/Dummy001/Dummy008/Dummy007").gameObject;
        self.bulletClip = self.paoDi3d.transform:Find("kuaisupao/Object002").gameObject;
        -- self.fortLev3dText = paoDi3d.transform:GetChild(0).transform:Find("GunValue").gameObject:GetComponent("TextMesh")
        -- -- TODO 暂时只修改第一个材质球
        -- local material = paoDi3d.transform:GetChild(0).transform:GetChild(0).gameObject:GetComponent("Renderer").material
        -- local materialUrl = "Assets/Res/3d/Gun/Resource/Materials/pao_bg" .. self.seatId .. ".mat"
        -- local newMaterial = Resource:loadAsset(materialUrl, ResourceType.mat)
        -- -- material:CopyPropertiesFromMaterial(newMaterial.asset)
        -- material.mainTexture = newMaterial.asset:GetTexture(1)
        -- self.coinWrapper:CacheRenderers()
        self.scoreBg.url = "ui://Fish/pao_bg" .. self.seatId
    end
end

function Seat:create3DBattery(skinId)
    if self.batterySpine then
        self.batterySpine:stop()
        self.batterySpine:destroy()
        self.batterySpine = nil
    end

    if self.batterySpineEffect then
        self.batterySpineEffect:stop()
        self.batterySpineEffect:destroy()
        self.batterySpineEffect = nil
    end
    if self.battery3dAni then
        self.battery3dAni:SetActive(false)
        UnityEngine.Object.Destroy(self.battery3dAni)
        self.battery3dAni = nil
    end
    local prefabUrl = self.skinCfg.prefab_path
    self.battery3dAni = GameTools.ResourcesLoad(prefabUrl)

    ---@type  Animator
    self.battery3dAnimator = self.battery3dAni.transform:GetChild(0).gameObject:GetComponent("Animator")
    if skinId == 7 then
        self.fire_paoshen = self.battery3dAni.transform:Find("kuaisupao/Dummy001/Bone001/Dummy003/fire_paoshen").gameObject:GetComponent("ParticleSystem")
        if self.bulletClip then
            self.bulletClip:SetActive(true);
        end
    else
        if self.bulletClip then
            self.bulletClip:SetActive(false);
        end
    end

    if skinId == 3 or skinId == 7 then
        self.fire = self.battery3dAni.transform:GetChild(0).transform:Find("Dummy001/Bone001/Dummy003/Fire").gameObject
        --快速炮由于有子弹带须特殊处理
        if self.playerComponent.name == "Player_1" then
            self.paoDiTransform.localScale = Vector3.New(-1, 1, 1);
        elseif self.playerComponent.name == "Player_4" then
            self.paoDiTransform.localScale = Vector3.New(-1, 1, -1);
        end
        if self.paoDiLeftObject and self.paoDiRightObject then
            self.paoDiLeftObject:SetActive(true);
            self.paoDiRightObject:SetActive(true);
        end
    else
        if self.paoDiLeftObject and self.paoDiRightObject then
            self.paoDiLeftObject:SetActive(false);
            self.paoDiRightObject:SetActive(false);
        end
    end

    if not self.wrapper then
        self.wrapper = GoWrapper.New(self.battery3dAni)
        local batteryAniMount = self.paoMount:GetChild("batteryAniMount")
        batteryAniMount:SetNativeObject(self.wrapper)
    else
        self.wrapper:SetWrapTarget(self.battery3dAni,false)
        self.wrapper:CacheRenderers()
    end

    self.laserBattery = self.paoMount:GetChild("laserPoint")
    self.laserFishImg = self.paoMount:GetChild("lockFishImg")
end

function Seat:create2DBattery(skinId)
    if self.batterySpine then
        self.batterySpine:stop()
        self.batterySpine:destroy()
        self.batterySpine = nil
    end

    if self.batterySpineEffect then
        self.batterySpineEffect:stop()
        self.batterySpineEffect:destroy()
        self.batterySpineEffect = nil
    end
    if self.battery3dAni then
        self.battery3dAni:SetActive(false)
        UnityEngine.Object.Destroy(self.battery3dAni)
        self.battery3dAni = nil
        -- self.wrapper:RemoveFromParent()
        -- self.wrapper:Dispose()
    end
    local position = Vector3.New(0, 0, 0)
    local batteryAniMount = self.paoMount:GetChild("batteryAniMount")
    self.batterySpine = SpineManager.create(self.skinCfg.prefab_path, position, self.skinScale, batteryAniMount)
    if skinId == FightConst.skin_type_jiguangpao then
        self.batterySpineEffect = SpineManager.create("Forts/H5_diancipao_paotaishandain", position, self.skinScale, self.paoMount:GetChild("batteryEffect"))
    end
end

function Seat:onChangeBattery(cskin, battery)
    --SeatRouter.instance:seatConfigChange(seatId, batteryContext.skinId, batteryContext.batteryId)

    local ctx = self:buildBatteryContext(cskin, battery)
    self:initBattery(ctx)
end

function Seat:gameReset()
    self:changeToNormal()
end
function Seat:screenResize()
    --    TODO
end

function Seat:onMouseUp()
    self.isMouseDown = false
    if self:isInState(StateSeatRange) then
        -- TODO
        if self.rangeState == 2 then
            return
        end
        self:onAutoShootTimerEnd()
        self.rangeTimeOut = false
        self.rangeState = 2
        ---@type ShootContext
        local ctx = ShootContext.New()
        ctx.adaptStartPoint.x = self.shootStartX
        ctx.adaptStartPoint.y = self.shootStartY
        ctx.adaptEndPoint.x = self.mouseX
        ctx.adaptEndPoint.y = self.mouseY
        ctx.seatId = self.seatId
        ctx.skinId = self.skinId
        ctx.battery = self.battery

        ctx.uid = Fishery.instance:getBulletUid()
        ctx.hitCount = self.skinCfg.catch_count

        self:shoot(ctx)
    elseif self:isInState(StateSeatLockType) then
        --self.fsm:changeState(StateSeatNormal)
    end
end

function Seat:onMouseDown(x, y)
    self.mouseX = x
    self.mouseY = y
    self.isMouseDown = true

    if self.fsm:isInState(StateSeatLock) then
        local fish = Fishery.instance:pointCollision(self.mouseX, self.mouseY)
        if fish then
            self.lockFish = fish
        end
    elseif self.fsm:isInState(StateSeatBoom) then

        local fish = Fishery.instance:pointCollision(self.mouseX, self.mouseY)
        if fish and fish.canBoom then
            CmdGateOut.instance:useBoom(self.boomSkillId, fish)
        end
    elseif self.fsm:isInState(StateSeatNormal) or self.fsm:isInState(StateSeatLockType) then
        if self:isLockPao() then
            local fish = Fishery.instance:pointCollision(x, y)
            if fish then
                self.lockFish = fish;
                self.lockType = fish.groupLock
            end
        end
    end
end

function Seat:onMouseMove(x, y)
    self.mouseX = x
    self.mouseY = y
end

function Seat:changeToBoom(boomSkillId)
    self.boomSkillId = boomSkillId
    self.fsm:changeState(StateSeatBoom)
end

function Seat:bingoEndAutoState()
    if self.bingoFinalAuto then
        self.fsm:changeState(StateSeatNormal)
        self.bingoFinalAuto = false
        self:onClickAuto()
    else
        self.fsm:changeState(StateSeatNormal)
    end
end

function Seat:changeToNormal()
    self.fsm:changeState(StateSeatNormal)
end

function Seat:changeToAuto()
    if self.fsm:isInState(StateSeatBoom) then
        GameTip.showTipById(39)
    elseif self.fsm:isInState(StateSeatRange) then
        GameTip.showTipById(74)
    elseif self.fsm:isInState(StateSeatWait) then
        GameTip.showTipById(74)
    else
        if self.fsm:isInState(StateSeatLock) then
            if FightContext.instance.lockMode == 1 then
                GameTip.showTipById(38)
            else
                local seat = SeatRouter.instance.mySeat
                seat._isAutoOpen = true
                SeatAuto.instance:onAutoShootStart()
            end
        else
            local seat = SeatRouter.instance.mySeat
            seat._isAutoOpen = true
            self.autoShootPoint.x = 100 + math.random() * 500
            self.autoShootPoint.y = 40 + math.random() * 400
            self.fsm:changeState(StateSeatAuto)
        end
    end
end

function Seat:changeAutoPoint(x, y)
    self.autoShootPoint.x = x
    self.autoShootPoint.y = y
end

function Seat:changeToLock()
    if self.fsm:isInState(StateSeatBoom) then
        GameTip.showTipById(39)
    elseif self.fsm:isInState(StateSeatWait) then
        GameTip.showTipById(74)
    elseif self.fsm:isInState(StateSeatRange) then
        GameTip.showTipById(74)
    elseif self.fsm:isInState(StateSeatLockType) then
        GameTip.showTipById(74)
    else
        --self.fsm:changeState(StateSeatNormal)
        self.fsm:changeState(StateSeatLock)
    end
end

function Seat:changeToExit()
    self.fsm:changeState(StateSeatExit)
end

function Seat:changeToWait()
    local seat = self
    if self.isOpenAuto then
        seat.bingoFinalAuto = true
        seat:onClickAuto()
    end
    if seat:isInState(StateSeatLock) then
        seat.lockRemainTime = 0;
    end
    -- range状态不切换状态机,修正钻头炮皮肤没换但是可以放钻头炮子弹的bug
    if not seat:isInState(StateSeatRange) then
        self.fsm:changeState(StateSeatWait)
    end
end

function Seat:changeToRange(skinId, bingoType, isInit)
    local seat = self
    if self.isOpenAuto then
        seat.bingoFinalAuto = true
        seat:onClickAuto()
    end
    if seat:isInState(StateSeatLock) then
        seat.lockRemainTime = 0;
    end
    seat:changeToNormal();
    seat.bingoController:showBingo(self.fortLevel.text, bingoType, nil)
    if skinId == FightConst.skin_type_jiguangpao then
        self.rangeItem = GameTools.ResourcesLoad('Particle/rangeBox')
        self.lizi = GoWrapper.New(self.rangeItem)
        -- GameTools.createWrapper('Particle/rangeBox')
        local bgUrl = "Assets/Res/3d/Art_Effect/Textures/fanwei_" .. self.seatId .. ".png"
        local bg = Resource:loadAssert(bgUrl, ResourceType.png)
        local bgkUrl = "Assets/Res/3d/Art_Effect/Textures/fanwei_" .. self.seatId .. ".png"
        local bgk = Resource:loadAssert(bgkUrl, ResourceType.png)
        self.rangeItem.transform:GetChild(0).transform:GetChild(0).gameObject:GetComponent("Renderer").material.mainTexture = bg
        self.rangeItem.transform:GetChild(0).transform:GetChild(1).gameObject:GetComponent("Renderer").material.mainTexture = bgk
        self.lizi:CacheRenderers()
        self.rangeBox:GetChild("lizi"):SetNativeObject(self.lizi)
        self.rangeBox.visible = true
        self.rangeState = 0
        SoundManager.PlayEffect("Music/jiguangpao_xl.wav")
    elseif FightConst.skin_type_zuantoupao == skinId then
        SoundManager.PlayEffect("Music/zuantoupao_stand_by.wav")
    end
    self.fsm:changeState(StateSeatRange)
    -- 子弹已经发射后，状态设置为2,修正玩家中途加入bingo不会被移除的bug
    local isShooted = isInit
    if isShooted then
        self.rangeState = 2
    else
        -- 15秒后自动发炮
        self.rangeTimeOut = false
        local outTimeSec = self.skinCfg.limit_t[1]
        local outTime = 15000
        if outTimeSec then
            outTime = outTimeSec * 1000
        end
        seat.isUnableAddCoin = true
        -- 10秒后显示自动发射的倒计时
        local autoShootDelay = outTime - self.AUTO_SHOOT_TIME
        if autoShootDelay < 0 then
            autoShootDelay = 0
        end
        -- 切后台后计时器没有运行，导致GameTimer.Once延迟的时间比实际的时间要长，因此改用GameTimer.TimeOnce方法
        self.autoShootEndTime = TimeTools.getCurMill() + outTime
        GameTimer.TimeOnce(autoShootDelay, self, function()
            -- TODO 暂时用方法执行时间按比计算出的结束时间早200毫秒以上时，判断为切换后台再回来
            local isAppPaused = self.autoShootEndTime - 200 < TimeTools.getCurMill()
            if not isAppPaused then
                if self.rangeState == 1 then
                    self:startAutoShootTimer()
                end
            end
        end)
    end    
end

---@type State
function Seat:isInState(stateClazz)
    return self.fsm and self.fsm:isInState(stateClazz)
end

function Seat:playShoot(adaptX, adaptY)
    --- 不是锁定炮才改变炮台方向
    if not self:isLockPao() then
        self:lookAt(adaptX, adaptY)
    end

    if self.skinCfg.is3d > 0 then
        self:playBatteryAttack()
    else
        self:playBatteryAttack(function()
            self:playBatteryStand()
        end)
    end
end

function Seat:addBulletNum(num)
    self.bulletNum = self.bulletNum + num
    if self.bulletNum < 0 then
        self.bulletNum = 0
    end
end

function Seat:isBulletMax()
    return self.bulletNum >= FightContext.instance.maxBulletNum
end

-----@return ShootContext
--function Seat:_createShootContext(adaptEndX, adaptEndY)
--    --TODO ADD对象池
--    ---@type ShootContext
--    local ctx = ShootContext.New()
--
--    ctx.adaptStartPoint.x = self.shootStartX
--    ctx.adaptStartPoint.y = self.shootStartY
--    ctx.adaptEndPoint.x = adaptEndX
--    ctx.adaptEndPoint.y = adaptEndY
--    ctx.seatId = self.seatId
--    ctx.skinId = self.skinId
--    ctx.battery = self.battery
--
--    ctx.uid = Fishery.instance:getBulletUid()
--    --TODO 其他人的子弹应该是从协议中获取
--    ctx.hitCount = self.skinCfg.catch_count
--    return ctx
--end


function Seat:genNextBulletUid()
    if self.curBulletUid == self.maxBulletUid then
        self.curBulletUid = self.minBulletUId
        return self.curBulletUid
    end
    self.curBulletUid = self.curBulletUid + 1;
    return self.curBulletUid;
end

function Seat:shootContext()
    if (self.isMouseDown or self.isOpenAuto) and self:canShoot() and self:isMySeat() then
        --TODO
        ---@type ShootContext
        local ctx = ShootContext.New()
        ctx.adaptStartPoint.x = self.shootStartX
        ctx.adaptStartPoint.y = self.shootStartY
        ctx.adaptEndPoint.x = self.mouseX
        ctx.adaptEndPoint.y = self.mouseY
        ctx.seatId = self.seatId
        ctx.skinId = self.skinId
        ctx.battery = self.battery

        ctx.hitCount = self.skinCfg.catch_count
        self:shoot(ctx)
    end
end

function Seat:laserShootContext()
    if self:canShoot() and self:isMySeat() then
        ---@type ShootContext
        local ctx = ShootContext.New()
        ctx.adaptStartPoint.x = self.shootStartX
        ctx.adaptStartPoint.y = self.shootStartY
        ctx.adaptEndPoint.x = self.mouseX
        ctx.adaptEndPoint.y = self.mouseY
        ctx.seatId = self.seatId
        ctx.skinId = self.skinId
        ctx.battery = self.battery
        ctx.fuid = self.lockFish.uniId;

        ctx.hitCount = self.skinCfg.catch_count
        self:shoot(ctx)
    end
end

---@param ctx ShootContext
function Seat:shoot(ctx)
    local skinId = ctx.skinId
    local cfgSkin = cfg_battery_skin.instance(skinId)
    --外部条件不可射击
    local mySeatId = SeatRouter.instance.mySeat.seatId;
    if mySeatId == self.seatId then
        -- 特殊炮不判断金币是否足够
        if cfgSkin.is_one_time == 0 and not FightM.instance:checkCanShoot(SeatRouter.instance.mySeat, false) then
            self:setNoMoneyState()
            return
        end
        -- 特殊炮只在StateSeatRange状态下发射,修正特殊炮可以发射多次的bug
        if cfgSkin.is_one_time == 1 and not self:isInState(StateSeatRange) then
            return
        end
    end

    --间隔时间未到无法射击

    if not self:canShoot() and cfgSkin.is_one_time == 0 then
        return
    end

    if self.rangeBox then
        self.rangeBox.visible = false
        -- self.rangeBox:GetChild("lizi").visible = false
    end

    --同屏子弹上限
    --if self:isBulletMax() then
    --    return
    --end

    --if not GameScreen:isInScreen(desX, desY) then
    --    return
    --end

    --if not fishUid then
    --    fishUid = 0
    --end
    --if not isContinuous then
    --    isContinuous = false
    --end
    local multi = cfgSkin.multi
    -- 锁定状态下一次只发一个子弹
    if self:isInState(StateSeatLock) then
        multi = 1
    end
    if self:isMySeat() then
        local baseAngel = MathTools.vecToAngle(ctx.adaptEndPoint.x - self.shootStartX, ctx.adaptEndPoint.y - self.shootStartY)
        for i = 1, multi, 1 do
            local angle = cfgSkin.offAngle[i]
            local offX = cfgSkin.offX[i]
            local offDis = cfgSkin.offLen[i]
            local deltaX = FightTools.CalCosBySheet(angle + baseAngel) * offDis
            local deltaY = FightTools.CalSinBySheet(angle + baseAngel) * offDis
            local ctx1 = ctx:clone()
            ctx1.adaptStartPoint:Set(self.shootStartX + offX + deltaX, self.shootStartY + deltaY)
            ctx1.adaptEndPoint:Set(ctx1.adaptStartPoint.x + deltaX, ctx1.adaptStartPoint.y + deltaY)
            ctx1.uid = self:genNextBulletUid()
            -- 第1个子弹为改变炮台方向的主子弹
            local mainFlag = 0
            if i == 1 then
                mainFlag = 1
            end
            ctx1.isMain = mainFlag
            Fishery.instance:addBullet(ctx1)
            if i == 1 then
                self:playShoot(ctx1.adaptEndPoint.x, ctx1.adaptEndPoint.y)
            end

            CmdGateOut:sendShootProtocol(ctx1)
            self:addBulletNum(1)
        end
        if FightConst.skin_type_zuantoupao == self.skinCfg.id then
            SoundManager.PlayEffect("Music/zuantoupao_fire.wav")
            SoundManager.PlayEffect("Music/zuantoupao_hit1.wav", true)
        elseif FightConst.skined_pao_lock == self.skinCfg.id then
            SoundManager.PlayEffect("Music/lockShoot.wav")
        else
            SoundManager.PlayEffect("Music/shoot.mp3")
        end
        self.shootIntervalSecond = self.skinCfg.shootInterval  --TODO / self.seatViolent:reduceFireRate()
    else
        Fishery.instance:addBullet(ctx)
        --  主子弹才改变炮台方向        
        if ctx.isMain == 1 then
            self:playShoot(ctx.adaptEndPoint.x, ctx.adaptEndPoint.y)
        end
    end
end

function Seat:setNoMoneyState()
    self:onMouseUp()
    if self.fsm:isInState(StateSeatAuto) or self.fsm:isInState(StateSeatLockType) then
        self.fsm:changeState(StateSeatNormal)
    end
end

function Seat:canShoot()
    return self.shootIntervalSecond <= 0 and UIFishPage.instance.changeScene.visible == false
    --and not self.fsm:isInState(StateSeatBoom)
end

function Seat:update()
    self.shootIntervalSecond = self.shootIntervalSecond - Time.deltaTime
    self.fsm:update()
end
--炮台待机动画
function Seat:playBatteryStand()
    if self.skinCfg.is3d > 0 then
        self.battery3dAnimator:Play(self.skinCfg.ani_stand_action)
    else
        self.batterySpine:play(self.skinCfg.ani_stand_action, true)
    end
end
--炮台攻击动画
function Seat:playBatteryAttack(handle)
    if self.skinCfg.is3d > 0 then
        self.battery3dAnimator:Play(self.skinCfg.ani_attack_action)
        self.paoDiAnimator:Play("attack")
        if self.skinId == 7 or self.skinId == 3 then
            if self.fire then
                self.fire:SetActive(true);
                GameTimer.once(80, self, function()
                    if self.fire then
                        self.fire:SetActive(false);
                    end
                end)
            end
        end
        if self.skinId == 7 and self.fire_paoshen then
            Arthas.Tools.PlayParticleEffect(self.fire_paoshen)
        end
    else
        self.batterySpine:play(self.skinCfg.ani_attack_action, false, handle)
    end
end
--炮台抖动动画
function Seat:playBatteryDoudong(handle)
    if self.skinCfg.ani_stand_doudong then
        if self.skinCfg.is3d > 0 then
            --Gtween抖动
                GameTimer.once(500, self, function()
                    --避免出现咬合瞬间判定后，打中激光炮或者钻头炮
                    if self.battery3dAni==nil then
                        return
                    end
                    self.battery3dAni.transform:GetChild(0).gameObject:SetActive(false);
                    self.paoDi3d.gameObject:SetActive(false);
                    GameTimer.once(100, self, function()
                        if self.battery3dAni==nil then
                            return
                        end
                        self.battery3dAni.transform:GetChild(0).gameObject:SetActive(true);
                        self.paoDi3d.gameObject:SetActive(true);
                        local paoTween = GTween.Shake(self.wrapper.position, 5, 2):OnUpdate(
                                function(tweener)
                                    self.wrapper.position = tweener.value.vec3
                                end
                        )      :SetTarget(self.wrapper)
                        local paoDiTween = GTween.Shake(self.coinWrapper.position, 3, 2):OnUpdate(
                                function(tweener)
                                    self.coinWrapper.position = tweener.value.vec3
                                end
                        )      :SetTarget(self.coinWrapper)
                    end)
                end)


            --美术的抖动
            --self.paoDiAnimator:Play("hit")
            --GameTimer.once(500, self, function()
            --    self.battery3dAnimator:Play(self.skinCfg.ani_stand_doudong)
            --end)
        else
            self.batterySpine:play(self.skinCfg.ani_stand_doudong, false, function()
                self:playBatteryStand()
            end)
        end
    end
end

function Seat:exitGame()
    --if self.lockSprite then
    --    self.lockSprite.visible = false
    --end
    --self.seatViolent:stopAni()
    self:changeToNormal()
end

function Seat:setPowerFont(battery, consume)
    if battery ~= nil and (battery ~= self.battery) then
        self.battery = battery
        self:setFortLev(consume)
        --self.powerFontClip.value = consume
        --self.powerFontClip.visible = true
    end
end

function Seat:batteryContext(value)
    local a = value or 1
    if a == 1 then
        return self._batteryContext;
    else
        self._batteryContext = a;
        self:setPowerFont(self._batteryContext:batteryId(), self._batteryContext:consume())
        self:changeSkin(self._batteryContext:skinId(), false)
    end
end

function Seat:getConsume()
    if self.seatInfo and self.skinCfg then
        return cfg_battery.instance(self.battery).comsume * self.skinCfg.catch_count * FightM.instance:getCoinRate() * FightM.instance:getChangeRate();
    end
    return 1
end

function Seat:exitAuto()
    if self.isInStateSeatAuto then
        self:changeToNormal()
    end
end

function Seat:isMySeat()
    return SeatRouter.instance.mySeatId == self.seatId
end

function Seat:setContestCoin(coin)
    self.contest_coin = coin
    --Log.info("金币数值变动setContestCoin",self.contest_coin)
    self:setCoin(self.contest_coin)
end

function Seat:setContestScore(score)
    if Fishery.instance.isMatchScene then
        self.contest_score = score
        self.diamondCountText.text = tostring(self.contest_score)
    end
end

function Seat:addContestCoin(coin)
    self:setContestCoin(self.contest_coin + coin)
end

function Seat:addContestScore(score)
    self:setContestScore(self.contest_score + score)
end

---@param coin number
function Seat:addCoin(coin, isUpdate, isSync)
    if Fishery.instance.isCoinScene then
        if isUpdate then
            self.myCoinCount2 = self.myCoinCount2 + coin
            self.myCoinCount = self.myCoinCount + coin
        else
            self.myCoinCount = self.myCoinCount2 + coin
        end
        if isSync then
            self.myCoinCount = self.myCoinCount2
        end
        if self.myCoinCount <= 0 then
            self:setCoin(0)
        else
            self:setCoin(self.myCoinCount)
        end
    end
end

function Seat:setCoin(coin)
    self.coinCountText.text = tostring(coin)
    -- Arthas.Tools.setTextMeshText(self.coinCount3dText, tostring(coin))
    self.scoreFont.text = tostring(coin)
end

function Seat:setFortLev(consume)
    self.fortLevel.text = consume
    -- Arthas.Tools.setTextMeshText(self.fortLev3dText, tostring(consume))
    self.rateFont.text = tostring(consume)
end

function Seat:lookAt(x, y)
    local angle = MathTools.vecToAngle(x - self.shootStartX, y - self.shootStartY) + 90
    self.paoMount.rotation = angle
end

---@param coin number
function Seat:playExtraAward(coin, skinId, agentGetInfo)
    self.bingoTotalNum = coin
    self:clearZuantoupaoTimer()
    self.zuantoupaoTimer = GameTimer.once(1000, self, function()
        if FightConst.skin_type_zuantoupao == skinId then
            self:onZuantoupaoBurst(agentGetInfo)
        elseif FightConst.skin_type_jiguangpao == skinId then
            self.bingoController:bingoEnd(BingoType.JiGuangPangXie, nil, self.bingoTotalNum, self, function()
                FightC.instance:changeSkin(self.seatId)
                self.bingoController:resetUi(BingoType.JiGuangPangXie, nil)
                self:bingoEndAutoState()
                GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
            end, true)
        else
            Log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            --self.bingoController:bingoEnd(BingoType.SerialBoomPangXie, self.bingoTotalNum, self, self.finalScoreAniPlayed)
        end
    end)
    -- 因为金币的表现有延迟，因此延迟修改不能加金币的状态
    GameTimer.once(3000, self, function()
        self.isUnableAddCoin = false
    end)
end

function Seat:getZuantoupaoEffect(bullet)
    local effect = self.zuantoupaoEffect
    if not effect then
        effect = ZuantoupaoEffect.create(bullet)
        self.zuantoupaoEffect = effect
    else
        -- 玩家发射钻头炮后,另一个玩家进入渔场,该玩家不退出渔场的话,self.zuantoupaoEffect不会被清除,导致effect.bullet一直为空
        if bullet then
            effect:init(bullet)
        else
            effect:init(effect.bullet)
        end
    end
    return effect
end

function Seat:onZuantoupaoFirstHit(bullet)
    local effect = self:getZuantoupaoEffect(bullet)
    effect:onFirstHitNumChg()
    self.batterySpine.wrapper.visible = false;
end

function Seat:onZuantoupaoBurst(agentGetInfo)
    local effect = self:getZuantoupaoEffect()
    -- 修正退出后再进来可能会收到服务端消息，导致crash的bug
    if effect.bullet then
        effect:onZuantoupaoEffectCompletedNumChg(self.bingoTotalNum)
        effect:playBulletEffect(agentGetInfo)
    end
end

function Seat:clearZuantoupaoTimer()
    if self.zuantoupaoTimer then
        self.zuantoupaoTimer:clear()
    end
end

function Seat:finalScoreAniPlayed()
    FightC.instance:changeSkin(self.seatId)
    self.bingoController:resetUi(BingoType.SerialBoomPangXie, nil)
    self:bingoEndAutoState()
end

function Seat:bossDeathAddCoin(score, agent)
    local agentGetInfo = AgentGetInfo.New()
    agentGetInfo.t = FightConst.currency_coin
    agentGetInfo.v = score
    agentGetInfo.leftTime = 0
    agentGetInfo.ag = agent
    GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
end

function Seat:onZuantoupaoShowScore(agentGetInfo)
    self.bingoController:bingoEnd(BingoType.ZuanTouPangXie, nil, self.bingoTotalNum, self, function()
        FightC.instance:changeSkin(self.seatId)
        if self.zuantoupaoEffect then
            self.zuantoupaoEffect:recover()
            self.zuantoupaoEffect = nil
        end
        self:bingoEndAutoState()
        self:clearZuantoupaoTimer()
        self.bingoController:resetUi(BingoType.ZuanTouPangXie, nil)
        GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
    end, false)
    -- SoundManager.PlayEffect("Music/zuantoupao_score.wav")
end

function Seat:onSerialFryingShowScore(totalScore, num, agentId)
    self.bingoController:bingoEnd(BingoType.SerialBoomPangXie, nil, totalScore, self, function()

        self:bingoEndAutoState()
        FightC.instance:changeSkin(self.seatId)
        self.bingoController:resetUi(BingoType.SerialBoomPangXie, nil)

        local agentGetInfo = AgentGetInfo.New()
        agentGetInfo.t = FightConst.currency_coin
        agentGetInfo.v = num
        agentGetInfo.leftTime = 0
        agentGetInfo.ag = agentId
        GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
    end, false)
end

function Seat:onZuantoupaoEffectCompleted()
    FightC.instance:changeSkin(self.seatId)
    if self.zuantoupaoEffect then
        self.zuantoupaoEffect:recover()
        self.zuantoupaoEffect = nil
    end
    self:clearZuantoupaoTimer()
end

function Seat:onSerialFryingCompleted()
    FightC.instance:changeSkin(self.seatId)
    self.bingoController:resetUi(BingoType.SerialBoomPangXie, nil)
end

function Seat:getUrlByLockType()
    if self.lockFish then
        local url = self.lockFish.fishCfg.Imageurl_down
        return url
    end

    local sceneFishes = ConfigManager.getConfValue("cfg_scene", FightM.instance.sceneId, "fish_arr")
    if self.lockType then
        --- 判断渔场有没有该类型
        local fishes = Fishery.instance:getFishByGroupLock(self.lockType)
        local _, fish = next(fishes)
        if fish then
            local url = fish.fishCfg.Imageurl_down
            return url
        end

        for _, id in pairs(sceneFishes) do
            ---@type cfg_fish
            local fish = cfg_fish.instance(id)
            if fish.group_lock == self.lockType then
                return fish.Imageurl_down
            end
        end
    else
        for _, id in pairs(sceneFishes) do
            ---@type cfg_fish
            local fish = cfg_fish.instance(id)
            if fish.fishType == GameConst.fish_type_boss then
                self.lockType = fish.group_lock
                return fish.Imageurl_down
            end
        end
    end
end

function Seat:dealLockFishImg()
    local resUrl = self:getUrlByLockType()
    --- 旋风鱼图标统一
    if self.lockType == FightConst.fish_group_lock_whirlwind then
        resUrl = "ui://FishType/img_xuanfengyu"
    end

    local isFishInScene = Fishery.instance:checkIsExistLockFish(self.lockType)
    local firstResh = self.laserLastImgUrl == ""
    if resUrl then
        self.laserFishImg.visible = true
        if not (self.laserLastImgUrl == resUrl) and (isFishInScene or firstResh) then
            GameTools.loadHeadImage(self.laserFishImg, resUrl)
            self.laserFishImg:SetScale(0.6, 0.6)
            self.laserLastImgUrl = resUrl
        end
    else
        self.laserFishImg.visible = false
        if self:isMySeat() then
            Log.error("没有配置锁定鱼组贴图")
        end
    end

    if self.laserFishImg.visible then
        self.laserFishImg.alpha = isFishInScene and 1 or 0.5
    end
end

function Seat:chooseLockFish()
    if not self.lockType then
        return
    end
    local fishes = Fishery.instance:getFishByGroupLock(self.lockType)
    ---@type Fish2D
    local _, fish = next(fishes)
    if fish then
        self.lockFish = fish
    end
end

function Seat:checkLaserShoot()
    local ret = false
    if self:isLockPao() then
        if self.isOpenAuto and not self.lockFish then
            self:chooseLockFish()
        end

        if self.lockFish then
            self.fsm:changeState(StateSeatLockType)
        end
        ret = true
    end
    return ret
end

function Seat:showAutoShoot(isShow)
    self.autoShootItem.visible = isShow
end

function Seat:updAutoShootTime()
    local leftTime = math.max(0, math.ceil(self:getLeftAutoShootTime() / 1000))
    self.autoShootTimeText.text = "限时发射: " .. leftTime .. "秒"
end

function Seat:onAutoShootTimeUpd()
    local leftTime = self:getLeftAutoShootTime()
    local isShow = leftTime > 0
    self:showAutoShoot(isShow)
    if isShow then
        self:updAutoShootTime()
    else
        self.rangeTimeOut = true
        self:onAutoShootTimerEnd()
    end
end

function Seat:getLeftAutoShootTime()
    return self.autoShootEndTime - TimeTools.getCurMill()
end

function Seat:startAutoShootTimer()
    -- self.autoShootEndTime = TimeTools.getCurMill() + self.AUTO_SHOOT_TIME
    self:onAutoShootTimeUpd()
    self:clearAutoShootTimer()
    self.autoShootTimer = GameTimer.loop(500, self, self.onAutoShootTimeUpd)
end

function Seat:clearAutoShootTimer()
    if self.autoShootTimer then
        self.autoShootTimer:clear()
        self.autoShootTimer = nil
    end
end

function Seat:onAutoShootTimerEnd()
    self:showAutoShoot(false)
    self:clearAutoShootTimer()
end

function Seat:onSpecialPaoTimeout()
    -- 切后台超时，清除特效和bingo
    if self.bingoController then
        self.bingoController:resetUi()
    end
end
