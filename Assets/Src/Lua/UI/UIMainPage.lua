---@class UIMainPage :UIBase
local UIMainPage = class("UIMainPage", UIBase)
local AssetBundle = UnityEngine.AssetBundle
local Application = UnityEngine.Application
--function UIMainPage:ctor()
--    构造函数，如果没有特殊传参需求，不需要动
--end

--@override 复写父类init
function UIMainPage:init()
    self.packageName = "Main"
    self.resName = "MainPage"

    self.levelListManager = nil
end

-- @override 派生类可重写
--function UIMainPage:loadPackage()
--    
--    self.view = UIPackage.CreateObject(self.packageName, self.resName)
--    assert(self.view, "创建界面出错！")
--    GRoot.inst:AddChild(self.view)
--end

-- @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
function UIMainPage:initComponent()
    --SoundManager.StopMusic()
    --获取对象
    self.levelList = self.view:GetChild("levelList")
    self.mainBox = self.view:GetChild("mainBox")
    self.classicBtn = self.view:GetChild("classicBtn")
    self.classicBtnEvent = self.view:GetChild("classicBtnEvent")
    self.matchBtn = self.view:GetChild("matchBtn")
    self.matchBtnEvent = self.view:GetChild("matchBtnEvent")
    self.activityBtn = self.view:GetChild("activityBtn")
    self.xiaoyouxiBtn = self.view:GetChild("xiaoyouxiBtn")
    self.activityBtnEvent = self.view:GetChild("activityBtnEvent")
    self.fastBtn = self.view:GetChild("fastBtn")
    self.taskNewBtn = self.view:GetChild("taskNewBtn")

    self.avatarBtn = self.view:GetChild("avatarBtn")
    self.backBtn = self.view:GetChild("backBtn")
    self.settingBtn = self.view:GetChild("settingBtn")
    self.insideBtn = self.view:GetChild("insideBtn")
    self.shopBtn = self.view:GetChild("shopBtn")
    self.exchangeBtn = self.view:GetChild("exchangeBtn");
    self.packBtn = self.view:GetChild("packBtn");
    self.rankBtn = self.view:GetChild("rankBtn");
    self.bankBtn = self.view:GetChild("bankBtn");
    self.registerBtn = self.view:GetChild("registerBtn");
    self.subscriptionBtn = self.view:GetChild("subscriptionBtn");
    self.monthBtn = self.view:GetChild("monthBtn");
    self.firstChargeBtn = self.view:GetChild("firstChargeBtn");
    self.redPackBtn = self.view:GetChild("redPackBtn");
    self.certificationBtn = self.view:GetChild("certificationBtn");

    self.bg = self.view:GetChild("n0")

    self.user_id = self.view:GetChild("user_id")
    self.playimg = self.view:GetChild("playimg")
    self.nickname = self.view:GetChild("nickname")
    self.diamodBox = self.view:GetChild("diamondCount")
    self.diamondCount = self.view:GetChild("diamondCount")
    self.addDiamondBtn = self.view:GetChild("addDiamondBtn")
    self.goldBox = self.view:GetChild("goldBox")
    self.addCoinBtn = self.view:GetChild("addCoinBtn")
    self.goldCount = self.view:GetChild("goldCount")
    self.exchange_box = self.view:GetChild("exchange_box")
    self.exchangeCount = self.view:GetChild("exchangeCount")
    self.levelCount = self.view:GetChild("levelCount")

    --注册监听
    --self.view:onClick(self.OnClick, self)
    self.classicBtnEvent:onClick(self.openGameEvent, self, self.classicBtnEvent.name)
    self.matchBtnEvent:onClick(self.openGameEvent, self, self.matchBtnEvent.name)
    self.activityBtnEvent:onClick(self.openGameEvent, self, self.activityBtnEvent.name)
    self.fastBtn:onClick(self.OnFishView, self)
    self.avatarBtn:onClick(self.openInfoView, self)
    self.playimg.onClick:Set(self.openInfoView, self)
    self.backBtn:onClick(self.onBackBtn, self)
    self.settingBtn:onClick(self.OnSettingView, self)
    self.certificationBtn:onClick(self.onCertificationBtn, self)
    self.addCoinBtn:onClick(self.addCoin, self)
    self.addDiamondBtn:onClick(self.addDiamond, self)
    self.insideBtn:onClick(self.onInside, self)

    --下方按钮
    self.shopBtn:onClick(self.OnShopView, self)
    self.exchangeBtn:onClick(self.OnExchangeView, self)
    self.packBtn:onClick(self.OnPackView, self)
    self.rankBtn:onClick(self.OnRankView, self)
    self.registerBtn:onClick(self.OnRegisterView, self)
    self.bankBtn:onClick(self.OnBankView, self)
    --右侧按钮
    self.redPackBtn:onClick(self.OnRedPackView, self)
    --左侧按钮
    self.monthBtn:onClick(self.OnMonthCardView, self)
    self.firstChargeBtn:onClick(self.OnFirstChargeView, self)

    self.taskNewBtn:onClick(self.onTaskNewBtn, self)
    --初始化骨骼动画
    self:initSpine()
end


-- 方法名大驼峰，public

--@override 注册事件监听
function UIMainPage:Register()
    LoginM.instance.pageId = GameConst.MAIN_PAGE
    self:AddRegister(GameEvent.UpdateProfile, self, self.profileUpdate);
    self:AddRegister(GameEvent.OpenBankView, self, self.openBankView);
    self:AddRegister(GameEvent.SyncBankCoin, self, self.setBindTel);
    self:AddRegister(GameEvent.ShowRedPoint, self, self.showRedPoint);
    self:AddRegister(GameEvent.UpdateFirstCharge, self, self.initFirstChargeBtn);
    self:AddRegister(GameEvent.SyncActivityStatus, self, self.syncActivityStatus);
    self:AddRegister(GameEvent.SyncCertificationInfo, self, self.refreshCertificationInfo);
    self:AddRegister(GameEvent.UpdateExchange, self, self.updateExchange);
end

-- @override 派生类可重写
--@param  param  @type: table, 打开界面时传递的参数
function UIMainPage:StartGames(param)
    --self:resetIcon();
    LoginM.instance.pageId = GameConst.MAIN_PAGE
    self:profileUpdate();
    local preSceneId = null;
    if param then
        if param.preSceneId then
            preSceneId = param.preSceneId;
        end
    end

    self:initMainBox(preSceneId)
    self:initFirstChargeBtn()
    self:syncActivityStatus()
    self:refreshCertificationInfo()
    self:showRedPoint()
end

function UIMainPage:refreshCertificationInfo()
    if LoginM.instance:isCompleteCertification() == 1 then
        self.certificationBtn.visible = false
    else
        self.certificationBtn.visible = true
    end
end

function UIMainPage:updateExchange()
    self.exchangeCount.text = tostring(RoleInfoM.instance:getExchange())
end

function UIMainPage:profileUpdate()
    local tmpCoin = (RoleInfoM.instance:getCoin() - RuleM.instance:coinCount() + RoleInfoM.instance:getBindCoin())
    GameTools.loadHeadImage(self.playimg, RoleInfoM.instance:getAvatar())
    --if RoleInfoM.instance:getAvatar() then
    --    if (self.playimg.icon ~= RoleInfoM.instance:getAvatar()) then
    --        GameTools.loadHeadImage(self.playimg, RoleInfoM.instance:getAvatar())
    --    end
    --end
    --if type(RoleInfoM.instance:getAvatar())=='string' then
    --    self.playimg.icon=RoleInfoM.instance:getAvatar()
    --end
    local diamond = RoleInfoM.instance:getDiamond()
    if tmpCoin < 0 then
        tmpCoin = 0
    end
    local coin = tostring(tmpCoin)
    self.goldCount.text = coin
    self.diamondCount.text = tostring(diamond)
    self.exchangeCount.text = tostring(RoleInfoM.instance:getExchange())
    self.levelCount.text = "Lv." .. tostring(RoleInfoM.instance:getLevel())
    self.nickname.text = GameTools.filterName(FightTools:formatNickName(RoleInfoM.instance:getName()))
    self:setBindTel();
end

function UIMainPage:syncActivityStatus()
    --TODO 目前有右边btn只有红包
    --shareBtn.visible = ENV.openSharePage;
    --useTicketBtn.visible = ActivityM.instance.activityTicketContinueTime;
    self.redPackBtn.visible = ActivityM.instance:redPackTicketContinueTime();
    --self:resetRightBtn();
    self.exchange_box.visible = ActivityM.instance:redPackTicketContinueTime()
end

function UIMainPage:initSpine()
    local bg = SpineManager.create("ui/PageEffects/MainPageBg", Vector3.New(0, 0, 1000), 1, self.bg)
    local classicBtnSpine = SpineManager.create("ui/PageEffects/JingDianMoShi", Vector3.New(0, 0, 1000), 1, self.classicBtn)
    local matchBtnSpine = SpineManager.create("ui/PageEffects/JingJiChang", Vector3.New(51, 0, 1000), 1, self.matchBtn)
    local xiaoyouxiBtnSpine = SpineManager.create("ui/PageEffects/XiaoYouXi", Vector3.New(0, 0, 1000), 1, self.xiaoyouxiBtn)
    local activityBtnSpine = SpineManager.create("ui/PageEffects/HaiYaoChaoXue", Vector3.New(0, 0, 1000), 1, self.activityBtn)
    bg:play("animation", true)
    bg:setScale(GameScreen:screenScaleX(), GameScreen:screenScaleY())
    classicBtnSpine:play("animation", true)
    matchBtnSpine:play("animation", true)
    xiaoyouxiBtnSpine:play("animation", true)
    activityBtnSpine:play("animation", true)

    if self.levelListManager == nil then
        local listData = ConfigManager.filter("cfg_scene", function(conf)
            return conf.type == 0 and conf.hidden_battery_level > RoleInfoM.instance:getBattery()
        end, function(a, b)
            return a.id < b.id
        end)
        for i = 1, #listData do
            listData[i].is_match = false
        end
        self.levelListManager = ListManager.creat(self.levelList, listData, self.updateItem, self)
    end
end

function UIMainPage:initMainBox(preSceneId)
    --if preSceneId == 1 or preSceneId == 2 or preSceneId == 3 or preSceneId == 4 then
    --    self.mainBox.visible = false
    --    self.levelList.visible = true
    --    self.backBtn.visible = true
    --    self.settingBtn.visible = false
    --else
    self.levelList.visible = false;
    self.backBtn.visible = false;
    self.mainBox.visible = true;
    self.settingBtn.visible = true;
    --end

    local listData = ConfigManager.filter("cfg_scene", function(conf)
        return conf.type == 0 and conf.hidden_battery_level > RoleInfoM.instance:getBattery()
    end, function(a, b)
        return a.id < b.id
    end)
    for i = 1, #listData do
        listData[i].is_match = false
    end
    if listData ~= self.levelListManager.data then
        self.levelListManager:update(listData)
    end
end

function UIMainPage:updateItem(index, cell, config)
    local battery = RoleInfoM.instance:getBattery()
    local lockBox = cell:GetChild("lockBox");
    local unlockTxt = cell:GetChild("unlockTxt");
    local img = cell:GetChild("image");
    local btn = cell:GetChild("btn");
    if img.displayObject then
        img.displayObject:RemoveFromParent()
        img.displayObject:Dispose()
    end
    local spineAni = SpineManager.create("ui/PageEffects/" .. config.spine_name, Vector3.New(250, -250, 1000), 1.2, img)
    spineAni:play("animation", true)
    lockBox.visible = false;
    unlockTxt.text = tostring(config.unlockImage)

    if (battery < config.unlock) then
        lockBox.visible = true;
    end
    btn.data = config
    btn:onClick(self.OnEnterScene, self);
end

function UIMainPage:OnEnterScene(context)
    local config = context.sender.data
    local batteryLevel = RoleInfoM.instance:getBattery()
    if (batteryLevel >= config.unlock) then
        Log.debug("UIMainPage:OnEnterScene", encode(config))
        local a = {}
        a["scene_id"] = config.id;
        --a["scene_id"] = 1;
        NetSender.EnterRoom(a)
    else
        GameTip.showTipById(config.msg_tip_id)
    end
end

function UIMainPage:openGameEvent(context)
    local type = context
    if type == "classicBtnEvent" then
        --self.mainBox.visible = false
        --self.levelList.visible = true
        --self.backBtn.visible = true
        --self.settingBtn.visible = false
        local a = {}
        a["scene_id"] = 9;
        NetSender.EnterRoom(a)
    elseif type == "matchBtnEvent" then
        self:onMatchBtnClick()
    elseif type == "activityBtnEvent" then
        Log.debug("活动暂未开启!!!!")
    end
end

function UIMainPage:onBackBtn()
    self.backBtn.visible = false
    self.levelList.visible = false
    self.mainBox.visible = true
    self.settingBtn.visible = true
end

function UIMainPage:onMatchBtnClick()
    Log.debug("打开比赛场!!!!")
    UIManager:LoadView("MatchPage")
end

function UIMainPage:OnClick(context)
    return nil
end

function UIMainPage:OnFishView()
    local a = {}
    a["scene_id"] = 9;
    NetSender.EnterRoom(a)
    if 1 then return end
    local batteryLevel = RoleInfoM.instance:getBattery();
    if (batteryLevel < cfg_scene.instance(2).unlock) then
        a["scene_id"] = 1;
        NetSender.EnterRoom(a)
        return ;
    else
        a["scene_id"] = 2
        local intoSceneId = 2;
        local preCoinLimit = 0;
        local nextCoinLimit = 0;
        local tmpCoin = (RoleInfoM.instance:getCoin() - RuleM.instance:coinCount() + RoleInfoM.instance:getBindCoin())
        if (tmpCoin < 0) then
            tmpCoin = 0;
        end
        for i = 2, 4 do
            if (i ~= 4) then
                preCoinLimit = cfg_scene.instance(i).unlock * 500;
                nextCoinLimit = cfg_scene.instance(i + 1).unlock * 500;
                if (tmpCoin >= preCoinLimit and tmpCoin < nextCoinLimit) then
                    intoSceneId = i;
                    break ;
                end
            else
                preCoinLimit = cfg_scene.instance(i).unlock * 500;
                if (tmpCoin >= preCoinLimit) then
                    intoSceneId = i
                    break
                end
            end
        end
        for i = intoSceneId, 3, -1 do
            if (batteryLevel >= cfg_scene.instance(i).unlock) then
                a["scene_id"] = i
                break ;
            end
        end
        NetSender.EnterRoom(a)
        return ;
    end

end

function UIMainPage:OnRegisterView(context)
    --GameEventDispatch.instance:Event(GameEvent.RewardTip, { 1 }, { 5 }, 100);
    UIManager:LoadView("RegisterPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnBankView(context)
    if (RoleInfoM.instance.is_bind_tel == 0) then
        local info = CertificationInfo.new()
        info.openFrom = GameConst.from_bank
        CertificationM.instance:setInfo(info)
        CertificationM.instance:OpenCertification()
    else
        local info = CertificationInfo.new()
        info.openFrom = GameConst.from_bank
        CertificationM.instance:setInfo(info)
        CertificationM.instance:OpenCertification()
    end
end

function UIMainPage:addCoin()
    GameEventDispatch.instance:event(GameEvent.Shop, GameConst.shop_tab_coin);
end

function UIMainPage:addDiamond()
    GameEventDispatch.instance:event(GameEvent.Shop, GameConst.shop_tab_diamond);
end

function UIMainPage:onInside()
    UIManager:LoadView("InsidePage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:onCertificationBtn()
    if (CertificationM.instance:isOpenCertification()) then
        local info = CertificationInfo.new()
        info.openFrom = GameConst.from_main
        CertificationM.instance:setInfo(info)
        CertificationM.instance:OpenCertification()
    end
end

function UIMainPage:setBindTel()
    if RoleInfoM.instance.jjhId ~= nil and string.len(RoleInfoM.instance.jjhId) > 0 then
        self.user_id.text = "ID：" .. RoleInfoM.instance.jjhId
    else
        self.user_id.text = "请绑定银行"
    end
end

function UIMainPage:openInfoView()
    UIManager:LoadView("InfoPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:openBankView()
    UIManager:LoadView("BankPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnShopView(context)
    UIManager:LoadView("ShopPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnPackView(context)
    UIManager:LoadView("PackPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnRankView(context)
    --GameEventDispatch.instance:Event(GameEvent.RewardTip, { 1, 4 }, { 5, 100 }, 100);
    UIManager:LoadView("RankPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnExchangeView(context)
    UIManager:LoadView("ExchangePage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnSettingView(context)
    UIManager:LoadView("SettingPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnRedPackView(context)
    UIManager:LoadView("RedActivityPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:onTaskNewBtn(context)
    local a = { is_daily = false }
    --服务端功能没有了
    --WebSocketManager.instance:send(19002, a);
    UIManager:LoadView("TaskNewPage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnFirstChargeView(context)
    UIManager:LoadView("FirstChargePage", nil, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:OnMonthCardView()
    if RoleInfoM.instance:haveValidMonthCard() then
        local cards = RoleInfoM.instance:getMonthCard()
        for i, v in pairs(cards) do
            if v.can_accept then
                local a = {}
                a.id = i
                NetSender.MonthCardDailyReward(a)
                return
            end
        end
    end
    UIManager:LoadView("MonthCardPage", { id = FightConst.month_card_id }, UIEffectType.SMALL_TO_BIG)
end

function UIMainPage:initFirstChargeBtn()
    if ShopC:isShowFirstIcon() then
        self.firstChargeBtn.visible = true;
    else
        self.firstChargeBtn.visible = false;
    end
    self:refreshLeftBtn()
end

function UIMainPage:refreshLeftBtn()
    local curY = { 208, 355, 511 }
    local curBtn = { self.monthBtn, self.firstChargeBtn, self.taskNewBtn }
    local j = 1
    for i = 1, #curBtn do
        if curBtn[i].visible then
            curBtn[i].y = curY[j]
            j = j + 1
        end
    end
end

function UIMainPage:showRedPoint()
    local red_points = RoleInfoM.instance:getRedPoints()
    local vertical_h = 9
    local horizontal_percent = 0.65

    --TODO 新手福利
    local taskFinish = RoleInfoM.instance:refreshTaskArr();
    for i = 1, #taskFinish do
        if taskFinish[i].s == 1 then
            RedPointC.instance:removeRedPoint(self.taskNewBtn)
            RedPointC.instance:addRedPointToIcon(self.taskNewBtn, horizontal_percent, vertical_h)
            break
        end
        RedPointC.instance:removeRedPoint(self.taskNewBtn)
    end

    if bit.band(FightConst.point_sign, red_points) ~= 0 then
        RedPointC.instance:removeRedPoint(self.registerBtn)
        RedPointC.instance:addRedPointToIcon(self.registerBtn, horizontal_percent, vertical_h)
    else
        RedPointC.instance:removeRedPoint(self.registerBtn)
    end
    --TODO 首充
    --if FightConst.point_first_charge & red_points then
    --    RedPointC.instance:removeRedPoint(self.firstChargeBtn)
    --    RedPointC.instance:addRedPointToIcon(self.firstChargeBtn, horizontal_percent, vertical_h)
    --
    --
    --else
    --    RedPointC.instance:removeRedPoint(self.firstChargeBtn)
    --
    --end

    if bit.band(FightConst.point_month_card, red_points) ~= 0 then
        RedPointC.instance:removeRedPoint(self.shopBtn)
        RedPointC.instance:addRedPointToIcon(self.shopBtn, horizontal_percent, vertical_h)
    else
        RedPointC.instance:removeRedPoint(self.shopBtn)
    end

    if bit.band(FightConst.point_month_card, red_points) ~= 0 then
        RedPointC.instance:removeRedPoint(self.monthBtn)
        RedPointC.instance:addRedPointToIcon(self.monthBtn, horizontal_percent, vertical_h)
    else
        RedPointC.instance:removeRedPoint(self.monthBtn)
    end

    if bit.band(FightConst.point_gift, red_points) ~= 0 then
        RedPointC.instance:removeRedPoint(self.packBtn)
        RedPointC.instance:addRedPointToIcon(self.packBtn, horizontal_percent, vertical_h)
    else
        RedPointC.instance:removeRedPoint(self.packBtn)
    end

    if bit.band(FightConst.point_rank, red_points) ~= 0 and (not LevelM.instance:getRankDoubleReward()) then
        RedPointC.instance:removeRedPoint(self.rankBtn)
        RedPointC.instance:addRedPointToIcon(self.rankBtn, horizontal_percent, vertical_h)
    else
        RedPointC.instance:removeRedPoint(self.rankBtn)
    end
end

return UIMainPage