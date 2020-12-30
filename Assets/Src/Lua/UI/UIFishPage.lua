---@class UIFishPage :UIBase
---@field public instance UIFishPage
UIFishPage = class("UIFishPage", UIBase)

function UIFishPage:init()
    self.packageName = "Fish"
    self.resName = "FishPage"
    self.FortPoints = nil;
    self.BulletPoints = nil;
    self.animation = nil
    self.bar = nil
    self.isAuto = true
    self.unlockBatteryTip = false
    self.unLockOut = false-- //解锁动画在外面
    self.unLockInside = true-- //解锁动画在里面
    self.unlockBatteryTipTime = 0
    self.boomListDate = {}
    self.task_percent = {}
    self.unFinish_arr = {}
    self.isUpdate = false

    self.progressArr = { 0.1, 0.3, 0.6, 1 }
    self.isLotteryBoxShowing = false;
    self._leftTime = nil
    self._onlineCount = nil
    self._skillSwitch = 1

    self.fishMatchControllers = {}
end


-- 方法名大驼峰，public

--@override 注册事件监听
function UIFishPage:Register()
    self:AddRegister(GameEvent.StartRefersh, self, self.starRefreshOnline);
    self:AddRegister(GameEvent.OnlineAwardUpdate, self, self.receive);
    self:AddRegister(GameEvent.FightStop, self, self.exitFight);
    self:AddRegister(FightEvent.FightUpdate, self, self.onFightUpdate);
    self:AddRegister(GameEvent.ReturnConfirm, self, self.fightReturn);
    self:AddRegister(GameEvent.UpdateProfile, self, self.updateFishCount);
    self:AddRegister(GameEvent.NoviceGuideUnlockBattery, self, self.unlockbattery);
    self:AddRegister(GameEvent.BatteryBuyRet, self, self.batteryBuyRet);
    self:AddRegister(GameEvent.AddAgentGetInfo, self, self.onAddAgentGetInfo);
    self:AddRegister(GameEvent.BatteryRateChagne, self, self.initDoubleRate);
    self:AddRegister(GameEvent.RefreshTaskDaily, self, self.refreshTask);
    self:AddRegister(GameEvent.RefreshTaskDailyTotal, self, self.refreshTaskTotal);
    self:AddRegister(GameEvent.SynRedData, self, self.initRedBox)
    self:AddRegister(GameEvent.SynTaskCoinData, self, self.initRedBox)
    self:AddRegister(GameEvent.GoodsUpdate, self, self.goodsUpdate);
    self:AddRegister(GameEvent.FinishReward, self, self.updateLottery);
    self:AddRegister(GameEvent.UpdateTime, self, self.update);
    self:AddRegister(GameEvent.UpdateGoldPoolInfo, self, self.updateCoinCount);
    self:AddRegister(GameEvent.SystemReset, self, self.onChallengeGameCloseClick);
    self:AddRegister(GameEvent.MatchingSynRoomData, self, self.matchingSynRoomData);
    self:AddRegister(GameEvent.ContestFightStart, self, self.contestFightStart);
end


--@override 移除事件监听
function UIFishPage:UnRegister()
    if self.indexGameBGAni then
        self.indexGameBGAni.visible = false
    end
    if self.matchTimer then
        self.matchTimer:clear()
        self.matchTimer = nil
    end
    self.calcTime:clear()
    self:ClearRegister()
end

function UIFishPage:initComponent()
    self.view:MakeFullScreen()
    self.view.draggable = true
    self.view.fairyBatching = true

    -- self.GameBg = self.view:GetChild("GameBg")
    ---@type GLoader
    self.GameBgSceneAni = self.view:GetChild("GameBgSceneAni")
    self.BossZhangYu = self.view:GetChild("BossZhangYu")
    self.bar = self.view:GetChild("bar")

    self.Player_1 = self.view:GetChild("Player_1")
    self.Player_2 = self.view:GetChild("Player_2")
    self.Player_3 = self.view:GetChild("Player_3")
    self.Player_4 = self.view:GetChild("Player_4")
    local Wait_2 = self.view:GetChild("Wait2")
    local Wait_3 = self.view:GetChild("Wait3")
    local Wait_4 = self.view:GetChild("Wait4")
    --
    --self.coinOne = self.Player_1:GetChild("DetailInfo"):GetChild("Coin")
    --self.coinTwo = self.Player_2:GetChild("DetailInfo"):GetChild("Coin")
    --self.coinThree = self.Player_3:GetChild("DetailInfo"):GetChild("Coin")
    --self.coinFour = self.Player_4:GetChild("DetailInfo"):GetChild("Coin")
    ---@type GComponent
    local skillView = self.view:GetChild("skillView")
    SeatRouter.instance:setSeatParent(self.Player_1, self.Player_2, self.Player_3, self.Player_4, Wait_2, Wait_3, Wait_4)

    self.AddBtn = self.Player_1:GetChild("AddBtn")
    self.ReduceBtn = self.Player_1:GetChild("ReduceBtn")

    ---在线奖励
    self.onLineBox = self.view:GetChild("onLineBox")
    self.onLineBoxEvent = self.view:GetChild("onLineBoxEvent")
    self.receiveImg = self.view:GetChild("receiveImg")
    self.countBox = self.view:GetChild("countBox")
    self.onlineCount = self.view:GetChild("onlineCount")
    self.timeBox = self.view:GetChild("timeBox")
    self.leftTime = self.view:GetChild("leftTime")
    self.onlineAni = self.view:GetTransition("onlineAni")
    self.getImg = self.view:GetChild("getImg")
    self.lqjlani = self.view:GetChild("lqjlani")
    ---按钮
    self.ele_chuBtn = self.view:GetChild("chuBtn")
    self.ele_jinBtn = self.view:GetChild("jinBtn")
    self.backBtn = self.view:GetChild("backBtn")
    self.settingBtn = self.view:GetChild("settingBtn")
    self.lotteryBtn = self.view:GetChild("LotteryBtn")
    self.fishTypeBtn = self.view:GetChild("fishTypeBtn")
    self.changeSkinBtn = self.view:GetChild("ChangeSkinBtn");
    self.shoot = self.view:GetChild("shoot")

    ---技能
    self.cancelBoomBtn = skillView:GetChild("cancelBoom")
    self.boomMask = self.view:GetChild("boomMask")

    self.boomList = skillView:GetChild("boomList")

    local DetailInfo_1 = self.Player_1:GetChild("DetailInfo")
    local DetailInfo_2 = self.Player_2:GetChild("DetailInfo")
    local DetailInfo_3 = self.Player_3:GetChild("DetailInfo")
    local DetailInfo_4 = self.Player_4:GetChild("DetailInfo")

    table.insert(self.fishMatchControllers, self.view:GetController("fish_match"))
    table.insert(self.fishMatchControllers, skillView:GetController("fish_match"))
    table.insert(self.fishMatchControllers, DetailInfo_1:GetController("fish_match"))
    table.insert(self.fishMatchControllers, DetailInfo_2:GetController("fish_match"))
    table.insert(self.fishMatchControllers, DetailInfo_3:GetController("fish_match"))
    table.insert(self.fishMatchControllers, DetailInfo_4:GetController("fish_match"))

    self.frozenMask = skillView:GetChild("frozenMask")
    self.lockMask = skillView:GetChild("lockMask")
    self.vioMask = skillView:GetChild("vioMask")

    ---红包
    self.redBox = self.view:GetChild("redBox")
    self.redBoxEvent = self.view:GetChild("redBoxEvent")
    self.redBtn = self.view:GetChild("redBtn")
    self.hint = self.view:GetChild("hint")
    self.redBar = self.view:GetChild("red_bar")
    self.redSpineGraph = self.view:GetChild("redSpineGraph")

    ---解锁炮台
    self.gunImg = self.view:GetChild("gunImg")
    self.gunImgBtn = self.view:GetChild("gunImgBtn")
    self.gunBoxOne = self.view:GetChild("gunBoxOne")
    self.unlockSpineBox = self.view:GetChild("unlockSpineBox")
    self.gunBtnSpineBox = self.view:GetChild("gunBtnSpineBox")
    self.gunBoxOneBg = self.view:GetChild("gunBoxOneBg")
    self.ptxt1 = self.view:GetChild("ptxt1")
    self.rewardCount = self.view:GetChild("rewardCount")
    self.gunBoxTwo = self.view:GetChild("gunBoxTwo")
    self.gunBoxTwoBg = self.view:GetChild("gunBoxTwoBg")
    self.proBar = self.view:GetChild("pre")
    self.ptxt2 = self.view:GetChild("ptxt2")
    self.needZ = self.view:GetChild("needZ")
    self.yZuan = self.view:GetChild("yZuan")

    ---双倍金币双倍爆率和自动
    self.AutoBtn = self.Player_1:GetChild("AutoBtn")
    self.CancelAutoBtn = self.Player_1:GetChild("CancelAutoBtn")
    self.autoAniBox = self.Player_1:GetChild("autoAniBox")
    self.DoubleChanceBtn = self.Player_1:GetChild("DoubleChanceBtn")
    self.CancelChanceBtn = self.Player_1:GetChild("CancelChanceBtn")
    self.DoubleCoinBtn = self.Player_1:GetChild("DoubleCoinBtn")
    self.CancelCoinBtn = self.Player_1:GetChild("CancelCoinBtn")
    self.AutoTimeTip = self.Player_1:GetChild("AutoTimeTip")
    self.doubleCoinLock = self.Player_1:GetChild("doubleCoinLock")
    self.DoubleCoinLockBg = self.Player_1:GetChild("DoubleCoinLockBg")
    self.doubleChanceLock = self.Player_1:GetChild("doubleChanceLock")
    self.DoubleChanceLockBg = self.Player_1:GetChild("DoubleChanceLockBg")

    ---任务相关
    --self.taskView = self.view:GetChild("taskView")
    --self.p_txt = self.taskView:GetChild("p_txt")
    --self.p_task = self.taskView:GetChild("p_task")
    --self.click_a = self.taskView:GetChild("click_a")
    --self.task_icon = self.taskView:GetChild("task_icon")
    --self.task_icon_bg = self.taskView:GetChild("task_icon_bg")
    --self.task_name = self.taskView:GetChild("task_name")
    --self.list_reward = self.taskView:GetChild("list_reward")
    --self.bgBtn = self.taskView:GetChild("bgBtn")

    ---奖金池相关
    self.IntegralView = self.view:GetChild("IntegralView")
    self.totalCoin = self.IntegralView:GetChild("totalCoin")
    self.totalIntegral = self.IntegralView:GetChild("totalIntegral")
    self.currentTime = self.IntegralView:GetChild("currentTime")
    self.ruleBtn = self.IntegralView:GetChild("ruleBtn")

    self.ruleBtn:onClick(self.onRuleClick, self)

    self.AutoBtn:onClick(self.onAutoBtnClick, self)
    self.CancelAutoBtn:onClick(self.onAutoBtnClick, self)
    self.CancelAutoBtn.visible = false
    self.autoAniBox.visible = false
    local wrapper = GameTools.createWrapper("Effects/RingToRun")
    self.autoAniBox:SetNativeObject(wrapper)
    
    self.DoubleCoinBtn:onClick(self.onCoinBtnClick, self)
    self.DoubleCoinLockBg:onClick(self.unLockDoubleCoin, self)
    self.CancelCoinBtn:onClick(self.onCoinBtnClick, self)

    self.DoubleChanceBtn:onClick(self.onChanceBtnClick, self)
    self.DoubleChanceLockBg:onClick(self.unLockDoubleChance, self)
    self.CancelChanceBtn:onClick(self.onChanceBtnClick, self)

    self.ele_chuBtn.onClick:Set(self.onChuClick, self)
    self.ele_jinBtn.onClick:Set(self.onJinClick, self)
    self.backBtn:onClick(self.onBackClick, self)
    self.settingBtn:onClick(self.onSettingClick, self)
    self.lotteryBtn:onClick(self.onLotteryClick, self)
    self.fishTypeBtn:onClick(self.onFishTypeClick, self)
    self.changeSkinBtn:onClick(self.onChangeSkinClick, self)

    self.gunImgBtn:onClick(self.clickGunImg, self)
    self.gunBoxOneBg.onClick:Set(self.unlockbattery, self)
    self.gunBoxTwoBg.onClick:Set(self.clickBoxTwo, self)

    self.AddBtn:onClick(self.onAddClick, self)
    self.ReduceBtn:onClick(self.onReduceClick, self)

    self.redBoxEvent:onClick(self.onRedBtn, self)
    self.redBtn:onClick(self.onRedBtn, self)
    self.onLineBoxEvent:onClick(self.clickReceive, self)

    --战斗点击事件
    --self.frozenBtn.onTouchBegin:Set(self.onTouchBegin, self)
    --self.frozenBtn.onTouchEnd:Set(self.onTouchEnd, self)

    self.shoot.onTouchBegin:Set(self.onTouchBegin, self)
    self.shoot.onTouchEnd:Set(self.onTouchEnd, self)

    self.view.onTouchMove:Set(self.onTouchMove, self)
    self.view.onTouchMove:Set(self.onTouchMove, self)

    self.releaseTween = self.view:GetTransition("release")
    self.collectTween = self.view:GetTransition("collect")
    self:playGuangSpine(self.unlockSpineBox, "zuobiankuang", Vector3.New(183, -58, 1), 1.1, 1, true)
    self:playGuangSpine(self.gunBtnSpineBox, "icon_js", Vector3.New(47, -59, 1), 1.4, 1.4, true)
    self:playGuangSpine(self.redSpineGraph, "zuobiankuang", Vector3.New(183, -58, 1), 1.1, 1, true)

    --抽奖相关
    self.lotteryTxt = self.view:GetChild("lotteryTxt")
    self.lotteryBoxOne = self.view:GetChild("lotteryBoxOne")
    self.lotteryPro = self.lotteryBoxOne:GetChild("lotteryPro")
    self.curLotteryPro = self.lotteryBoxOne:GetChild("curLotteryPro")
    self.prizePool = self.lotteryBoxOne:GetChild("prizePool")
    self.lotterySpineBox = self.lotteryBoxOne:GetChild("spineBox")
    self.lotteryBtnSpineBox = self.view:GetChild("lotteryBtnSpineBox")

    self.lotteryOut = self.view:GetTransition("lotteryOut")
    self.lotteryIn = self.view:GetTransition("lotteryIn")
    self.lotteryBoxOne.onClick:Set(self.onLotteryBoxClick, self)
    self:playGuangSpine(self.lotterySpineBox, "zuobiankuang", Vector3.New(190, -58, 1), 1.15, 1, true)
    self:playGuangSpine(self.lotteryBtnSpineBox, "icon_js", Vector3.New(56, -53, 1), 1.4, 1.4, true)

    --比赛场
    self.MatchGroup = self.view:GetChild("MatchGroup")
    self.StartBtn = self.view:GetChild("StartBtn")
    self.WaitBtn = self.view:GetChild("WaitBtn")
    self.WaitGroup = self.view:GetChild("WaitGroup")
    self.WaitText = self.view:GetChild("WaitText")
    self.WaitGroupOne = self.view:GetChild("WaitGroupOne")
    self.WaitTimeOneText = self.view:GetChild("WaitTimeOne")

    self.MatchRoomGroup = self.view:GetChild("MatchRoomGroup")
    self.CancelChallengeBtn = self.view:GetChild("CancelChallengeBtn")
    self.ChallengeTimeText = self.view:GetChild("ChallengeTimeText")
    self.RoomText = self.view:GetChild("RoomText")
    self.MatchController = self.view:GetController("MatchController")



    --测试组件
    self.testPanel = self.view:GetChild("testPanel")
    self.testPanelOut = self.view:GetTransition("testOut")
    self.testEyu = self.testPanel:GetChild("eyu")
    self.testEyuAwake = self.testPanel:GetChild("eyuAwake")
    self.ankangyuAwake = self.testPanel:GetChild("ankangyuAwake")
    self.disconnectBtn = self.testPanel:GetChild("disconnectBtn")
    self.leishenchuiAwake = self.testPanel:GetChild("leishenchuiAwake")

    self.MatchMaskPanel = self.view:GetChild("n187")
    self.MatchRoomWenBtn = self.view:GetChild("MatchRoomWenBtn")
    self.ContestTimeGroup = self.view:GetChild("ContestTimeGroup")
    self.ContestTimeText = self.view:GetChild("ContestTimeText")

    --全屏震动
    --只震背景
    self.douDongAni = self.view:GetTransition("shake")
    --全部UI震动
    self.douDongAllAni = self.view:GetTransition("shakeAll")
    self.changeScene = self.view:GetChild("ChangeScene")
    self.water = GameTools.ResourcesLoad("Effects/Water_Transition")
    self.water.transform:GetChild(0).gameObject:GetComponent("Renderer").material:SetFloat("_NormalAlphastrength", 0)
    self.waterWrapper = GoWrapper.New(self.water)
    self.waterSpeed = 0
    self.waterAlpha = 0
    self.changeScene.component:GetChild("water"):SetNativeObject(self.waterWrapper)
    self.changeScene.visible = false

    self.topMask = self.view:GetChild("topMask")
end

function UIFishPage:playGuangSpine(holder,aniName, pos, scaleX, scaleY,isLoop)
    local spine = SpineManager.create("Effects/Guang", pos, 1, holder)
    spine:setScale(scaleX, scaleY)
    spine:play(aniName, isLoop)
end

function UIFishPage:changeWaterAlpha()
    self.waterAlpha = self.waterAlpha > 1 and 1 or self.waterAlpha
    self.waterAlpha = self.waterAlpha < 0 and 0 or self.waterAlpha
    self.water.transform:GetChild(0).gameObject:GetComponent("Renderer").material:SetFloat("_NormalAlphastrength", self.waterAlpha)
end
function UIFishPage:frameLoop()
    -- Log.error("111111",Time.deltaTime)
    if self.waterSpeed then
        self.waterAlpha = self.waterAlpha + self.waterSpeed * Time.deltaTime
        self:changeWaterAlpha()
    end

end

function UIFishPage:refreshBg()
    if self.bossComingBox then
        self.bossComingBox.visible = false
        self.topMask.visible = false
    end
    if self.GameBgSceneAni.component and self.GameBgSceneAni.component:GetTransition("he") then
        self.GameBgSceneAni.component:GetTransition("he"):Play()
    end
    self.cfgScene = cfg_scene.instance(Fishery.instance.sceneId)
    -- self.GameBg.url = self.cfgScene.sceneBgImg_down
    self.GameBgSceneAni.url = self.cfgScene.sceneAniName
    local specialLayer = {}
    if self.GameBgSceneAni.component and self.GameBgSceneAni.component:GetChild("ZhangYuLayer") then
        specialLayer["ZhangYuLayer"] = self.GameBgSceneAni.component:GetChild("ZhangYuLayer")
    end
    specialLayer["LightLayer"] = self.view:GetChild("LightLayer")

    FishLayer.instance:initLayer(
            self.view:GetChild("BulletLayer"),
            self.view:GetChild("FishLayer"),
            self.view:GetChild("EffectLayer"),
            self.view:GetChild("BoomLayer"),
            self.view:GetChild("FreezeImg"),
            specialLayer,
            self.view:GetChild("AwakeLayer"),
            self.view:GetChild("UpEffectLayer"),
            self.view:GetChild("TopLayer")
    )
    if Fishery.instance.sceneId == 4 then
        self:initBossZhangYu()
    end
    if not Fishery.instance.isMergeScene then
        self:playSceneAni()
    else
        if Fishery.instance.sceneId == 3 then
            self.view:GetChild("LightLayer").visible = false
            self:playSceneAni()
        end
    end
end

function UIFishPage:playSceneAni()
    if self.GameBgSceneAni.component and self.GameBgSceneAni.component:GetTransition("sceneIn") then
        self.GameBgSceneAni.component:GetTransition("sceneIn"):Play()
    end
end

function UIFishPage:changeSceneStage(stage, isBoss)
    if stage == GameConst.boss_stage_big then
        if isBoss then
            self:playBossComing()
        end
        if Fishery.instance.sceneId == 3 then
            self.view:GetChild("LightLayer").visible = true
            if self.view:GetChild("LightLayer"):GetTransition("showMask") then
                self.view:GetChild("LightLayer"):GetTransition("showMask"):Play()
            end
        else
            self:playSceneAni()
        end
    end
end

function UIFishPage:playBossComing()
    if not self.bossComing then
        self.bossComingBox = GGraph.New()
        self.bossComingBox.pivot = Vector2.New(0.5, 0.5)
        self.bossComingBox.position = Vector2.New(GRoot.inst.width / 2, GRoot.inst.height / 2)
        FishLayer.instance.topLayer:AddChild(self.bossComingBox)
        self.bossComing = SpineManager.create("Effects/boss_Coming", Vector3.New(0, 0, 0), 100, self.bossComingBox)
    end
    local bossName = "shiqianjue"
    if Fishery.instance.sceneId == 3 then
        bossName = "anyejushou"
    elseif Fishery.instance.sceneId == 4 then
        bossName = "shenhaibazhua"
    end
    SoundManager.PlayEffect("Music/boss_coming.mp3", false)
    self.bossComingBox.visible = true
    self.topMask.visible = true
    self.bossComing:play(bossName, false, function()
        self.bossComingBox.visible = false
        self.topMask.visible = false
    end)
end

function UIFishPage:StartGames()
    LoginM.instance.pageId = GameConst.FISH_PAGE
    self.calcTime = GameTimer.loop(1000, self, self.updateTime)
    LoginM.instance.roomId = -1
    self:refreshBg()
    if Game.instance.fsm:isNotInStates({ StateGameInit }) then
        self:changeSceneStage(Fishery.instance.sceneStage, false)
    end
    -- self.cfgScene = cfg_scene.instance(Fishery.instance.sceneId)
    -- -- self.GameBg.url = self.cfgScene.sceneBgImg_down
    -- self.GameBgSceneAni.url = self.cfgScene.sceneAniName

    -- local specialLayer = {}
    -- if self.GameBgSceneAni.component and self.GameBgSceneAni.component:GetChild("ZhangYuLayer") then
    --     specialLayer["ZhangYuLayer"] = self.GameBgSceneAni.component:GetChild("ZhangYuLayer")
    -- end
    -- specialLayer["LightLayer"] = self.view:GetChild("LightLayer")
    -- FishLayer.instance:initLayer(
    --         self.view:GetChild("BulletLayer"),
    --         self.view:GetChild("FishLayer"),
    --         self.view:GetChild("EffectLayer"),
    --         self.view:GetChild("BoomLayer"),
    --         self.view:GetChild("FreezeImg"),
    --         specialLayer,
    --         self.view:GetChild("EyuAwake"),
    --         self.view:GetChild("AnKangYuAwake")
    -- )

    --Fishery.instance:playForm(2, 2)
    self:initBar()
    self:initBtn()
    self:initIntegral()
    self:initSkillView()
    self:updatePower()
    self:initDoubleRate()
    self.ContestTimeGroup.visible = false

    if Fishery.instance.isMatchScene then
        ---@param controller Controller
        for _, controller in ipairs(self.fishMatchControllers) do
            controller.selectedPage = "match"
        end
        if Fishery.instance.sceneId == 5 then
            self.MatchController.selectedPage = "Daily"
            self:setContestEndTime()
        end
        if Fishery.instance.sceneId == 6 then
            self:initChallengeGame()
        end
        if Fishery.instance.sceneId == 7 then
            self.MatchController.selectedPage = "Match"
        end
    else
        ---@param controller Controller
        for _, controller in ipairs(self.fishMatchControllers) do
            controller.selectedPage = "fish"
        end
        self:initWelcomeAni()
        --TODO 配置
        -- if Fishery.instance.sceneId == 4 then
        --     self:initBossZhangYu()
        -- end
    end

    self:onLineReward()
    self:initRedBox()
    self:updateLottery()
    self:setLotteryBtn()
    self:refreshLeftBtn()

    self.StartBtn:onClick(self.onMatchStartBtn, self)
    self.WaitBtn:onClick(self.onMatchPrepareBtn, self)

    if ENV.IN_EDITOR then
        self.testPanel.onClick:Set(self.onTestPanelClick, self)
        self.testEyu:onClick(self.onTestEyu, self)
        self.testEyuAwake:onClick(self.onTestEyuAwake, self)
        self.ankangyuAwake:onClick(self.onTestAnkangyuAwake, self)
        self.leishenchuiAwake:onClick(self.onTestLeiShenChuiAwake, self)
        self.disconnectBtn:onClick(self.onTestDisconnect, self)
        self.testPanelIsOut = false

        self.testPanel.visible = true
    else
        self.testPanel.visible = false

    end
    self.MatchRoomWenBtn:onClick(self.onClickMatchRoomWenBtn, self)
end

function UIFishPage:onClickMatchRoomWenBtn()
    UIManager:LoadView("RulePage")
end

---@param e EventContext
function UIFishPage:onTestEyu(e)
    e:StopPropagation()
    Log.debug("UIFishPage:onTestEyu")

      local fish = FishFactory.testCreateEyuFish()
      Fishery.instance:addFish(fish)
    --if not self.testwaper then
    --    self.fish3dani = GameTools.ResourcesLoad("Fish/xiaochouyu_down")
    --    self.testwaper = GoWrapper.New(self.fish3dani)
    --    self.testg = GGraph.New()
    --    self.testg:SetNativeObject(self.testwaper)
    --    self.view:AddChild(self.testg)
    --    self.testg.position = Vector2.New(GRoot.inst.width / 2, GRoot.inst.height / 2)
    --
    --end



    -- self:onTestPanelClick()
    --if Fishery.instance.sceneId == 3 then
    --    self:playChangeScene(4)
    --else
    --    self:playChangeScene(3)
    -- end
    -- statements
    --GameTimer.loop(1000, self, self.changeColor)
    --self:changeSceneStage(2)

    --UIFishPage.instance:changeSceneStage(2, true)
end

function UIFishPage:changeColor()
    if not self.mesh then

        local child = self.fish3dani.transform:GetChild(0)
        local gobj = child.transform:Find("fishBody")
        if not gobj then
            return
        end
        self.mesh = gobj.transform:GetComponent("SkinnedMeshRenderer");
        if not self.mesh then
            return
        end
        self.texture = libx.Assets.LoadAsset("Assets/Res/3d/xiaochouyu_down/xiaochouyu.psd", typeof(UnityEngine.Texture)).asset
        --self.texture = Resource:loadAssert("Assets/Res/3d/xiaochouyu_down/xiaochouyu.png", ResourceType.png)
        self.mesh.material = Resource:loadAssert("Assets/Res/Shaders/ShadowAllphaBlendDepth.shader", ResourceType.shader)
        self.mesh.material:SetTexture("_Main_Tex", self.texture);
    else
        self.mesh.material:SetFloat("_Brightness", 5.4);
        self.mesh.material:SetFloat("_Saturation", 1);
        local color = Color.New(math.random(0, 1), math.random(0, 1), math.random(0, 1), 1)
        self.mesh.material:SetColor("_Main_Color", color);
    end
end
---@param e EventContext
function UIFishPage:onTestEyuAwake(e)
    e:StopPropagation()
    Log.debug("UIFishPage:onTestEyuAwake")
    --local fish = FishFactory.testCreateEyuFish()

    --local mySeat = SeatRouter.instance.mySeat
    --mySeat:playEyuAwake(3)
    --
    --self:onTestPanelClick()
end

---@param e EventContext
function UIFishPage:onTestDisconnect(e)
    e:StopPropagation()
    Log.debug("UIFishPage:onDisconnect")

    Game.instance:onNetworkError(WebSocketManager.instance.socket)
end

---@param e EventContext
function UIFishPage:onTestAnkangyuAwake(e)
    e:StopPropagation()
    Log.debug("UIFishPage:onTestAnKangyuAwake")
    local mySeat = SeatRouter.instance.mySeat
    mySeat:playAnKangYuAwake()
    self:onTestPanelClick()
end

---@param e EventContext
function UIFishPage:onTestLeiShenChuiAwake(e)
    e:StopPropagation()
    Log.debug("UIFishPage:onTestLeiShenChuiAwake")
    local mySeat = SeatRouter.instance.mySeat
    mySeat:playHammerAwake()
    self:onTestPanelClick()
end

function UIFishPage:onTestPanelClick()
    if self.testPanelOut.playing then
    else
        if self.testPanelIsOut then
            self.testPanelOut:PlayReverse(function()
                self.testPanelIsOut = false
            end)
        else
            self.testPanelOut:Play(function()
                self.testPanelIsOut = true
            end)
        end
    end
end
function UIFishPage:onMatchStartBtn()
    NetSender.StartMatchRoom();
end

function UIFishPage:onMatchPrepareBtn()
    NetSender.ReadyMatchRoom();
end

function UIFishPage:initBossZhangYu()
    local BossZhangYu = self.GameBgSceneAni.component
    -- for i = 0, 5 do
    --     local bg = BossZhangYu:GetChild("n" .. i)
    --     bg.width = self.view.width * 1.1
    --     bg.height = self.view.width * 1.1
    -- end
    FishLayer.instance:initBossZhangYu(self.GameBgSceneAni)
end

function UIFishPage:contestFightStart()
    self:onChallengeGameCloseClick()
    self:setContestEndTime()
end
function UIFishPage:setContestEndTime()
    self.ContestTimeGroup.y = 40
    self.ContestTimeGroup.visible = true
    self.ContestTimeText.text = "本局倒计时：" .. os.date("%M:%S", Fishery.instance.contestEndTime)
    if Fishery.instance.contestEndTime <= 0 then
        if self.matchTimer then
            self.matchTimer:clear()
            self.matchTimer = nil
        end
    else
        self.matchTimer = GameTimer.loop(1000, self, function()
            if Fishery.instance.contestEndTime <= 0 then
                self.matchTimer:clear()
                self.matchTimer = nil
                return
            end
            Fishery.instance.contestEndTime = Fishery.instance.contestEndTime - 1
            self.ContestTimeText.text = "本局倒计时：" .. os.date("%M:%S", Fishery.instance.contestEndTime)
        end)
    end
end

function UIFishPage:initChallengeGame()
    self.MatchGroup.visible = true
    self.MatchController.selectedPage = "Challenge"
    self.WaitText.text = "正在为您匹配对手，请稍等..."
    self.CancelChallengeBtn:onClick(self.onChallengeGameCloseClick, self)
    self.ChallengeTime = 0
    self.ChallengeTimeText.text = "0秒......"
    self:challengeGameStartCount()
end

function UIFishPage:challengeGameStartCount()
    self.tTimer = GameTimer.loop(1000, self, self.addTimeChallengeWait)
end

function UIFishPage:addTimeChallengeWait()
    self.ChallengeTime = self.ChallengeTime + 1
    self.ChallengeTimeText.text = self.ChallengeTime .. "秒......"
end

function UIFishPage:onChallengeGameCloseClick()
    NetSender.ExitChallengeRoom();
    self.MatchGroup.visible = false

    if self.tTimer then
        self.tTimer:clear()
    end
end

function UIFishPage:matchingSynRoomData()
    self.RoomText.text = MatchM.instance.roomName
end

function UIFishPage:initRedBox()
    self.redSpineGraph.visible = false
    local gainCoin = ActivityM.instance.gainCoin
    local targetCoin = ActivityM.instance.taskRequire
    local percent = gainCoin / targetCoin
    local differenceValue = ActivityM.instance.taskRequire - ActivityM.instance.gainCoin
    if (differenceValue >= 0) then
        self.redBar.value = self:getProgressValue()
    else
        self.redBar.value = 1
    end
    if (gainCoin >= cfg_task_red_reward.instance(1).taskNum) then
        self.redSpineGraph.visible = true;
        if (percent >= 1) then
            self.hint.text = "最多可领" .. tostring(ActivityM.instance.taskMoney[3]) .. "喇叭"--点击领取  元喇叭
        else
            self.hint.text = "最多可领" .. tostring(ActivityM.instance.lowMoney[3]) .. "喇叭"--点击领取  元喇叭
        end
    else
        self.redSpineGraph.visible = false;
        self.hint.text = "累计获取金币领取喇叭"--累计获取金币领取喇叭
    end
end

---@return number
function UIFishPage:getProgressValue()
    local lastPro = 0;
    --if ActivityM.instance.maxTaskId < 0 then
    --    return 0
    --end
    local totalPro = self.progressArr[ActivityM.instance.maxTaskId]
    local percent = (ActivityM.instance.gainCoin - ActivityM.instance.lowRequireCoin) / (ActivityM.instance.taskRequire - ActivityM.instance.lowRequireCoin);
    if (ActivityM.instance.maxTaskId > 1) then
        lastPro = self.progressArr[ActivityM.instance.maxTaskId - 1];
    else
        lastPro = 0;
    end
    percent = percent * (totalPro - lastPro) + lastPro;
    return percent;
end

function UIFishPage:refreshLeftBtn()
    --if (ActivityM.instance:redPackTicketContinueTime()) then
    --    if (FightM.instance.sceneId == GameConst.sceneId_1) then
    --        self.redBox.visible = false
    --    else
    --        self.redBox.visible = FightM.instance:coinShootScene()
    --    end
    --else
    --    self.redBox.visible = false
    --end

    self.onLineBox.visible = FightM.instance:coinShootScene();
    if self.onLineBox.visible then
        self.onlineAni:Play()
    end
end

function UIFishPage:initWelcomeAni()
    ---@type GComponent
    local item = UIPackage.CreateObject("Fish", "WelcomeAniItem")
    item.pivot = Vector2.New(0.5, 0.5)
    item.pivotAsAnchor = true
    item.position = Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    FishLayer.instance.effectLayer:AddChild(item)
    local LevelLoader = item:GetChild("LevelLoader")
    local NameLoader = item:GetChild("NameLoader")
    local leftAni = item:GetTransition("LeftPartAni")
    local rightAni = item:GetTransition("RightPartAni")
    LevelLoader.url = "ui://Fish/welcome_" .. FightM.instance.sceneId
    NameLoader.url = "ui://Fish/welcome_boss_" .. FightM.instance.sceneId
    leftAni:SetValue("leftStartPos", 0 - item.width, 0)
    rightAni:SetValue("rightStartPos", GameScreen.instance.adaptWidth + NameLoader.width, 0)
    leftAni:Play()
    rightAni:Play(function()
        GameTimer.once(200, self, function()
            item:Dispose()
        end)
    end)
end

function UIFishPage:unlockbattery()
    NetSender.UnlockBattery();
    --刷新解锁炮台弹出提示
    self.unlockBatteryTip = false
    self.unlockBatteryTipTime = os.time()
end

function UIFishPage:clickBoxTwo()
    GameEventDispatch.instance:Event(GameEvent.Shop, GameConst.shop_tab_diamond);
end

function UIFishPage:batteryBuyRet()

    self:updatePower()
    self:initDoubleRate()
end

function UIFishPage:updateFishCount()

    self:updateLottery()
    --判断炮台升级
    self:updatePower()

    self:updateAwardCount()
    self:updatePower()

end

function UIFishPage:updateLottery()
    local rewardCoinCount = RoleInfoM.instance:getFcoin();
    local rewardFishCount = RoleInfoM.instance:getFcount();
    if rewardFishCount >= RewardM.instance:baseFishCount() then
        rewardFishCount = RewardM.instance:baseFishCount()
        if (RewardM.instance:isShowScene() == false) then
            self.lotteryBoxOne.visible = true;
            self.lotterySpineBox.visible = true;
            self.lotteryBtnSpineBox.visible = true;
        else
            self.lotteryBoxOne.visible = false;
            self.lotterySpineBox.visible = false;
            self.lotteryBtnSpineBox.visible = false;
        end
    else
        self.lotteryBoxOne.visible = true;
        self.lotterySpineBox.visible = false;
        self.lotteryBtnSpineBox.visible = false;
    end
    self.lotteryPro.value = tonumber(rewardFishCount / RewardM.instance:baseFishCount());
    self.curLotteryPro.text = rewardFishCount .. "/" .. RewardM.instance:baseFishCount();
    self.prizePool.text = rewardCoinCount;

end

function UIFishPage:setLotteryBtn()
    self.lotteryBtn.visible = RewardM.instance:isRewardShowScene();
    self.lotteryTxt.visible = self.lotteryBtn.visible;
    self:setUnlockBtn()
end

function UIFishPage:setUnlockBtn()
    if self.lotteryBtn.visible then
        self.gunImg.y = self.lotteryBtn.y - 142;
    else
        self.gunImg.y = self.lotteryBtn.y;
    end
end

function UIFishPage:clickGunImg()
    if self.unLockInside and (not self.unLockOut) then
        self.unLockInside = false;
        self.collectTween:Play(self:collectComplete())
    elseif self.unLockOut and (not self.unLockInside) then
        self.unLockOut = false;
        self.releaseTween:Play(self:releaComplete())
    end
    self:updatePower()
end

function UIFishPage:updatePower()
    self.gunImg.visible = true
    local power = GunM.instance:getNextPower(RoleInfoM.instance:getBattery())
    if (power < 0) then
        self.gunImg.visible = false;
        --self.battery_icon_bg.visible = false;
        self.gunBoxOne.visible = false;
        self.gunBoxTwo.visible = false;
        self.gunBtnSpineBox.visible = false;
        self.unlockSpineBox.visible = false;
        self:deblockComeEffect()
        return
    end
    local needCount = GunM.instance:needDiamod(RoleInfoM.instance:getBattery())
    local haveCount = RoleInfoM.instance:getDiamond()
    local giveCount = GunM.instance:giveCount(RoleInfoM.instance:getBattery())
    self:updatePowerData(power, haveCount, needCount, giveCount)
end

function UIFishPage:updatePowerData(power, haveCount, needCount, giveCount)
    if (haveCount >= needCount) then
        self.gunBoxOne.visible = true;
        self.gunBoxTwo.visible = false;
        self.gunBtnSpineBox.visible = true;
        self.unlockSpineBox.visible = true;
        --self.battery_icon_bg.visible = true;
        if (self.isAuto) then
            self.isAuto = false;
            self:deblockComeEffect()
            self.unlockBatteryTip = true
            self.unlockBatteryTipTime = os.time()
        end
    else
        self.isAuto = true;
        self.gunBoxOne.visible = false;
        self.gunBoxTwo.visible = true;
        self.gunBtnSpineBox.visible = false;
        self.unlockSpineBox.visible = false;
        --self.battery_icon_bg.visible = false;
    end
    if (power < 0) then
        self.gunImg.visible = false;
        --battery_icon_bg.visible = false;
        self.gunBoxOne.visible = false;
        self.gunBoxTwo.visible = false;
        self.gunBtnSpineBox.visible = false;
        self.unlockSpineBox.visible = false;
    end
    self.ptxt1.text = "点击解锁" .. power .. "倍炮"
    self.ptxt2.text = "点击解锁" .. power .. "倍炮"
    self.yZuan.text = haveCount
    self.needZ.text = needCount
    self.rewardCount.text = giveCount
    self.proBar.value = haveCount / needCount
end

function UIFishPage:deblockComeEffect()
    if self.unLockInside then
        self.unLockInside = false;
        self.collectTween:Play(self:collectComplete())
    end
end

function UIFishPage:collectComplete()
    self.unLockOut = true;
    self.unLockInside = false;
end

function UIFishPage:deblockGoEffect()
    if self.unLockOut then
        self.unLockOut = false;
        self.releaseTween:Play(self:releaComplete())
    end
end

function UIFishPage:releaComplete()
    self.unLockOut = false;
    self.unLockInside = true;
end

function UIFishPage:exitFight()
    self:onChallengeGameCloseClick()
    Game.instance.fsm:changeState(StateGameMain)
end

function UIFishPage:initBar()
    self.bar.x = -420;
    self.ele_jinBtn.visible = false;
    self.ele_chuBtn.visible = true;
end

function UIFishPage:initBtn()
    if ActivityM.instance:redPackTicketContinueTime() then
        if Fishery.instance.sceneId == FightConst.sceneId_1 then
            self.redBox.visible = false
        else
            self.redBox.visible = FightM.instance:coinShootScene()
        end
    else
        self.redBox.visible = false
    end
end

function UIFishPage:initTask()
    if FightM.instance:isShowScene() then
        self.taskView.visible = false
    else
        self.taskView.visible = true
    end

    self:refreshTask();
end

function UIFishPage:refreshTask()
    local task_ids = RoleInfoM.instance:getTaskDailyIds();
    local confs = ConfigManager.filter("cfg_task", function(item)
        return table.indexOf(task_ids, item.id) > -1
    end);
    local taskData = RoleInfoM.instance:getTaskDaily()
    local finish_arr = {};
    for k, v in pairs(confs) do
        local task_id = v.id;
        local percent = TaskC.instance:taskPercent(taskData, v)
        local old_percent = 0
        if self.task_percent[task_id] then
            old_percent = self.task_percent[task_id]
        end

        self.task_percent[task_id] = percent

        local is_accept = table.indexOf(taskData.rec_ids, v.id) > -1;
        local is_finish = percent == 1;
        local index = table.indexOf(self.unFinish_arr, task_id)
        if table.indexOf(self.unFinish_arr, task_id) < 0 then
            table.insert(self.unFinish_arr, task_id)
        end

        if is_accept then
            if index >= 0 then
                table.splice(self.unFinish_arr, index)
            elseif is_finish then
                if index >= 0 then
                    table.splice(self.unFinish_arr, index)
                    table.insert(self.unFinish_arr, task_id)
                end
            else
                if index < 0 then
                    table.insert(self.unFinish_arr, task_id)
                else
                    if percent > old_percent then
                        table.splice(self.unFinish_arr, index)
                        table.insert(self.unFinish_arr, 1, task_id)
                    end
                end
            end
        end


    end

    if table.len(finish_arr) > 0 then
        local task_id = finish_arr[1];
        local taskConfig = cfg_task.instance(task_id)
        local rewards = {}

        for i = 1, #taskConfig.reward_item_ids do
            table.insert(rewards, { reward_item_id = taskConfig.reward_item_ids[i], reward_item_num = taskConfig.reward_item_nums[i] })
        end

        ListManager.creat(self.list_reward, rewards, self.listRewardUpdate, self)

        self.list_reward.visible = true;
        self.click_a.visible = true;
        self.p_task.visible = false;
        self.p_txt.visible = false;
        --_task_spine.visible = true;
        self.task_icon.visible = false;
        self.task_icon_bg.visible = false;
        self.task_icon.icon = taskConfig.img_url_down;
        self.task_name.text = taskConfig.task_name_down;
        self.task_name.visible = false;

        if not FightM.instance:isShowScene() then
            self.taskView.visible = true;
        end

        self.bgBtn:onClick(function()
            self:finishTask(task_id)
        end)

    elseif table.len(self.unFinish_arr) > 0 then
        local task_id = self.unFinish_arr[1]
        local taskConfig = cfg_task.instance(task_id)
        local percent = TaskC.instance:taskPercent(taskData, taskConfig)
        self.p_task.visible = true;
        self.p_txt.visible = true;
        self.p_txt.text = TaskC.instance:getCurTaskValue(taskData, taskConfig) .. "/" .. taskConfig.task_value_n
        self.p_task.value = percent;
        self.list_reward.visible = false;
        self.click_a.visible = false;
        self.task_name.text = taskConfig.task_name
        self.task_name.visible = true;
        --_task_spine.visible = false;
        self.task_icon.visible = true;
        self.task_icon.icon = taskConfig.img_url_down;
        self.task_icon_bg.visible = true;

        if not FightM.instance:isShowScene() then
            self.taskView.visible = true;
        end

        self.bgBtn:onClick(self.taskDaily, self)
    else
        self.taskView.visible = false;
    end

    if (not FightM.instance:coinShootScene()) then
        self.taskView.visible = false;
    end
end

function UIFishPage:refreshTaskTotal()
    self.task_percent = {}
    self.unFinish_arr = {}
    self:refreshTask()
end

function UIFishPage:finishTask(task_id)
    local a
    a.task_id = task_id;
    a.is_daily = true;
    --服务端功能不在了
    --WebSocketManager.instance.send(19000, a);
end

function UIFishPage:taskDaily()
    GameEventDispatch.instance:Event(GameEvent.RefreshTaskDaily);
    UIManager:LoadView("TaskDailyPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIFishPage:initSkillView()
    self.boomTotal = 0;
    self.boomListDate = GameConst.SKILL_ID_BOOM_ARR;
    self.BoomListManager = ListManager.creat(self.boomList, self.boomListDate, self.refreshHandle, self)
end

function UIFishPage:refreshHandle(i, cell, data)
    local ele_icon = cell:GetChild("icon")
    local ele_count = cell:GetChild("skillCount")
    local ele_cancel = cell:GetChild("cancelBoom")

    local config = cfg_goods.instance(cfg_skill.instance(data).need_prop)
    self.boomTotal = self.boomTotal + SkillM.instance:skillCount(config.typeID)
    ele_icon.url = config.icon
    ele_cancel.visible = false
    ele_count.text = SkillM.instance:skillCount(config.typeID)
    cell:onClick(function()
        if ele_cancel.visible or not Fishery.instance.fsm:isInState(StateFisheryBoom) then
            self:onUseBoom(config.typeID, ele_cancel)
        end
    end)
    if self.boomTotal < 0 then
        self.boomTotal = 0
    end
end

function UIFishPage:goodsUpdate()
    self:initSkillView()
end

function UIFishPage:SyncSkillCount(skillId, skillLabel, skillCase, consume, needDiamond)

    if SkillM.instance:skillCount(skillId) > 0 then
        skillLabel.visible = true;
        skillCase.visible = true;
        consume.visible = false;
        skillLabel.text = SkillM.instance:skillCount(skillId)
        needDiamond.visible = false;
    else
        skillCase.visible = false;
        skillLabel.visible = false;
        consume.visible = true
        needDiamond.visible = true;
        needDiamond.text = SkillM.instance:skillDiamondCount(skillId);
    end
end

function UIFishPage:onAutoBtnClick()
    local seat = SeatRouter.instance.mySeat
    if seat:isInState(StateSeatRange) or seat:isInState(StateSeatWait) then
        GameTip.showTipById(74)
        return
    end
    SeatRouter.instance.mySeat:onClickAuto()
end

function UIFishPage:onChuClick()
    GTween.To(self.bar.x, -50, 0.5):OnUpdate(
            function(tweener)
                self.bar.x = tweener.value.x;
            end
    )
    self.ele_chuBtn.visible = false;
    self.ele_jinBtn.visible = true;
end

function UIFishPage:onJinClick()
    GTween.To(self.bar.x, -420, 0.5):OnUpdate(
            function(tweener)
                self.bar.x = tweener.value.x;
            end
    )
    self.ele_chuBtn.visible = true;
    self.ele_jinBtn.visible = false;
end

function UIFishPage:onAddClick()
    self:addPower(1);
end

function UIFishPage:onReduceClick()
    ------------------
    self:addPower(-1);
end

function UIFishPage:addPower(offset)
    if offset == nil then
        return
    end
    local mySeat = SeatRouter.instance.mySeat
    if mySeat:isInState(StateSeatRange) or mySeat:isInState(StateSeatWait) then
        GameTip.showTipById(74)
        return
    end
    local sceneId = Fishery.instance.sceneId
    local useBattery = mySeat.battery

    local nextBattery = useBattery

    local ownBattery = RoleInfoM.instance:getBattery()
    local sceneType = ConfigManager.getConfValue("cfg_scene", sceneId, "type")
    local MinMagBattery = nil
    local MaxMagBattery = nil
    if sceneType == 1 then
        --是否是比赛场
        --这里获取的是场景中的炮倍
        MinMagBattery = ConfigManager.getConfValue("cfg_scene", sceneId, "min_mag")
        MaxMagBattery = ConfigManager.getConfValue("cfg_scene", sceneId, "max_mag")
    else
        MinMagBattery = ConfigManager.getConfValue("cfg_battery", ownBattery, "min_battery")
        MaxMagBattery = ConfigManager.getConfValue("cfg_battery", ownBattery, "degree")
    end

    nextBattery = nextBattery + offset

    if nextBattery > ownBattery or nextBattery > MaxMagBattery then
        nextBattery = MinMagBattery
    end

    if nextBattery < MinMagBattery then
        nextBattery = math.min(ownBattery, MaxMagBattery)
    end
    if nextBattery == MaxMagBattery and offset > 0 then
        GameTip.showTipById(75)

    end
    if nextBattery == MinMagBattery and offset < 0 then
        GameTip.showTipById(76)

    end

    local protoData = {};
    protoData.skin = 0
    protoData.battery = nextBattery
    NetSender.ChangeBatterySkin( protoData)
end

function UIFishPage:onCoinBtnClick()
    if RoleInfoM.instance():canDoubelCoin() then
        if RoleInfoM.instance().coin_rate == 1 then
            NetSender.ChangeDoubleGoldOrRate( { coin = 2 })
        else
            NetSender.ChangeDoubleGoldOrRate( { coin = 1 })
        end
    else
        self:unLockDoubleCoin()
    end
end
function UIFishPage:unLockDoubleCoin()
    local info = ConfirmTipInfo.new();
    info.content = "解锁10000倍炮时可免费激活，是否使用500钻石立即激活？";
    info.rightClick = function()
        self:unlockDouble("coin")
    end
    info.autoCloseTime = 10;
    GameTip.showConfirmTip(info)
end

function UIFishPage:onChanceBtnClick()
    if RoleInfoM.instance():canDoubelChance() then
        if RoleInfoM.instance().chance_rate == 1 then
            NetSender.ChangeDoubleGoldOrRate({ chance = 2 })
        else
            NetSender.ChangeDoubleGoldOrRate( { chance = 1 })
        end
    else
        self:unLockDoubleChance()
    end
end

function UIFishPage:unLockDoubleChance()
    local info = ConfirmTipInfo.new();
    info.content = "解锁2000倍炮时可免费激活，是否使用500钻石立即激活？";
    info.rightClick = function()
        self:unlockDouble("chance")
    end

    info.autoCloseTime = 10;
    GameTip.showConfirmTip(info)
end

function UIFishPage:unlockDouble(type)
    NetSender.UnlockDoubleGoldOrRate({ type = type })
end

function UIFishPage:initDoubleRate()
    if 1 then
        return
    end
    local cfg = cfg_scene.instance(Fishery.instance.sceneId);
    self.DoubleCoinBtn.visible = false
    self.CancelCoinBtn.visible = false;
    self.doubleCoinLock.visible = false;
    self.DoubleCoinLockBg.visible = false;

    self.DoubleChanceBtn.visible = false
    self.CancelChanceBtn.visible = false
    self.doubleChanceLock.visible = false
    self.DoubleChanceLockBg.visible = false
    if cfg.doubleRate[1] == 1 then
        self.DoubleCoinBtn.visible = true
        if RoleInfoM.instance:canDoubelCoin() then
            self.doubleCoinLock.visible = false;
            self.DoubleCoinLockBg.visible = false;
            if RoleInfoM.instance.coin_rate == 1 then
                self.CancelCoinBtn.visible = false;
            else
                self.CancelCoinBtn.visible = true;
            end
        else
            self.doubleCoinLock.visible = true
            self.DoubleCoinLockBg.visible = true
        end
    end

    if cfg.doubleRate[2] == 1 then
        self.DoubleChanceBtn.visible = true
        if RoleInfoM.instance:canDoubelChance() then
            self.doubleChanceLock.visible = false
            self.DoubleChanceLockBg.visible = false;
            if RoleInfoM.instance().chance_rate == 1 then
                self.CancelChanceBtn.visible = false;
            else
                self.CancelChanceBtn.visible = true;
            end
        else
            self.doubleChanceLock.visible = true
            self.DoubleChanceLockBg.visible = true
        end
    end
end

function UIFishPage:initIntegral()
    self.IntegralView.visible = RuleM.instance:isShowScene()
    self:updateAwardCount()
    self:updateCoinCount()
end

function UIFishPage:updateAwardCount()
    self.totalIntegral.text = "积分:" .. math.floor(RoleInfoM.instance:getAwardScore())
end

function UIFishPage:updateCoinCount()
    self.totalCoin.text = FightM.instance:getGoldPoolTotalValue()
end

function UIFishPage:update()
    self.isUpdate = true
end

function UIFishPage:updateTime()
    if self.isUpdate then
        RuleM.instance:second(RuleM.instance:second() - 1)
        if RuleM.instance:second() == -1 then
            RuleM.instance:second(59)
            RuleM.instance:minute(RuleM.instance:minute() - 1)
            if RuleM.instance:minute() < 0 then
                RuleM.instance:minute(59)
            end
        end
        self.currentTime.text = RuleM.instance:showTime()
    end
    self:startTime()
end

function UIFishPage.remainTime(id)
    local seat = SeatRouter.instance.mySeat
    local cdLeftTime = seat:getSkillCdLeftTime(id);
    if cdLeftTime <= 0 then
        cdLeftTime = 0
    end
    return cdLeftTime;
end

function UIFishPage.skillTime(id)
    return ConfigManager.getConfValue("cfg_skill", id, "cd");
end

function UIFishPage:onUseBoom(boomSkillId, cancelBtn)
    if Fishery.instance.fsm:isInState(StateFisheryBoom) then
        Fishery.instance:cancelBoom()
        cancelBtn.visible = false
    else
        local seat = SeatRouter.instance.mySeat
        seat:useSkill(boomSkillId, cancelBtn)
    end
end

---@param e EventContext
function UIFishPage:onChangeSkinClick(e)
    UIManager:LoadView("ChangeSkinPage")
end

function UIFishPage:onLotteryBoxClick()
    UIManager:LoadView("RewardPage")
    self.lotteryIn:Play()
    self.isLotteryBoxShowing = false;
end

function UIFishPage:onLotteryClick()
    if self.isLotteryBoxShowing then
        self.lotteryIn:Play()
        self.isLotteryBoxShowing = false;
    else
        self.lotteryOut:Play(self:lotteryOutComplete())
    end
end

function UIFishPage:lotteryOutComplete()
    self.isLotteryBoxShowing = true;
end

function UIFishPage:onFishTypeClick()
    UIManager:LoadView("FishTypePage")
end

function UIFishPage:onRedBtn()
    UIManager:LoadView("RedPage")
end

function UIFishPage:onSettingClick()
    UIManager:LoadView("SettingPage")
end

function UIFishPage:onRuleClick()
    UIManager:LoadView("RulePage")
end

function UIFishPage:onBackClick()
    local info = ConfirmTipInfo.New();
    info.content = "是否退出房间？";
    info.rightClick = function()
        GameEventDispatch.instance:event(GameEvent.ReturnConfirm)
    end
    info.autoCloseTime = 10;
    GameTip.showConfirmTip(info)
end

function UIFishPage:onFightUpdate()
    FightM.instance:update(Time.deltaTime);
end

function UIFishPage:fightReturn()
    NetSender.ExitRoom();
end

---@param context EventContext
function UIFishPage:onTouchMove(context)
    local mySeat = SeatRouter.instance.mySeat
    FightTools.TEMP_POINT1.x = context.inputEvent.x
    FightTools.TEMP_POINT1.y = context.inputEvent.y
    FightTools.TEMP_POINT2 = GRoot.inst:GlobalToLocal(FightTools.TEMP_POINT1);
    mySeat:onMouseMove(FightTools.TEMP_POINT2.x, FightTools.TEMP_POINT2.y)
end

---@param context EventContext
function UIFishPage:onTouchEnd(context)
    local mySeat = SeatRouter.instance.mySeat
    mySeat:onMouseUp()
end

---@param context EventContext
function UIFishPage:onTouchBegin(context)
    context:CaptureTouch()
    local mySeat = SeatRouter.instance.mySeat

    FightTools.TEMP_POINT1.x = context.inputEvent.x
    FightTools.TEMP_POINT1.y = context.inputEvent.y
    FightTools.TEMP_POINT2 = GRoot.inst:GlobalToLocal(FightTools.TEMP_POINT1);
    mySeat:onMouseDown(FightTools.TEMP_POINT2.x, FightTools.TEMP_POINT2.y)
end


--
--
--function UIFishPage:onTouchBegin(context)
--    self.animation:Play(0, "animation", true)
--    self:MouseDown()
--end
--
--function UIFishPage:onTouchEnd()
--    self.animation:Play(0, "daiji", true)
--end

function UIFishPage:onAddAgentGetInfo(agentGetInfo)
    FightM.instance:addAgentGetInfo(agentGetInfo);
end

function UIFishPage:onLineReward()
    self._leftTime = OnLineM.instance:getLeftTime()
    self:refreshOnline();

end

function UIFishPage:clickReceive()
    if (self.countBox.data == true) then
        local s2c = { id = OnLineM.instance:getRewardIndex() }
        NetSender.GetOnlineReward( s2c);
    else
        GameTools.buttonEffect(self.receiveImg, 0.8, 0.8);
    end
end

function UIFishPage:starRefreshOnline()
    OnLineM.instance:setIsAni(true)
    self:refreshOnline();
end

function UIFishPage:refreshOnline()
    local obj = OnLineM.instance:getAwardState(OnLineM.instance:getRewardIndex());
    self.onlineCount.text = tostring(obj.count);
    self.receiveImg.icon = GameTools.transLayaUrl(obj.rewardUrl)
    self.receiveImg.visible = obj.isTimeVisible
    self.receiveImg.y = 237;
    self.countBox.data = obj.enable;
    self.leftTime.visible = obj.isTimeVisible;
    self.getImg.visible = not obj.isTimeVisible
    self.timeBox.visible = obj.isVisible;
    self.countBox.visible = obj.isVisible;
    self.lqjlani.visible = not obj.isTimeVisible;
    self._onlineCount = obj.count;
end

function UIFishPage:receive()
    OnLineM.instance:setIsAni(false)
    self._leftTime = OnLineM.instance:getLeftTime()
    self.getImg.visible = false;
    self.leftTime.visible = true;
    self:refreshOnline();
    self.receiveImg.icon = GameTools.transLayaUrl("ui/fish/lqjl_2.png")
    GameTimer.once(500, self, self.refreshOnline);
end

function UIFishPage:startTime()
    if (self._leftTime >= 1) then
        self._leftTime = self._leftTime - 1
        self:updateOnlintTime(self._leftTime);
    end
end

---@param time number
function UIFishPage:updateOnlintTime(time)
    if (time <= 0) then
        time = 0
    end
    self.leftTime.text = tostring(GameTools.timeUtils(time));
end

function UIFishPage:playChangeScene(scene_id)
    self.changeScene.visible = true
    local cur_scene = Fishery.instance.sceneId
    Fishery.instance.sceneId = scene_id
    FightM.instance.sceneId = scene_id
    Fishery.instance:changeOut()
    self.changeScene.component:GetChild("scene").url = "ui://FishChangeScene/scene_" .. scene_id
    self.changeScene.component:GetTransition("change"):Play(function()
        self.changeScene.visible = false
    end)
    self.changeScene.component:GetTransition("scene_" .. cur_scene):Play()
    self.waterSpeed = 0.4

    GameTimer.once(4200, self, function()
        self:refreshBg()
        Fishery.instance:playFisheryMusic()
    end)
    GameTimer.once(4200, self, function()
        self.waterSpeed = -0.4
    end)

    if scene_id == 2 or scene_id == 3 then
    else
        self.view:GetTransition("change"):Play(1, 6, function()
        end)

    end
end
return UIFishPage