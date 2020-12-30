---@class UIPackPage :UIDialogBase

require "bit"
local UIPackPage = class("UIPackPage", UIDialogBase)

function UIPackPage:init()
    self.packageName = "Pack"
    self.resName = "PackPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.arr = nil
    self.context = nil
    self.list2_arr = nil
    self.list1Manager = nil
    self.list2Manager = nil
    self.curSelectIndex = 1
    --当前赠送物品的数据
    self.giftData = nil
    --赠送数量
    self.inputCount = 1
    self.giftUserId = ""
end

function UIPackPage:StartGames(param)
    self:initView()
    self:goodsUpdate()
end

function UIPackPage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.list1 = self.contentView:GetChild("list1")
    self.list2 = self.contentView:GetChild("list2")
    self.quitBtn = self.contentView:GetChild("quitBtn")
    self.useBtn = self.contentView:GetChild("useBtn")
    self.gift_btn = self.contentView:GetChild("gift_btn")
    self.use_prop = self.contentView:GetChild("use_prop")
    self.grantBtn = self.contentView:GetChild("grantBtn")
    self.use_all_prop = self.contentView:GetChild("use_all_prop")
    self.gift_records_btn = self.contentView:GetChild("gift_records_btn")
    self.detail_icon = self.contentView:GetChild("detail_icon")
    self.detail_name = self.contentView:GetChild("detail_name")
    self.detail_desc = self.contentView:GetChild("detail_desc")
    self.title_txt = self.contentView:GetChild("title_txt")

    self.order_view = self.contentView:GetChild("order_view")
    self.tip_box = self.contentView:GetChild("tip_box")
    self.box1 = self.contentView:GetChild("box1")
    self.box2 = self.contentView:GetChild("box2")
    self.quit_gift_box = self.contentView:GetChild("quit_gift_box")
    self.quitOrder = self.contentView:GetChild("quitOrder")

    self.mask1 = self.contentView:GetChild("mask1")
    self.mask2 = self.contentView:GetChild("mask2")
    self.userImg = self.contentView:GetChild("userImg")
    self.userName = self.contentView:GetChild("userName")
    self.input_userId = self.contentView:GetChild("input_userId")
    self.query_btn = self.contentView:GetChild("query_btn")
    self.gift_icon = self.contentView:GetChild("gift_icon")
    self.gift_name = self.contentView:GetChild("gift_name")
    self.item_count = self.contentView:GetChild("item_count")
    self.count_jia = self.contentView:GetChild("count_jia")
    self.count_jian = self.contentView:GetChild("count_jian")
    self.gift_confirm = self.contentView:GetChild("gift_confirm")

    self.count_jia:onClick(self.onAddClick, self)
    self.count_jian:onClick(self.onReduceClick, self)
    self.quitBtn:onClick(self.onQuitClick, self)
    self.quitOrder:onClick(self.onQuitOrderBtnClick, self)
    self.query_btn:onClick(self.onQueryUserID, self)
    self.gift_confirm:onClick(self.onGiftConfirm, self)
    self.quit_gift_box:onClick(self.onQuitGiftBtn, self)
    self.gift_btn:onClick(self.onGiftClick, self)
    self.use_prop:onClick(self.onUseClick, self)
    self.use_all_prop:onClick(self.onUseAllClick, self)
    self.gift_records_btn:onClick(self.onGiftRecord, self)
    self.list1Manager = ListManager.creat(self.list1, self:getPackItems(), self.refreshHandle, self)
end

function UIPackPage:initView()
    self.order_view.visible = false;
    self.mask1.visible = false;
    self.tip_box.visible = false;
    self.quit_gift_box.visible = false
    self.quitOrder.visible = false;
    self.mask2.visible = false
    self.list2.visible = false
    self:showRedPoint();
end

function UIPackPage:goodsUpdate()
    self.curSelectIndex = 1
    self.list1Manager:update(self:getPackItems())
    self.giftData = self.list1Manager.data[1]
    self:onItemClick()
end

function UIPackPage:refreshHandle(i, cell, config)
    cell.data = config
    local ele_img = cell:GetChild("img")
    local select_bg = cell:GetChild("select_bg")
    local ele_count = cell:GetChild("item_count")
    select_bg.visible = false
    if self.curSelectIndex == i then
        select_bg.visible = true;
    end
    local item_count = 0
    --兑换券
    if config.type == 8 then
        item_count = RoleInfoM.instance:getExchange()
        --技能
    elseif config.type == 6 then
        item_count = RoleInfoM.instance:getGoodsItemNum(config.id)
        --月卡 or 月卡道具
    elseif config.type == 12 or config.type == 15 then
        item_count = RoleInfoM.instance:getGoodsItemNum(config.id)
        --活动券
    elseif config.type == 11 then
        item_count = RoleInfoM.instance.activity_ticket
        -- 扎比瓦卡
    elseif config.type == 13 then
        item_count = RoleInfoM.instance.worldcup_coin;
    end
    ele_count.text = "x"..tostring(item_count)
    if i == 0 and self.giftData == nil then
        self.giftData = config
        self:onItemClick()
    end
    if cell.onClick then
        cell.onClick:Clear()
    end
    cell.onClick:Set(function()
        self.giftData = config
        self.curSelectIndex = i
        self:onItemClick()
        self.list1Manager:update()
    end, self)
    ele_img.icon = config.icon;
end

function UIPackPage:refreshHandle2(i, cell, config)
    local ele_item_img = cell:GetChild("item_img")
    local ele_item_name = cell:GetChild("item_name")
    local ele_sender_img = cell:GetChild("gift_avatar")
    local ele_gift_name = cell:GetChild("gift_name")
    local ele_receive_img = cell:GetChild("receive_avatar")
    local ele_receive_name = cell:GetChild("receive_name")

    local ele_item_date = cell:GetChild("time")
    local ele_item_op = cell:GetChild("op")
    local ele_item_op_bg = cell:GetChild("op_bg")

    ele_item_name.text = "x " .. config.item_num;
    ele_gift_name.text = config.sender_nickname
    ele_receive_name.text = config.receipt_nickname
    ele_item_date.text = config.created_time;
    ele_item_img.icon = cfg_goods.instance(config.item_id).icon;
    GameTools.loadHeadImage(ele_sender_img, config.sender_avatar)
    GameTools.loadHeadImage(ele_receive_img, config.receipt_avatar)

    ele_item_op_bg.visible = false
    ele_item_op.visible = true
    if config.is_me == 1 then
        if config.status == "issued" then
            ele_item_op.icon = "ui://Pack/beib_fasong"
        else
            if config.status == "finished" then
                ele_item_op.icon = "ui://Pack/beib_linqu"
            else
                ele_item_op.icon = ""
            end
        end
    else
        if config.status == "issued" then
            ele_item_op_bg.visible = true
            ele_item_op.visible = false
            ele_item_op_bg:onClick(function()
                self:giftConfirm(config.id)
            end)
        else
            if config.status == "finished" then
                ele_item_op.icon = "ui://Pack/beib_linqu"
            else
                ele_item_op.icon = ""
            end
        end
    end
end

function UIPackPage:giftConfirm(id)
    NetSender.ReceiveGift( { gift_id = id })
end

function UIPackPage:getPackItems()
    local count
    local goods = ConfigManager.filter("cfg_goods", function(cfg)
        if cfg.packed == 1 then
            if cfg.can_use == 1 and cfg.type == 6 then
                count = RoleInfoM.instance:getGoodsItemNum(cfg.id)
                if count == 0 then
                    return false
                end
            end
            return true
        end
        return false
    end)

    table.sort(goods, function(a, b)
        return a.pack_index < b.pack_index
    end)
    return goods;
end

function UIPackPage:onGiftRecord()
    self:getOrders()
    self.tip_box.visible = false
    self.mask1.visible = false
    self.quit_gift_box.visible = false
    self.order_view.visible = true
    self.quitOrder.visible = true
    self.mask2.visible = true
end

function UIPackPage:getOrders()
    local token = LoginInfoM:getUserToken();
    ApiManager.instance:giftList(token, 1, nil, function(result)
        if "success" == result.code then
            local arr = result.data.data
            self.list2_arr = arr
            self.list2Manager = ListManager.creat(self.list2, self.list2_arr, self.refreshHandle2, self)
            self.list2.visible = true
        else
            Log.error("error")
        end
    end)


end

-- 重置box数据
function UIPackPage:onItemClick()
    local d = self.giftData

    self.detail_icon.icon = d.icon;
    self.detail_name.text = d.name;
    self.detail_desc.text = d.desc;

    self.item_count.text = 1
    self.gift_icon.icon = d.icon;
    self.gift_name.text = d.name;

    self.use_all_prop.visible = false;
    if d.can_use == 1 then
        if d.type == 12 then
            if RoleInfoM.instance:haveValidMonthCard() then
                self.gift_btn.visible = false
                self.use_prop.visible = true
                self.use_prop:onClick(self.onUsePropClick, self, d)
                self.useBtn:onClick(self.useGoods, self)
                self.grantBtn:onClick(function()
                    local mini_battery = ConfigManager.getConfValue("cfg_global", 1, "min_battery")
                    if RoleInfoM.instance:getBattery() < mini_battery then
                        GameTip.showTip(cfg_battery.instance(mini_battery).comsume + "倍炮台，开放赠送功能")
                        return
                    end
                    self.box1.visible = false
                    self.box2.visible = true
                end)
            else
                self.use_prop:onClick(self.useGoods, self)
                self.gift_btn.visible = false
                self.use_prop.visible = true
            end
        elseif d.type == 15 then
            self.use_prop:onClick(self.useGoods, self)
            self.gift_btn.visible = false
            self.use_prop.visible = true
        elseif d.type == 6 then
            self.use_all_prop:onClick(self.useGoods, self)
            self.gift_btn.visible = false
            self.use_prop.visible = false
            self.use_all_prop.visible = true
        end
    else
        self.use_prop.visible = false
        self.gift_btn.visible = true
    end

    if d.is_gift == 1 then
        self.gift_btn.enabled = true
        self.gift_btn:onClick(self.onGift, self)
    else
        self.gift_btn.enabled = false
    end

end

function UIPackPage:useGoods()
    local item_count = self:getItemCount()
    if item_count <= 0 then
        GameTip.showTip('道具不足')
        return
    end
    local info = ConfirmTipInfo.New();
    info.content = "确认使用？"
    info.rightClick = function()
        self:useProp(item_count)
    end
    info.autoCloseTime = 10
    GameTip.showConfirmTip(info)
end

function UIPackPage:useProp(re)

    if re == 0 then
        GameTip.showTip("道具不足")
    else
        self.tip_box.visible = false
        self.quit_gift_box.visible = false
        self.mask1.visible = false
        NetSender.UseGoods( { id = self.giftData.id })

    end
end

function UIPackPage:onUsePropClick(context)
    local data = context;
    if RoleInfoM.instance:getGoodsItemNum(data.id) <= 0 then
        GameTip.showTip('道具不足')
        return
    end
    self.title_txt.text = "是否使用" .. data.name .. "?"
    self.tip_box.visible = true
    self.quit_gift_box.visible = true
    self.box1.visible = true
    self.mask1.visible = true
    self.box2.visible = false
end

function UIPackPage:onGift(good_count)
    local item_count = self:getItemCount() --获取道具数量
    local mini_battery = ConfigManager.getConfValue("cfg_global", 1, "min_battery")
    if RoleInfoM.instance:getBattery() < mini_battery then
        GameTip.showTip(ConfigManager.getConfValue("cfg_battery", mini_battery, "comsume") .. "倍炮台，开放赠送功能")
        return
    end

    local month_card = RoleInfoM.instance:getMonthCard()
    local have_month_card = false

    for i, key in pairs(month_card) do
        if not key.is_expired then
            have_month_card = true
            break
        end
    end
    if not have_month_card then
        GameTip.showTip("激活月卡，开放赠送功能")
        return
    end

    if item_count == 0 then
        GameTip.showTip("道具不足")
    else
        self.userName.visible = false;
        self.userImg.visible = false;
        self.inputCount = 1
        self.item_count.text = "1"
        self.giftUserId = ""
        self.tip_box.visible = true
        self.box1.visible = false
        self.box2.visible = true
        self.quit_gift_box.visible = true
        self.input_userId.text = ""
        self.userName.text = ""
        self.mask1.visible = true
    end

end

function UIPackPage:showRedPoint()
    local red_points = RoleInfoM.instance:getRedPoints()
    if bit.band(GameConst.point_gift, red_points) ~= 0 then
        self.gift_records_btn.title = "领取"
    else
        self.gift_records_btn.title = "领取记录"
    end
end

function UIPackPage:onQueryUserID()
    local pattern_user_id = "^[+-]?%d+$"
    if not string.find(self.input_userId.text, pattern_user_id) then
        GameTip.showTip("用户ID不符合规范")
    else
        local user_id = self.input_userId.text
        local token = LoginInfoM:getUserToken();
        ApiManager.instance:QueryUserName(token, user_id, nil, function(dataRes)

            if "success" == dataRes.code then
                local data = dataRes.data
                local nickName = data.nickname
                local userId = data.id
                self.userName.text = nickName
                GameTools.loadHeadImage(self.userImg, data.avatar)
                self.userName.visible = true
                self.userImg.visible = true
                self.giftUserId = userId
            else
                if "user_not_found" == dataRes.code then
                    GameTip.showTip("用户不存在")
                end
            end

        end)
    end
end

function UIPackPage:onGiftConfirm()
    local pattern_user_id = "^[+-]?%d+$"
    if string.len(self.input_userId.text) == 0 then
        GameTip.showTip("请输入用户ID")
    elseif not string.find(self.input_userId.text, pattern_user_id) then
        GameTip.showTip("用户ID不符合规范")
    else
        if string.len(self.giftUserId) == 0 then
            GameTip.showTip("请点击查询按钮，确认用户身份")
        else
            local item_count = self.inputCount
            local info = ConfirmTipInfo.new();
            info.content = "确认赠送？";--"<span>确认赠送</span> <span style='color:red'>&nbsp;" + self.giftData.name + " x " + item_count + "&nbsp;</span> <span>给 </span> <span  style='color:red'>&nbsp;" + GameTools:nameSkip(self.username.text) + "&nbsp;</span><span>？</span>"
            info.rightClick = function()
                self:gift(item_count)
            end
            info.autoCloseTime = 10;
            GameTip.showConfirmTip(info)
        end
    end
end

function UIPackPage:onAddClick()
    self.inputCount = self.inputCount + 1;
    self.item_count.text = self.inputCount
end

function UIPackPage:onReduceClick()
    if self.inputCount > 1 then
        self.inputCount = self.inputCount - 1
    end
    self.item_count.text = self.inputCount
end

function UIPackPage:gift()
    local item_count = self.inputCount
    local data = { item_id = self.giftData.id, item_count = item_count, user_id = self.giftUserId }
    NetSender.SendGift(data)
end

function UIPackPage:getItemCount()
    local count = 0
    if self.giftData.type == 8 then
        count = RoleInfoM.instance:getExchange()

    else
        if self.giftData.type == 6 then
            count = RoleInfoM.instance:getGoodsItemNum(self.giftData.id)
        else
            if self.giftData.type == 12 then
                count = RoleInfoM.instance:getGoodsItemNum(self.giftData.id)
            else
                if self.giftData.type == 15 then
                    count = RoleInfoM.instance:getGoodsItemNum(self.giftData.id)
                end
            end
        end
    end
    return count
end

function UIPackPage:onQuitOrderBtnClick()
    self.order_view.visible = false
    self.quitOrder.visible = false
    self.mask2.visible = false

end

function UIPackPage:giftFinish(result)
    self.list1Manager:update(self:getPackItems())
    self:onQuitGiftBtn()
end

function UIPackPage:onQuitGiftBtn()
    self.tip_box.visible = false
    self.quit_gift_box.visible = false
    self.input_userId.text = ""
    self.userName.text = ""
    self.userImg.visible = false
    self.mask1.visible = false
end

function UIPackPage:onQuitClick()
    UIManager:ClosePanel("PackPage")
end

function UIPackPage:giftConfirmFinish(result)

    self.list1Manager:update(self:getPackItems())
    self:getOrders()
end

function UIPackPage:isDigitalString(str)

    for i = 1, i <= #str do

        if (str[i] < '0' or str[i] > '9') then

            return false;
        end
    end
    return true;
end

function UIPackPage:getClipBoard(content)

    if (content) then

        if (#content == 10 and self:isDigitalString(content)) then

            self.input_userId.text = content;
        else
            GameTip.showTip(cfg_tip.instance(51))

        end
    else
        GameTip.showTip(cfg_tip.instance(50))
    end
end
function UIPackPage:endUseMonthCard()
    self:onItemClick()
end

--@override 注册事件监听
function UIPackPage:Register()
    self:AddRegister(GameEvent.GiftFinish, self, self.giftFinish);
    self:AddRegister(GameEvent.ShowRedPoint, self, self.showRedPoint);
    self:AddRegister(GameEvent.GiftConfirmFinish, self, self.giftConfirmFinish);
    self:AddRegister(GameEvent.WxGetClipBoard, self, self.getClipBoard);
    self:AddRegister(GameEvent.GoodsUpdate, self, self.goodsUpdate);
    self:AddRegister(GameEvent.EndUseMonthCard, self, self.endUseMonthCard);
end

return UIPackPage