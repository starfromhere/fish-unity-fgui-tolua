---@class UIExchangePage :UIDialogBase
---@field public ExchangeList ListManager
local UIExchangePage = class("UIExchangePage", UIDialogBase)

local ListManager = require("Manager.ListManager")

function UIExchangePage:init()
    self.packageName = "Exchange"
    self.resName = "ExchangePage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.data = nil
    self.context = nil
    self.realArray = nil
    self.virtualArray = nil
    self.exchangeRecord = nil
    self.last_time = 0
    self.cache_time = 5; -- 接口缓存毫秒数
    self.userTel = ""
    self.tabName = ""
end

--@override 注册事件监听
function UIExchangePage:Register()
    self:AddRegister(GameEvent.ExchangeFinish, self, self.exchangeComplete);
    self:AddRegister(GameEvent.SynBindCode, self, self.updateBindInfo);
    self:AddRegister(GameEvent.UpdateExchange, self, self.updateBindInfo);
    self:AddRegister(GameEvent.UpdateExchangeBtn, self, self.updateBindInfo);
    --self:AddRegister(GameEvent.RefreshVirtualList, self, self.refreshList1);
end

function UIExchangePage:StartGames(param)
    ExchangeM.instance:setCurSelect(0)
    self:initComponent()
    self:initView()
end

function UIExchangePage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.InfoView = self.contentView:GetChild("InfoView")
    self.exchangeBox = self.InfoView:GetChild("exchangeBox")
    self.tel = self.InfoView:GetChild("tel")
    self.tel_confirm = self.InfoView:GetChild("tel_confirm")
    self.exchangeBtn = self.InfoView:GetChild("exchangeBtn")
    self.quitExchange = self.InfoView:GetChild("quitExchange")


    self.RecordView = self.contentView:GetChild("RecordView")
    self.box_labels = self.RecordView:GetChild("box_labels")
    self.list2 = self.RecordView:GetChild("list2")
    self.hotline = self.RecordView:GetChild("hotline")
    self.quitRecordBtn = self.RecordView:GetChild("quitRecordBtn")

    self.mask1 = self.contentView:GetChild("mask1")
    self.mask2 = self.contentView:GetChild("mask2")
    self.list1 = self.contentView:GetChild("list1")
    self.quitBtn = self.contentView:GetChild("quitBtn")
    self.haveRedBox = self.contentView:GetChild("haveRedBox")
    self.descBox = self.contentView:GetChild("descBox")
    self.box_red = self.contentView:GetChild("box_red")
    self.tab_real = self.contentView:GetChild("tab_real")
    self.tab_virtual = self.contentView:GetChild("tab_virtual")
    self.tab_red = self.contentView:GetChild("tab_red")
    self.orderBtn = self.contentView:GetChild("orderBtn")
    self.exchangeNums = self.contentView:GetChild("exchangeNums")
    self.provider_tel = self.contentView:GetChild("provider_tel")
    self.tabView = self.contentView:GetController("tab")

    --喇叭
    self.redTwo = self.contentView:GetChild("redTwo")
    self.redOne = self.contentView:GetChild("redOne")
    self.payTypeBox = self.contentView:GetChild("payTypeBox")
    self.wxState = self.contentView:GetChild("wxState")
    self.alipayState = self.contentView:GetChild("alipayState")
    self.wxBtn = self.contentView:GetChild("wxBtn")
    self.alipayBtn = self.contentView:GetChild("alipayBtn")
    self.wxExchangeBox = self.contentView:GetChild("wxExchangeBox")
    self.allExchangeLabel = self.contentView:GetChild("allExchangeLabel")
    self.muchInput = self.contentView:GetChild("muchInput")
    self.allDrawBtn = self.contentView:GetChild("allDrawBtn")
    self.wxBindBox = self.contentView:GetChild("wxBindBox")
    self.getCodeBtn = self.contentView:GetChild("getCodeBtn")
    self.bind_code = self.contentView:GetChild("bind_code")
    self.line = self.contentView:GetChild("line")
    self.title = self.contentView:GetChild("title")
    self.alipayExchangeBox = self.contentView:GetChild("alipayExchangeBox")
    self.alipayExchangeLabel = self.contentView:GetChild("alipayExchangeLabel")
    self.alipayMuchInput = self.contentView:GetChild("alipayMuchInput")
    self.alipayDrawBtn = self.contentView:GetChild("alipayDrawBtn")
    self.alipayBindBox = self.contentView:GetChild("alipayBindBox")
    self.alipayGetCodeBtn = self.contentView:GetChild("alipayGetCodeBtn")
    self.alipayLine = self.contentView:GetChild("alipayLine")
    self.alipayBindCode = self.contentView:GetChild("alipayBindCode")
    self.changePayBtn = self.contentView:GetChild("changePayBtn")

    self.quitBtn:onClick(self.onQuitClick, self)
    self.quitRecordBtn:onClick(self.onQuitRecClick, self)
    self.tab_real:onClick(self.onTabClick, self, "tab_real")
    self.tab_virtual:onClick(self.onTabClick, self, "tab_virtual")
    self.tab_red:onClick(self.onTabClick, self , "tab_red")
    self.quitExchange:onClick(self.quitExchangeBtn,self)
    self.exchangeBtn:onClick(self.exchangeBtnClick,self)
    self.orderBtn:onClick(self.onOrderClick, self)
    self.wxBtn:onClick(self.initWxRedBox, self);
    self.alipayBtn:onClick(self.initAlipayRedBox, self);
    self.changePayBtn.data = true
    self.changePayBtn:onClick(self.initPayBox, self);
end

function UIExchangePage:initView()
    self.list2.visible = false
    self.mask1.visible = false
    self.mask2.visible = false
    self.InfoView.visible = false
    self.RecordView.visible = false

    self.tabView.selectedIndex = 0
    self.provider_tel.text = "兑换成功后，奖品会在1～5个工作日发放。\n兑换状态详见“兑换记录”。\n客服电话："..LoginM.instance.provider_tel
    self.hotline.text = "如有疑问，请拨打客服电话".. LoginM.instance.provider_tel
    self:onTabClick("tab_real")
end

function UIExchangePage:onTabClick(context)

    local data
    --if context.sender then
    --    data = context.sender.data
    --else
        data = context;
    --end

    self:concealMod()

    if data == "tab_real" then
        self:getExchanges(data);
        self.descBox.visible = true;
        self.redOne.visible = true
        self.redTwo.visible = false
        self.tabName = "tab_real"
    end

    if data == "tab_virtual" then
        self:getExchanges(data);
        self.descBox.visible = true;
        self.redOne.visible = true
        self.redTwo.visible = false
        self.tabName = "tab_virtual"
    end

    if data == "tab_red" then
        self.box_red.visible = true
        self:initPayBox(false)
    end
end

function UIExchangePage:onOrderClick()
    self.RecordView.visible = true;
    self.mask2.visible = true;
    self.quitRecordBtn.visible = true;
    self:getOrders();
end

function UIExchangePage:getExchanges(tabName)

    local cur_time = os.time()
    if (cur_time - self.last_time) > self.cache_time then
        self.last_time = cur_time
        ApiManager.instance:ExchangeList("exchange_card", nil, function(dataRes)
            self.data = dataRes.data
            self.virtualArray = {}
            self.realArray = {}
            for k, v in pairs(self.data) do
                if v.type == "virtual" then
                    table.insert(self.virtualArray, v)
                elseif v.type == "real" then
                    table.insert(self.realArray, v)
                end
            end


            if tabName == "tab_real" then
                self.list1.visible = true;
                self.ExchangeList = ListManager.creat(self.list1, self.realArray, self.renderHandleList1, self)
            end

            if tabName == "tab_virtual" then
                self.list1.visible = true;
                self.ExchangeList = ListManager.creat(self.list1, self.virtualArray, self.renderHandleList1, self)
            end
        end)
    else
        if tabName == "tab_real" then
            self.list1.visible = true;
            self.ExchangeList:update(self.realArray)
        end

        if tabName == "tab_virtual" then
            self.list1.visible = true;
            self.ExchangeList:update(self.virtualArray)
        end
    end
end

function UIExchangePage:getOrders()
    local token = LoginInfoM:getUserToken();
    self.exchangeRecord = {}
    ApiManager.instance:ExchangeRecords(token, "exchange_card", nil, function(dataRes)
        self.exchangeRecord = dataRes.data.rows;
        ListManager.creat(self.list2, self.exchangeRecord, self.renderHandleList2, self)
        self.list2.visible = true
    end)
end

function UIExchangePage:renderHandleList1(i, cell, data)

    cell.data = config
    local img = cell:GetChild("img")
    local btn = cell:GetChild("btn")
    local title = cell:GetChild("title")
    local remain = cell:GetChild("remain")
    local price_unit = cell:GetChild("price_unit")
    local countDownLabel = cell:GetChild("countDownLabel")
    local need_more_text,user_coin

    local p = data.name;
    local pNum = 0
    if #p > 0 then
        pNum = string.match(p, "%d+")
    end
    if pNum ~= nil and #pNum > 0 then
        p = string.gsub(p,pNum,"")
        title.text = "[color=#ffde73]" .. pNum .. "[/color]" .. p
    else

        title.text = data.name
    end
    
    countDownLabel.visible = false;
    remain.text = "今日剩余：" .. data.num;
    if data.goods_id == 60 then
        need_more_text = "喇叭不足"
        user_coin = RoleInfoM.instance:getExchange()
        price_unit.icon = "ui://CommonComponent/unit_exchange"
    elseif data.goods_id == 1 then
        need_more_text = "金币不足"
        user_coin = RoleInfoM.instance:getCoin()
        price_unit.icon = "ui://CommonComponent/unit_coin"
    end
    local q = string.gsub(data.image_url, "ui/exchange/", "")
    local w = string.gsub(q, "ui/common/", "")
    local e = string.gsub(w, ".png", "")
    img.icon = UIPackage.GetItemURL("IconRes", e)

    local price = self.exchangeConversion(data.goods_id, data.price)
    btn.title = "      " .. price

    if tonumber(user_coin) >= tonumber(price) then
        if data.num > 0 then
            btn:onClick(function()
                self:onExchangeClick(data)
            end)
        else
            btn:onClick(function()
                GameTip.showTip("库存不足")
            end)
        end
    else
        btn:onClick(function()
            GameTip.showTip(need_more_text)
        end)
    end

end

function UIExchangePage.exchangeConversion(id, num)
    local endNum = num;
    if id == GameConst.currency_exchange then
        endNum = num / 100
    end
    return endNum
end

function UIExchangePage:renderHandleList2(i, cell, data)
    local item_name = cell:GetChild("item_name")
    local price_unit = cell:GetChild("price_unit")
    local item_status = cell:GetChild("item_status")
    local item_cost = cell:GetChild("item_cost")
    local item_date = cell:GetChild("item_date")

    item_name.text = data.name;
    if data.goods_id == 60 then
        price_unit.icon = "ui://CommonComponent/unit_exchange"
    elseif data.goods_id == 1 then
        price_unit.icon = "ui://CommonComponent/unit_coin"
    end
    item_cost.text = self.parsePrice(ActivityM.instance:exchangeConversion(data.goods_id, data.price))
    item_date.text = data.created_time

    if data.type == "virtual" then
        item_status.text = "兑换成功"
    else
        if data.status == "pending" then
            item_status.text = "处理中"
        elseif "finished" == data.status then
            item_status.text = "兑换成功"
        end
    end
end

function UIExchangePage.parsePrice(price)
    if math.floor(price) >= 10000 then
        return math.floor(math.floor(price)/10000) .. "万"
    else
        return price
    end
end

function UIExchangePage:onExchangeClick(data)
    if data.type == "real" then
        self.mask1.visible = true
        self.exchangeData = data;
        self.tel.text = "";
        self.tel_confirm.text = "";
        self.InfoView.visible = true;
    elseif data.type == "virtual" then

        local info = ConfirmTipInfo.new();
        info.content = "确认兑换？";
        info.rightClick = function()
            self:goodsExchange(data)
        end
        info.autoCloseTime = 10;
        GameTip.showConfirmTip(info)
    end

end

function UIExchangePage:exchangeComplete()
    self.mask1.visible = false
    self.InfoView.visible = false;
    self.last_time = self.last_time - self.cache_time;
    self:getExchanges(self.tabName)
    GameTip.showTip("兑换成功")
end

function UIExchangePage:quitExchangeBtn()
    self.mask1.visible = false
    self.InfoView.visible = false
    self.tel.text = ""
    self.tel_confirm.text = ""
end

function UIExchangePage:exchangeBtnClick()
    if string.match(self.tel.text, "[1][3-9]%d%d%d%d%d%d%d%d%d") ~= tostring(self.tel.text) then
        GameTip.showTip("手机号不符合规范")
    elseif self.tel.text ~= self.tel_confirm.text then
        GameTip.showTip("两次输入的手机号不一致")
    else
        self.userTel = self.tel.text;

        local info = ConfirmTipInfo.New();
        info.content = "确认兑换？";
        info.rightClick = function()
            self:goodsExchange(self.exchangeData)
        end

        info.autoCloseTime = 10;
        GameTip.showConfirmTip(info)
    end
end

function UIExchangePage:goodsExchange(re)
    local a = {}
    a.id = re.id;
    a.phone = self.userTel;
    NetSender.GoodExchange(a);
end

function UIExchangePage:concealMod()
    self.list1.visible = false;
    self.RecordView.visible = false;
    self.descBox.visible = false;
    self.mask2.visible = false;
    self.quitRecordBtn.visible = false;
    self.box_red.visible = false;
end

function UIExchangePage:onQuitRecClick()
    self.RecordView.visible = false;
    self.mask2.visible = false;
    self.quitRecordBtn.visible = false;
end

function UIExchangePage:onQuitClick()
    UIManager:ClosePanel("ExchangePage")
end

function UIExchangePage:initPayBox(reSelect)
    if reSelect == nil then
        reSelect = false
    end
    self:hideRedBox()
    if (ExchangeM.instance:getWxIsBind() == 1) then
        self.wxState.icon = GameTools.transLayaUrl("ui/exchange/font_ybd.png")
    else
        self.wxState.icon = GameTools.transLayaUrl("ui/exchange/font_wbd.png")
    end
    if (ExchangeM.instance:getAlipayIsBind() == 1) then
        self.alipayState.icon = GameTools.transLayaUrl("ui/exchange/font_ybd.png")
    else
        self.alipayState.icon = GameTools.transLayaUrl("ui/exchange/font_wbd.png")
    end
    if (reSelect) then
        self.payTypeBox.visible = true
    else
        if (ExchangeM.instance:getCurSelect() == 0) then
            if ((ExchangeM.instance:getPayType() == 1 and ExchangeM.instance:getWxExchangeOpen())
                    or (ExchangeM.instance:getWxExchangeOpen() and not ExchangeM.instance:getAlipayExchangeOpen())) then
                self:initWxRedBox()
            elseif (ExchangeM.instance:getPayType() == 2 and ExchangeM.instance:getAlipayExchangeOpen()
                    or (not ExchangeM.instance:getWxExchangeOpen() and ExchangeM.instance:getAlipayExchangeOpen())) then
                self:initAlipayRedBox()
            else
                self.payTypeBox.visible = true
            end
        elseif (ExchangeM.instance:getCurSelect() == 1) then
            self:initWxRedBox()
        elseif (ExchangeM.instance:getCurSelect() == 2) then
            self:initAlipayRedBox()
        end
    end
end

function UIExchangePage:hideRedBox()
    self.payTypeBox.visible = false;
    self.wxExchangeBox.visible = false;
    self.wxBindBox.visible = false;
    self.alipayExchangeBox.visible = false;
    self.alipayBindBox.visible = false;
    self.changePayBtn.visible = false;
    self.redOne.visible = false;
    self.redTwo.visible = false;
    self.descBox.visible = false;
end

function UIExchangePage:initWxRedBox()
    self:hideRedBox()
    ExchangeM.instance:setCurSelect(1)
    if (ExchangeM.instance.curSelect ~= ExchangeM.instance.payType) then
        NetSender.ChangeRedPackageType( { type = ExchangeM.instance:getCurSelect() })
    end
    self.allDrawBtn.enabled = false;
    self.changePayBtn.visible = ExchangeM.instance:isCanChangePayType()
    if (ExchangeM.instance:getWxIsBind() == 1) then
        if (RoleInfoM.instance:getExchange() * 1 > 200) then
            self.muchInput.text = tostring(200)
        else
            self.muchInput.text = tostring(math.floor(RoleInfoM.instance:getExchange()))
        end
        self.allExchangeLabel.text = tostring(RoleInfoM.instance:getExchange())
        self.wxExchangeBox.visible = true
        self.allDrawBtn:onClick(self.onAllDraw, self, 1)
        self.descBox.visible = true
        self.redTwo.visible = true
        self.redTwo.text = "喇叭兑换成功后，请前往《集结号捕鱼H5》公众号，领取福袋。"
    else
        self.redOne.visible = true;
        self. wxBindBox.visible = true;
        self.bind_code.text = ExchangeM.instance:getWxBindTicket()
        self.getCodeBtn.onClick:Clear()
        if (ExchangeM.instance:getWxBindTicket()) then
            self.line.visible = false
        else
            self.line.visible = true
        end
        if (ExchangeM.instance:getWxBindTicket() and ExchangeM.instance:getWxBindTicket() ~= "") then
            self.getCodeBtn.text = "刷新绑定码"
        else
            self.getCodeBtn.text = "获取绑定码"
        end
        if (ExchangeM.instance:getWxExpiredTime() > os.time()) then
            self.getCodeBtn:onClick(function()
                GameTip.showTip("该绑定码在有效期内")
            end, self)
        else
            self.getCodeBtn:onClick(self.onGetCode, self, 1)
        end
    end
end

function UIExchangePage:initAlipayRedBox()
    self:hideRedBox()
    ExchangeM.instance:setCurSelect(2)
    if (ExchangeM.instance.curSelect ~= ExchangeM.instance.payType) then
        NetSender.ChangeRedPackageType( { type = ExchangeM.instance:getCurSelect() })
    end
    self.alipayDrawBtn.enabled = false;
    self.changePayBtn.visible = ExchangeM.instance:isCanChangePayType()
    if (ExchangeM.instance:getAlipayIsBind() == 1) then
        if (RoleInfoM.instance:getExchange() * 1 > 200) then
            self.alipayMuchInput.text = tostring(200)
        else
            self.alipayMuchInput.text = tostring(math.floor(RoleInfoM.instance:getExchange()))
        end
        self.alipayExchangeLabel.text = tostring(RoleInfoM.instance:getExchange())
        self.alipayExchangeBox.visible = true
        self.alipayDrawBtn.data = 1
        self.alipayDrawBtn:onClick(self.onAllDraw, self)
        self.descBox.visible = true
        self.redTwo.visible = true
        self.redTwo.text = "喇叭兑换成功后，请前往《集结号福袋》小程序，领取福袋。"
    else
        self.redOne.visible = true;
        self.alipayBindBox.visible = true;
        self.alipayBindCode.text = ExchangeM.instance:getAlipayBindTicket()
        self.alipayGetCodeBtn.onClick:Clear()
        if (ExchangeM.instance:getAlipayBindTicket()) then
            self.alipayLine.visible = false
        else
            self.alipayLine.visible = true
        end
        if (ExchangeM.instance:getAlipayBindTicket() and ExchangeM.instance:getAlipayBindTicket() ~= "") then
            self.alipayGetCodeBtn.text = "刷新绑定码"
        else
            self.alipayGetCodeBtn.text = "获取绑定码"
        end
        if (ExchangeM.instance:getWxExpiredTime() > os.time()) then
            self.alipayGetCodeBtn:onClick(function()
                GameTip.showTip("该绑定码在有效期内")
            end, self)
        else
            self.alipayGetCodeBtn.data = 2
            self.alipayGetCodeBtn:onClick(self.onGetCode, self)
        end
    end
end

function UIExchangePage:onAllDraw(context)
    local type = context
    local tel = ""
    if (type == 1) then
        tel = self.muchInput.text
    else
        tel = self.alipayMuchInput.text;
    end
    local pattern_tel = "^(([1-9][0-9]*)|(([0]\\.\\d{1,2}|[1-9][0-9]*\\.\\d{1,2})))$"
    if (string.match(tel, pattern_tel) ~= tostring(tel)) then
        GameTip.showTip("请正确输入数值")
    else
        if (string.find(tel, ".", 1)) then
            GameTip.showTip("兑换数量只能为整数");
        elseif (10 > self:parseFloat(tel)) then
            GameTip.showTip("单次兑换喇叭数量10-200");
        elseif (self:parseFloat(tel) > 200) then
            GameTip.showTip("单次兑换喇叭数量10-200");
        elseif (self:parseFloat(tel) > RoleInfoM.instance:getExchange()) then
            GameTip.showTip("拥有的喇叭数量不足");
        else
            if (type == 1) then
                self.allDrawBtn.enabled = true
            else
                self.alipayDrawBtn.enabled = true
            end
            NetSender.GoodExchange( { id = 37, redpack_type = type, amount = parseFloat(tel), coin_type = "exchange_card" })
        end
    end
end

function UIExchangePage:onGetCode(context)
    local typeValue = context
    ExchangeM.instance:setCurSelect(typeValue)
    NetSender.CreateWxBindCode( { type = ExchangeM.instance:getCurSelect() })
end

function UIExchangePage:updateBindInfo()
    if (not self.box_red.visible) then
        return
    end
    if (self.wxBindBox.visible or self.wxExchangeBox.visible) then
        self:initWxRedBox()
    elseif (self.alipayBindBox.visible or self.alipayExchangeBox.visible) then
        self:initAlipayRedBox()
    end
end

return UIExchangePage