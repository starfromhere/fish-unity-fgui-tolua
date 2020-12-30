---@class UIRewardPage :UIDialogBase
local UIRewardPage = class("UIRewardPage", UIDialogBase)
function UIRewardPage:init()
    self.packageName = "Reward"
    self.resName = "RewardPage"
    self.view = nil  -- 界面对象引用

    self.param = ""
    self.context = nil
    self.returnBtn = nil    --返回按钮
    self.tabC = nil    --tab控制器
    self.he = nil      --选项卡合并动画
    self.lotteryBtn = nil  --抽奖按钮
    self.fishTypeBtn = nil  --奖金鱼按钮
    self.prizePool = nil  --奖池
    self.progressValue = nil  --进度条数值
    self.progressBar = nil  --进度条
    self.record1 = nil  --记录1
    self.record2 = nil  --记录2
    self.record3 = nil  --记录3


    self.timerText = nil  --剩余时间
    self.aniDelay = nil --延迟
    self.aniDelay2 = nil --延迟
    self.timer = nil  --倒计时
    self.remainTime = 10  --剩余时间
    self.selectedItemIndex = 1   --抽中卡牌index
    self.selectedTabIndex = 1   --可抽奖tab index
    self.curTabIndex = 1   --当前tab index
    self.typeArr = { 101, 201, 301, 401, 501, 601 }   --抽奖类型
end

function UIRewardPage:StartGames(param)
    self:initComponent()
    --RewardM.instance:setInfo();
    self:initView()
    self:lotteryrecord();
end

function UIRewardPage:initComponent()
    self.items = {}
    self.contentView = self.view:GetChild("contentView")
    self.returnBtn = self.contentView:GetChild("ReturnBtn")
    self:initTab()
    local list = self.contentView:GetChild("list")
    for i = 1, 6 do
        local item = list:GetChild("item" .. i)
        item.data = i;
        item.onClick:Set(self.OnItemChanged, self)
        table.insert(self.items, item)
    end
    self.he = list:GetTransition("he");
    self.lotteryBtn = self.contentView:GetChild("lotteryBtn")
    self.fishTypeBtn = self.contentView:GetChild("fishTypeBtn")
    self.timerText = self.contentView:GetChild("timerText")
    self.prizePool = self.contentView:GetChild("prizePool")
    self.progressValue = self.contentView:GetChild("progressValue")
    self.progressBar = self.contentView:GetChild("progressBar")
    self.prizeProBar = self.contentView:GetChild("prizeProBar")
    self.record1 = self.contentView:GetChild("record1")
    self.record2 = self.contentView:GetChild("record2")
    self.record3 = self.contentView:GetChild("record3")

    self.returnBtn:onClick(self.onQuitClick, self)
    self.timerText.visible = false
    self.fishTypeBtn:onClick(self.OnClick, self, self.fishTypeBtn.name)
    self.lotteryBtn:onClick(self.OnClick, self, self.lotteryBtn.name)
    self:initTimer()
end

function UIRewardPage:initTimer()
    -- Timer 可以改成GameTimer
    self.timer = Timer.New(function()
        self.remainTime = self.remainTime - 1
        if self.remainTime < 0 then
            self.timer:Stop()
            local curIndex = Mathf.Floor(Mathf.Random() * 6 + 1)
            self:playOpenAni(curIndex)
        else
            self:updateTimeTest(true)
        end
    end, 1, -1)
    self.aniDelay = Timer.New(function()
        self.aniDelay:Stop()
        self:playHeAni()
    end, 0.5, 1)
    self.aniDelay2 = Timer.New(function()
        self.aniDelay2:Stop()
        self:setItemTouchable(true)
    end, 1, 1)
end

function UIRewardPage:playHeAni()
    self.he:Play(self:heEnd())
end
function UIRewardPage:heEnd()
    self:updateTimeTest(true)
    self.timer:Start()
    self.aniDelay2:Start()
end

function UIRewardPage:updateTimeTest(visible)
    if visible then
        self.timerText.visible = true;
        self.timerText.text = self.remainTime .. "s";
    else
        self.timerText.visible = false;
        self.remainTime = 10
        self.timerText.text = self.remainTime .. "s";
    end


end

function UIRewardPage:OnClick(context)
    local data
    --if context.sender then
    --    data = context.sender.data
    --else
    data = context;
    --end
    if data == "lotteryBtn" then
        self.lotteryBtn.enabled = false
        self.lotteryBtn.touchable = false
        self.returnBtn.touchable = false
        self:setTabTouchable(false)
        self:setItemTouchable(false)
        for i = 1, #self.items do
            local item = self.items[i]
            local trans = item:GetTransition("fan");
            trans:Play(self:fanEnd());
        end
    elseif data == "fishTypeBtn" then
        UIManager:LoadView("FishTypePage")
    end
end

function UIRewardPage:fanEnd()
    if self.aniDelay == nil then
        self:initTimer()
    end
    self.aniDelay:Start()
end

function UIRewardPage:initTab()
    self.tab_com = self.contentView:GetChild("tab_com")
    self.tab_copper = self.contentView:GetChild("tab_copper")
    self.tab_silver = self.contentView:GetChild("tab_silver")
    self.tab_gold = self.contentView:GetChild("tab_gold")
    self.tab_diamond = self.contentView:GetChild("tab_diamond")
    self.tab_vip = self.contentView:GetChild("tab_vip")
    self.tabC = self.contentView:GetController("tabC")

    self.tabC.onChanged:Add(self.onTabClick, self)
end

function UIRewardPage:OnItemChanged(context)
    local data
    if context.sender then
        data = context.sender.data
    else
        data = context;
    end
    self:playOpenAni(data)
end

function UIRewardPage:playOpenAni(curIndex)
    local item = self.items[curIndex]
    if item == nil then
        return
    end

    self.selectedItemIndex = curIndex;
    self:setItemInfo(item, "", "", "")
    NetSender.FishLottery( { type = self.typeArr[self.selectedTabIndex] });
    self:setItemTouchable(false)
    local trans = item:GetTransition("open");
    trans:Play(self:openEnd());
end

function UIRewardPage:openEnd()
    --通知后台抽奖结果
    self.timer:Stop()
    self:updateTimeTest(false)
    self.returnBtn.touchable = true
    self:checkState();
end

function UIRewardPage:onTabClick(context)

    self.arr = {}

    local listData = ConfigManager.getLawItem("cfg_rewardDetails")
    local index = self.tabC.selectedIndex;
    self.curTabIndex = index + 1;
    if self.curTabIndex ~= self.selectedTabIndex then
        self:setBtnEnabled(false);
    else
        self:initLottery()
    end
    if self.canChou then

    end
    self:checkState();
    for i = index * 6 + 1, (index + 1) * 6 do
        table.insert(self.arr, listData[i])
    end
    self:initList()
end

function UIRewardPage:initList()


    for i = 1, #self.items do
        local item = self.items[i]
        self:resetItemStage(item)
        if self.arr and self.arr[i] then
            self:setItemInfo(item, self.arr[i].id, self.arr[i].rewardName, self.arr[i].rewardUrl)
        end

    end

end

function UIRewardPage:setItemInfo(item, id, rewardName, rewardUrl)
    local obj = item:GetChild("zheng")
    local img = obj:GetChild("img")
    local name = obj:GetChild("name")
    name.text = rewardName
    img.icon = rewardUrl

end

function UIRewardPage:resetItemStage(item)
    if item ~= nil then
        local zheng = item:GetChild("zheng")
        local backImg = item:GetChild("backImg")
        local trans = item:GetTransition("fan");
        trans:Stop();
        zheng.visible = true
        zheng.scaleX = 1;
        backImg.visible = false;
        backImg.scaleX = 1;
    end
end

function UIRewardPage:initView()
    self.returnBtn.touchable = true
    self:onTabClick()
    self:initLottery()
    self.tabC.selectedIndex = self.selectedTabIndex - 1
    self:setItemTouchable(false)
    self:setTabTouchable(true)

    self.timer2 = Timer.New(function()
        NetSender.LotteryList({});
    end, 2, -1);
    self.timer2:Start();
end

function UIRewardPage:setItemTouchable(touchable)
    for i = 1, #self.items do
        local item = self.items[i];
        if item ~= nil then
            item.touchable = touchable
        end
    end
end

function UIRewardPage:setTabTouchable(touchable)
    self.tab_com.touchable = touchable
    self.tab_copper .touchable = touchable
    self.tab_silver.touchable = touchable
    self.tab_gold.touchable = touchable
    self.tab_diamond.touchable = touchable
    self.tab_vip.touchable = touchable
end

--判定是否可抽奖
function UIRewardPage:initLottery()
    self.baseFishCount = RewardM.instance:baseFishCount();
    self.baseCoinCount = RewardM.instance:conditonValue(0);
    self.selectedTabIndex = RewardM.instance:selectTab(RoleInfoM.instance:getFcoin()) + 1;
    if (RoleInfoM.instance:getFcount() >= self.baseFishCount and RoleInfoM.instance:getFcoin() >= self.baseCoinCount) then
        self.canChou = true;
        --self:checkState();
        self:setBtnEnabled(true);
    else
        self.canChou = false;
        self:setBtnEnabled(false);
    end
    self:checkState();
end

function UIRewardPage:onQuitClick()
    self.remainTime = 10
    if self.timer then
        self.timer:Stop()
    end
    if self.aniDelay then
        self.aniDelay:Stop()
    end
    UIManager:ClosePanel("RewardPage")
end

function UIRewardPage:setBtnEnabled(enable)
    self.lotteryBtn.enabled = enable
    self.lotteryBtn.touchable = enable
end

function UIRewardPage:checkState()

    local curFishCount = RoleInfoM.instance:getFcount();
    local baseFishCount = RewardM.instance:baseFishCount();
    if curFishCount > baseFishCount then
        curFishCount = baseFishCount
    end

    self.progressValue.text = curFishCount .. " / " .. baseFishCount
    self.progressBar.value = curFishCount / baseFishCount * 100;
    self.prizePool.text = RoleInfoM.instance:getFcoin() .. " / " .. RewardM.instance:conditionShowValue(self.curTabIndex - 1);
    self.prizeProBar.value = RoleInfoM.instance:getFcoin() / RewardM.instance:conditionShowValue(self.curTabIndex - 1) * 100;

end
function UIRewardPage:reveice(data)
    self.returnBtn.touchable = true
    self:checkState();
    if data.code == 0 then

        local imageUrl = RewardM.instance:imageUrl(data.id);
        local count = RewardM.instance:rewardCount(data.id);
        local goodsId = RewardM.instance:goodsId(data.id);
        local rewardName = RewardM.instance:rewardName(data.id);
        if data.rep == 1 then
            local cfg = cfg_goods.instance(data.rep_id);
            imageUrl = cfg.icon;
            count = data.rep_count;
            goodsId = data.rep_id;
            rewardName = count .. "金币";
        end
        local extraReward = ActivityM.instance:getRewardPageExtra(data.id);
        if (goodsId == GameConst.currency_exchange) then
            local countFormat = ActivityM.instance:exchangeConversion(GameConst.currency_exchange, count);
            self:setItemInfo(self.items[self.selectedItemIndex], data.id, rewardName, imageUrl)
        else
            self:setItemInfo(self.items[self.selectedItemIndex], data.id, rewardName, imageUrl)
        end
        if (extraReward and ActivityM.instance:isShowRewRebate()) then
            --显示活动券
            GameEventDispatch.instance:event(GameEvent.RewardTip, { { goodsId, extraReward[1] }, { count, extraReward[2] } });
        else
            GameEventDispatch.instance:event(GameEvent.RewardTip, { { goodsId }, { count } });
        end

        GameEventDispatch.instance:event(GameEvent.FinishReward);
    else

        GameEventDispatch.instance:event(GameEvent.MsgTip, 22);
    end

end

function UIRewardPage:updateFish()
    self:initLottery()
end

function UIRewardPage:lotteryrecord()
    local _recordArr = RewardM.instance:RecordArr();
    if _recordArr and #_recordArr > 0 then

        self.record1.text = _recordArr[1];
    end
    if _recordArr and #_recordArr > 1 then

        self.record2.text = _recordArr[2];
    end
    if _recordArr and #_recordArr > 2 then

        self.record3.text = _recordArr[3];
    end
end

function UIRewardPage:regfresh()
    self:lotteryrecord();
end
--@override 注册事件监听
function UIRewardPage:Register()
    self:AddRegister(tostring(15002), self, self.reveice);
    self:AddRegister(GameEvent.UpdateFish, self, self.updateFish);
    self:AddRegister(GameEvent.RefreshLotteryRecord, self, self.regfresh);
end


--@override 移除事件监听
function UIRewardPage:UnRegister()
    self.timer2:Stop();
    self:ClearRegister()
end

return UIRewardPage