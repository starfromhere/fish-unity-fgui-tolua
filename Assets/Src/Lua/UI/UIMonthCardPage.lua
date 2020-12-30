---@class UIMonthCardPage :UIDialogBase
local UIMonthCardPage = class("UIMonthCardPage", UIDialogBase)

---init @override 派生类可重写，成员变量或者其他内容的初始化
---@protected
---@return void
function UIMonthCardPage:init()
    self.packageName = "MonthCard"
    self.resName = "MonthCardPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.showEffectType = UIEffectType.SMALL_TO_BIG
    self.hideEffectType = UIEffectType.BIG_TO_SMALL

    self.giftUserId = nil
    self.curPage = 0
    self.card_id = FightConst.month_card_id

    self.listManager = nil
    self.listRewardManagerArr = { nil, nil }
end

---initComponent @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
---@protected
---@return void
function UIMonthCardPage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.listObj = self.contentView:GetChild("list")
    self.scrollRight = self.contentView:GetChild("scroll_right")
    self.scrollLeft = self.contentView:GetChild("scroll_left")

    self.inputUserid = self.contentView:GetChild("input_userid")
    self.userInfoBox = self.contentView:GetChild("userinfo_box")
    self.userName = self.contentView:GetChild("username")
    self.userImg = self.contentView:GetChild("userimg")
    self.quitGiftBtn = self.contentView:GetChild("quit_gift_box")
    self.queryBtn = self.contentView:GetChild("query_btn")
    self.giftConfirm = self.contentView:GetChild("gift_confirm")
    self.giftImg = self.contentView:GetChild("giftImg")
    self.giftName = self.contentView:GetChild("giftName")

    self.pageController = self.contentView:GetController("page")

    self.scrollRight:onClick(self.onScrollRight, self)
    self.scrollLeft:onClick(self.onScrollLeft, self)
    self.quitGiftBtn:onClick(self.onQuitGiftBox, self)
    self.queryBtn:onClick(self.onQueryUserID, self)
    self.giftConfirm:onClick(self.onGiftConfirm, self)
    self:initList()
end

---StartGames @override 派生类可重写
---@public
---@param param table 打开界面时传递的参数
---@return void
function UIMonthCardPage:StartGames(param)
    if param and param["id"] then
        self.card_id = param["id"]
    end
    self:initFirstPage()
end

function UIMonthCardPage:initFirstPage()
    for i = 1, #self.listManager.data do
        if self.listManager.data[i].id == self.card_id then
            self.curPage = i - 1
            break
        end
    end
    self.listObj:ScrollToView(self.curPage, false)
    self:onScrollEnd()
end

function UIMonthCardPage:initList()
    local arr = ConfigManager.filter("cfg_commodity", function(cfg)
        if cfg.tab == "tab_package" and cfg.card_type == 0 then
            return true
        else
            return false
        end
    end)
    self.listManager = ListManager.creat(self.listObj, arr, self.renderItem, self)
end

function UIMonthCardPage:renderItem(index, cell, config)
    local ele_day_num = cell:GetChild("day_num")
    local buy_box = cell:GetChild("buy_box")
    local send_box = cell:GetChild("send_box")
    local list_box1 = cell:GetChild("box1")
    local list_box2 = cell:GetChild("box2")
    local ele_card_title = cell:GetChild("title")
    local list_reward2 = cell:GetChild("list_reward2")
    local quitBtn = cell:GetChild("quitBtn")

    ele_day_num.text = tostring(config.card_duration)
    buy_box:onClick(self.onBuyClick, self, config)
    send_box:onClick(self.onSendClick, self, config)
    self:initListReward(list_box1, list_box2, list_reward2, config, index)
    quitBtn:onClick(self.onQuitBtn, self)
    ele_card_title.url = tostring(config.card_title2)
end

function UIMonthCardPage:onBuyClick(context)
    local config = context
    if CertificationM.instance:isOpenCertification() then
        local certInfo = CertificationInfo.New()
        certInfo.openFrom = GameConst.from_month
        certInfo.buyInfo = config
        CertificationM.instance:setInfo(certInfo)
        CertificationM.instance:OpenCertification()
    else

        local info = ConfirmTipInfo.New()
        info.content = "确认购买？"
        info.rightClick = function()
            GameEventDispatch.instance:event(GameEvent.ShopBuy, config)
        end
        info.autoCloseTime = 10
        GameTip.showConfirmTip(info)
    end
    self:onQuitBtn()
end

function UIMonthCardPage:onSendClick(context)
    local config = context
    local mini_battery = ConfigManager.getConfValue("cfg_global", 1, "min_battery")
    if RoleInfoM.instance:getBattery() <= mini_battery then
        GameTip.showTip(cfg_battery.instance(tonumber(mini_battery + 1)).comsume .. "倍炮台，开放赠送功能")
        return
    end

    if (CertificationM.instance:isOpenCertification()) then
        local certInfo = CertificationInfo.New()
        certInfo.openFrom = GameConst.from_gift;
        certInfo.buyInfo = cfg;
        CertificationM.instance:setInfo(certInfo)
        CertificationM.instance:OpenCertification()
    else
        self:adultPlayer(config)
    end
end

function UIMonthCardPage:initListReward(list_box1, list_box2, list_reward2, cfg, index)
    local rewards1 = {}
    local rewards2 = {}
    local total_reward_coin = 0
    local total_reward_diamond = 0
    for i = 1, #cfg.reward_item_ids do
        table.insert(rewards1, { reward_item_id = cfg.reward_item_ids[i], reward_item_num = cfg.reward_item_nums[i] })
        if 1 == cfg_goods.instance(tonumber(cfg.reward_item_ids[i])).type then
            total_reward_coin = total_reward_coin + cfg.reward_item_nums[i]
        end
        if 4 == cfg_goods.instance(tonumber(cfg.reward_item_ids[i])).type then
            total_reward_diamond = total_reward_diamond + cfg.reward_item_nums[i]
        end
    end

    local cfgObj = cfg_commodity.instance(tonumber(FightConst.month_card_id))
    for i = 1, #cfg.reward_item_ids do
        table.insert(rewards2, { reward_item_id = cfg.reward_item_ids[i], reward_item_num = cfgObj.reward_item_nums[i] })
        if 1 == cfg_goods.instance(tonumber(cfg.reward_item_ids[i])).type then
            total_reward_coin = total_reward_coin + cfgObj.reward_item_nums[i] * cfg.card_duration
        end
        if 4 == cfg_goods.instance(tonumber(cfg.reward_item_ids[i])).type then
            total_reward_diamond = total_reward_diamond + cfgObj.reward_item_nums[i] * cfg.card_duration
        end
    end
    if self.listRewardManagerArr[index] then
        self.listRewardManagerArr[index]:update(rewards2)
    else
        self.listRewardManagerArr[index] = ListManager.creat(list_reward2, rewards2, self.updateItemReward, self)
    end
    self:updateItemReward(nil, list_box1, rewards1[1])
    self:updateItemReward(nil, list_box2, rewards1[2])
end

function UIMonthCardPage:updateItemReward(index, cell, config)
    local ele_reward_img = cell:GetChild("reward_type")
    local ele_reward_text = cell:GetChild("reward_text")
    ele_reward_img.url = cfg_goods.instance(tonumber(config.reward_item_id)).icon
    ele_reward_text.text = "x" .. tostring(config.reward_item_num)
end

function UIMonthCardPage:adultPlayer(config)
    self.giftConfirm.data = config
    self:onOpenGiftBox(config)
end
--93722444
function UIMonthCardPage:onGiftConfirm(context)
    local re = context.sender.data
    local pattern_user_id = "^[1-9][0-9]+$"
    if self.inputUserid.text == "" then
        GameTip.showTip("请输入用户ID")
    elseif string.match(tostring(self.inputUserid.text), pattern_user_id) ~= tostring(self.inputUserid.text) then
        GameTip.showTip("用户ID不符合规范")
    elseif not self.giftUserId then
        GameTip.showTip("请点击查询按钮，确认用户身份")
    else
        self:onQuitGiftBox()
        local data = { item_id = re.good_ids[1], item_count = 1, user_id = self.giftUserId, buy_month_card = true,platform = GameConst.platform_h5 }
        --TODO platform
        --data['platform']=StartParam.instance:getParam("platform")
        NetSender.SendGift( data)
    end
end
--93722444
function UIMonthCardPage:onQueryUserID()
    local pattern_user_id = "^[1-9][0-9]+$"
    local user_id = self.inputUserid.text
    if string.match(tostring(user_id), pattern_user_id) ~= tostring(user_id) then
        GameTip.showTip("用户ID不符合规范")
    else
        local token = LoginInfoM.instance:getUserToken()
        ApiManager.instance:QueryUserName(token, user_id, nil, function(result)
            if "success" == result.code then
                local data = result.data
                local nickName = data.nickname
                local userId = data.id
                --TODO 添加屏蔽字功能
                self.userName.text = FightTools:formatNickName(nickName, 20)
                GameTools.loadHeadImage(self.userImg,data.avatar)
                self.userInfoBox.visible = true
                self.giftUserId = userId
            elseif "user_not_found" == result.code then
                GameTip.showTip("用户不存在")
            end
        end)
    end
end

function UIMonthCardPage:onScrollRight()
    self.curPage = self.curPage + 1
    self.listObj:ScrollToView(self.curPage, true)
    self:onScrollEnd()
end

function UIMonthCardPage:onScrollLeft()
    self.curPage = self.curPage - 1
    self.listObj:ScrollToView(self.curPage, true)
    self:onScrollEnd()
end

function UIMonthCardPage:onScrollEnd()
    self.scrollLeft.visible = true
    self.scrollRight.visible = true
    if self.curPage == 0 then
        self.scrollLeft.visible = false

    end
    if self.curPage == self.listObj.numChildren - 1 then
        self.scrollRight.visible = false
    end
end

function UIMonthCardPage:onQuitBtn()
    UIManager:ClosePanel("MonthCardPage")
end

function UIMonthCardPage:onOpenGiftBox(config)
    self.inputUserid.text = ""
    self.giftUserId = nil
    self.userInfoBox.visible = false
    self.pageController.selectedIndex = 1
    self.giftImg.url=cfg_goods.instance(tonumber(config.good_ids[1])).icon
    self.giftName.text=config.title
end

function UIMonthCardPage:onQuitGiftBox()
    self.pageController.selectedIndex = 0
    self.inputUserid.text = "";
    self.userName.text = "";
end

---Register @override 注册监听
---@public
---@return void
function UIMonthCardPage:Register()
    self:AddRegister(GameEvent.OpenGift, self, self.adultPlayer);
end

return UIMonthCardPage