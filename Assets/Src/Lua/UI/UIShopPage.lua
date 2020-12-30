---@class UIShopPage :UIDialogBase
local UIShopPage = class("UIShopPage", UIDialogBase)

function UIShopPage:init()
    self.packageName = "Shop"
    self.resName = "ShopPage"
    self.view = nil             -- 界面对象引用
    self.list = nil
    self.list1Manage = nil
    self.listCardManage = nil
    self.tab_skin = nil
    self.test = nil
    self.tabSelect = 1;
    self.arr = {}
    self.list_card = {}
end

--@override 注册事件监听
function UIShopPage:Register()
    self:AddRegister(GameEvent.UpdateProfile, self, self.initCoinInfo);
    self:AddRegister(GameEvent.MonthCardUpdate, self, self.refreshMonthCard);
    self:AddRegister(GameEvent.ShopRefresh, self, self.onRefresh);
    self:AddRegister(GameEvent.ShowRedPoint, self, self.showRedPoint);
end

function UIShopPage:StartGames(param)

    param = param or ""

    self:initCoinInfo();
    self:initComponent();
    self:showRedPoint()
    if string.len(param) > 0 then
        self:selectTab(param);
    else
        self:selectTab("tab_coin");
    end
end

function UIShopPage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.tab_coin = self.contentView:GetChild("CoinBtn")
    self.tab_diamond = self.contentView:GetChild("DiamondBtn")
    self.tab_package = self.contentView:GetChild("GiftBtn")
    self.quitBtn = self.contentView:GetChild("QuitBtn")
    self.list1 = self.contentView:GetChild("ShopList")
    self.listCard = self.contentView:GetChild("CardList")

    self.quitBtn:onClick(self.onReturnClick, self)
    self.tab_coin:onClick(self.selectTab, self, "tab_coin")
    self.tab_diamond:onClick(self.selectTab, self, "tab_diamond")
    self.tab_package:onClick(self.selectTab, self, "tab_package")

    self.CoinValue = self.contentView:GetChild("CoinValue")
    self.DiamondValue = self.contentView:GetChild("DiamondValue")

end

function UIShopPage:initCoinInfo()
    self.CoinValue.text = RoleInfoM.instance:getCoin() - RuleM.instance:coinCount() + RoleInfoM.instance:getBindCoin()
    self.DiamondValue.text = RoleInfoM.instance:getDiamond();
end

function UIShopPage:updateCardList(i, cell, data)
    local ele_price_unit = cell:GetChild("price_unit")
    local ele_img = cell:GetChild("img")
    local ele_accept = cell:GetChild("accept")
    local ele_remaining = cell:GetChild("remain_day")
    local ele_btn = cell:GetChild("btn")
    local ele_txt = cell:GetChild("txt")
    local ele_name = cell:GetChild("name")
    local ele_price = cell:GetChild("price")

    ele_name.text = data.title;
    ele_img.icon = data.img;
    ele_price.text = math.ceil(data.currency_amount / LoginInfoM.instance:getShopRate()) .. "元"
    local month_card = RoleInfoM.instance:getMonthCard();
    local card = month_card[tostring(data.id)];

    ele_accept.visible = false;
    ele_remaining.visible = false;
    ele_price.visible = false;
    ele_price_unit.visible = false;

    local rewardTxt = ""
    local have_buy = false
    ele_btn.touchable = true
    if not card then
        ele_price.visible = true
        --ele_price_unit.visible = true
        ele_btn:onClick(function()
            UIManager:ClosePanel("Shop");
            UIManager:LoadView("MonthCardPage", { id = data.id });
        end)
    else
        if card.can_accept then
            ele_accept.visible = true
            have_buy = true
            ele_btn:onClick(function()
                self.onAcceptMonthCardReward(data)
            end)
        elseif not card.is_expired then
            have_buy = true
            ele_remaining.visible = true
            ele_remaining.text = "还剩余" .. card.left .. "天"
            ele_btn.touchable = false
        else
            ele_price.visible = true;
            --ele_price_unit.visible = true;
            ele_btn:onClick(function()
                UIManager:ClosePanel("Shop");
                UIManager:LoadView("MonthCardPage", { id = data.id });
            end)
        end
    end
    if have_buy then
        for i = 1, #data.good_ids do
            rewardTxt = rewardTxt .. cfg_goods.instance(data.good_ids[i]).name .. "x" .. data.good_nums[i]
        end
    end

    if data.id == 18 and ActivityM.instance:isShowShopRebate() then
        ele_txt.text = rewardTxt .. "活动期间每天再送低级券*5"
    else
        ele_txt.text = rewardTxt .. data.card_detail;
    end
end

function UIShopPage.onAcceptMonthCardReward(record)
    local a = {}
    a.id = record.id
    NetSender.MonthCardDailyReward( a)
end

function UIShopPage:updateList(i, obj, data)
    local img = obj:GetChild("img")
    local btn = obj:GetChild("btn")
    local side_img = obj:GetChild("side")
    local gift_text = obj:GetChild("gift_text")
    local price_text = obj:GetChild("price_text")
    local price_unit = obj:GetChild("price_unit")

    local currency_id = data.currency_id;
    if table.indexOf(RoleInfoM.instance:getPurchasedItems(), data.id) > 0 then
        if data.extra_item_count > 0 then
            gift_text.text = data.extra_item_text
        else
            gift_text.text = ""
        end
    else
        if data.first_buy_gift_count > 0 then
            gift_text.text = data.first_buy_text;
        elseif data.extra_item_count > 0 then
            gift_text.text = data.extra_item_text;
        else
            gift_text.text = ""
        end
    end

    local p = data.item_label;
    local pNum = 0
    if #p > 0 then
        pNum = string.match(p, "%d+")
    end
    if pNum ~= nil and #pNum > 0 then
        p = string.gsub(p, pNum, "")
        price_text.text = "[color=#ffde73]" .. pNum .. "[/color]" .. p
    else

        price_text.text = data.item_label
    end

    price_unit.visible = false
    img.icon = data.img;
    if currency_id == 1 then
        price_unit.icon = "ui://CommonComponent/unit_coin"
    elseif currency_id == 4 then
        price_unit.icon = "ui://CommonComponent/unit_diamond"
    elseif currency_id == 5 then
        price_unit.icon = "ui://CommonComponent/unit_rmb"
    end
    btn.title = math.ceil(data.currency_amount / LoginInfoM.instance:getShopRate()) .. "元"

    if data.sidebar_img and string.len(data.sidebar_img) > 0 then
        side_img.visible = true;
        side_img.icon = data.sidebar_img;
    else
        side_img.visible = false;
    end
    self:updateActivitySide(obj, data)
    btn:onClick(function()
        self:ClickItemBtn(data)
    end)

end

function UIShopPage:ClickItemBtn(re)
    local info = ConfirmTipInfo.New();
    info.state = ConfirmTipInfo.LeftRight
    info.content = "确认购买" .. re.item_label .. "吗？";
    info.rightClick = function()
        GameEventDispatch.instance:Event(GameEvent.ShopBuy, re);
    end
    info.autoCloseTime = 10;
    if CertificationM.instance:isOpenCertification() then
        local certInfo = CertificationInfo.New()
        certInfo.openFrom = GameConst.from_shop
        certInfo.quitInfo = info
        CertificationM.instance:setInfo(certInfo)
        CertificationM.instance:OpenCertification()
    else
        GameTip.showConfirmTip(info)
    end
end

function UIShopPage:updateActivitySide(cell, data)
    -- 鱼类活动
    local bomb = cell:GetChild("bomb")
    local bomb_num = cell:GetChild("bomb_num")
    local bombBox = cell:GetChild("bombBox")

    local bombGift = ActivityM.instance:getShopExtraArrByShopId(data.id, FightConst.activity_bomb);
    if bombGift and ActivityM.instance:activityIsActive(FightConst.activity_bomb) then
        bombBox.visible = true
        bomb.icon = cfg_goods.instance(bombGift[1]).icon
        bomb_num.text = "x " .. bombGift[2];
    else
        bombBox.visible = false
    end

    -- 福利活动
    local bonus = cell:GetChild("bonus")
    local bonus_num = cell:GetChild("bonus_num")
    local bonusBox = cell:GetChild("bonusBox")

    local giftArr = ActivityM.instance:getShopExtraArrByShopId(data.id, FightConst.activity_bonus);
    if bombGift and ActivityM.instance:activityIsActive(FightConst.activity_bonus) then
        bonusBox.visible = true
        bonus.icon = cfg_goods.instance(giftArr[1]).icon
        bonus_num.text = "x " .. giftArr[2];
    else
        bonusBox.visible = false
    end

    -- 世界杯活动
    local activity = cell:GetChild("activity")
    local activity_num = cell:GetChild("activity_num")
    local activityBox = cell:GetChild("activityBox")

    local activityArr = ActivityM.instance:getShopExtraArrByShopId(data.id, FightConst.activity_worldcup);
    if activityArr and ActivityM.instance:activityIsActive(FightConst.activity_worldcup) then
        activityBox.visible = true
        activity.icon = cfg_goods.instance(activityArr[1]).icon
        activity_num.text = "x " .. activityArr[2];
    else
        activityBox.visible = false
    end

    -- 鱼类活动
    local common = cell:GetChild("common")
    local common_num = cell:GetChild("common_num")
    local commonBox = cell:GetChild("commonBox")

    local commonArr = ActivityM.instance:getShopExtraArrByShopId(data.id, FightConst.activity_bomb);
    if commonArr and ActivityM.instance:isShowShopRebate() then
        commonBox.visible = true
        common.icon = cfg_goods.instance(commonArr[1]).icon
        common_num.text = "x " .. commonArr[2];
    else
        commonBox.visible = false
    end
end

function UIShopPage:selectTab(contenxt)
    local data
    --if contenxt.sender then
    --    data = contenxt.sender.data
    --else
        data = contenxt
    --end
    self.list1.visible = false;
    self.listCard.visible = false
    self:cleanBtnSync()
    self:onSelect(data)
end

function UIShopPage:cleanBtnSync()
    --self.tab_skin.selected = false;
    self.tab_coin.selected = false;
    self.tab_diamond.selected = false;
    self.tab_package.selected = false;
end

function UIShopPage:onSelect(tab_name)
    self.arr = {}
    self.list1:ScrollToView(0, false)
    self.listCard:ScrollToView(0, false)

    if tab_name == "tab_coin" then
        self.list1.visible = true;
        self.tab_coin.selected = true;
        self.arr = ConfigManager.filter("cfg_commodity", function(item)
            return item.tab == "tab_coin" and self:need_show_single_item(item)
        end)

        if self.list1Manage then
            self.list1Manage:update(self.arr)
        else
            self.list1Manage = ListManager.creat(self.list1, self.arr, self.updateList, self)
        end
    end

    if tab_name == "tab_diamond" then
        self.list1.visible = true;
        self.tab_diamond.selected = true;
        self.arr = ConfigManager.filter("cfg_commodity", function(item)
            return item.tab == "tab_diamond" and self:need_show_single_item(item)
        end)

        if self.list1Manage then
            self.list1Manage:update(self.arr)
        else
            self.list1Manage = ListManager.creat(self.list1, self.arr, self.updateList, self)
        end
    end

    if tab_name == "tab_skin" then
        self.list1.visible = true;
        self.tab_skin.selected = true;
        self.arr = ConfigManager.filter("cfg_commodity", function(item)
            return item.tab == "tab_skin" and self:need_show_single_item(item)
        end)

        if self.list1Manage then
            self.list1Manage:update(self.arr)
        else
            self.list1Manage = ListManager.creat(self.list1, self.arr, self.updateList, self)
        end
    end

    if tab_name == "tab_package" then
        self.listCard.visible = true;
        self.tab_package.selected = true;
        self.list_card = ConfigManager.filter("cfg_commodity", function(item)
            return item.tab == "tab_package" and self:need_show_single_item(item) and self:is_show_month_card(item)
        end)

        if self.listCardManage then
            self.listCardManage:update(self.list_card)
        else
            self.listCardManage = ListManager.creat(self.listCard, self.list_card, self.updateCardList, self)
        end
    end
end

function UIShopPage:need_show_single_item(item)
    if item.is_single_buy == 1 then
        return table.indexOf(RoleInfoM.instance:getPurchasedItems(), item.id) < 0
    else
        return true
    end
end

function UIShopPage:is_show_month_card(item)
    if RoleInfoM.instance:haveValidMonthCard() then
        if item.card_type == 1 then
            return true
        else
            return true
        end
    else
        return item.card_type == 0
    end
end

function UIShopPage:onRefresh(tab_name)
    if tab_name then
        self:onSelect(tab_name)
    end
end

function UIShopPage:refreshMonthCard()
    if self.list_card ~= nil and self.listCardManage ~= nil then
        self.listCardManage:update(self.list_card)
    end
end

function UIShopPage:showRedPoint()
    local red_points = RoleInfoM.instance:getRedPoints()
    local vertical_h = 0
    local horizontal_percent = 0.78

    if bit.band(FightConst.point_month_card, red_points) ~= 0 then
        RedPointC.instance:removeRedPoint(self.tab_package)
        RedPointC.instance:addRedPointToIcon(self.tab_package, horizontal_percent, vertical_h)
    else
        RedPointC.instance:removeRedPoint(self.tab_package)
    end
end

function UIShopPage:onReturnClick()
    UIManager:ClosePanel("ShopPage")
end

return UIShopPage
