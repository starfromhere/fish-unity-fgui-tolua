---@class UICertificationPage :UIDialogBase
local UICertificationPage = class("UICertificationPage", UIDialogBase)

function UICertificationPage:init()
    self.packageName = "Certification"
    self.resName = "CertificationPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil

    ---@type CertificationInfo
    self._info = nil
    ---@type number
    self.bindCountDownNum = 60
    ---@type boolean
    self.canSendSms = true
end

--@override 注册事件监听
function UICertificationPage:Register()
    self:AddRegister(GameEvent.SynBankBindSuccess, self, self.refreshBox);

end


--@override 移除事件监听
function UICertificationPage:UnRegister()
    self.bindCountDownNum = 0;
    self:initBindCountDown()
    self:ClearRegister()
end

function UICertificationPage:initComponent()
    --实名认证
    self.contentView = self.view:GetChild("contentView")

    self.quitBtn = self.contentView:GetChild("quitButton")
    self.desLabel = self.contentView:GetChild("desLabel")
    self.cancelBtn = self.contentView:GetChild("cancelBtn")
    self.confirmBtn = self.contentView:GetChild("confirmBtn")
    self.nameInput = self.contentView:GetChild("nameInput"):GetChild("input")
    self.idCardInput = self.contentView:GetChild("idCardInput"):GetChild("input")
    self.telephoneInput = self.contentView:GetChild("telephoneInput"):GetChild("input")

    --未成年服务
    self.exitBtn = self.contentView:GetChild("exitBtn")

    --账号绑定
    self.bindCountDown = self.contentView:GetChild("bindCountDown")
    self.getvcode = self.contentView:GetChild("getvcode")
    self.bindBtn = self.contentView:GetChild("bindBtn")
    self.jjhNumber = self.contentView:GetChild("jjhNumber"):GetChild("input")
    self.jjhID = self.contentView:GetChild("jjhID"):GetChild("input")
    self.cipher = self.contentView:GetChild("cipher"):GetChild("input")
    self.telephone = self.contentView:GetChild("telephone"):GetChild("input")
    self.vCode = self.contentView:GetChild("vCode"):GetChild("input")

    --银行提示
    self.promptBtn = self.contentView:GetChild("promptBtn")
    self:initPrompt()

    self.pageController = self.contentView:GetController("page")
    self.confirmBtn:onClick(self.onConfirmBtn, self)
    self.cancelBtn:onClick(self.onCancelBtn, self)
    self.quitBtn:onClick(self.onCancelBtn, self)
    self.exitBtn:onClick(self.onExitBtn, self)
    self.promptBtn:onClick(self.onPrompt, self)
    self.getvcode:onClick(self.sendBindVCode, self)
    self.bindBtn:onClick(self.bindTel, self)
end

function UICertificationPage:StartGames(param)
    self._info = CertificationM.instance:getInfo()
    if (self._info) then
        if (self._info.openFrom == GameConst.from_login) then
            NetSender.CountCertification()
        end
    else
        Log.error("CertificationPage info nil")
    end

    self:initBox()
end

function UICertificationPage:initPrompt()
    self.nameInput.promptText = "[color=#165a86]请输入真实姓名[/color]"
    self.idCardInput.promptText = "[color=#165a86]请输入身份证号码[/color]"
    self.telephoneInput.promptText = "[color=#165a86]请输入手机号码[/color]"
    self.jjhNumber.promptText = "[color=#165a86]请输入集结号账号[/color]"
    self.jjhID.promptText = "[color=#165a86]请输入集结号ID[/color]"
    self.cipher.promptText = "[color=#165a86]请输入账号对应密码[/color]"
    self.telephone.promptText = "[color=#165a86]请输入账号对应手机号[/color]"
    self.vCode.promptText = "[color=#165a86]请输入验证码[/color]"
    self.vCode.textFormat.size = 28
end

function UICertificationPage:initBox()
    if (self._info.openFrom == GameConst.from_bank) then
        if (self._info.bindState == 1) then
            self:onCancelBtn(false)
        else
            self.pageController.selectedIndex = 3
        end
    else
        if (self._info.bindState == 1) then
            self:initView()
        else
            self.pageController.selectedIndex = 2
            self.bindCountDown.visible = false
        end
    end
end

function UICertificationPage:onCancelClick()
    UIManager:ClosePanel("CertificationPage")
end

function UICertificationPage:onConfirmBtn()
    local nameStr = self.nameInput.text;
    local cardIdStr = self.idCardInput.text;
    local telephone = self.telephoneInput.text;
    local isChinese, len = GameTools:isChineseWord(nameStr)

    if (nameStr == "") then
        GameTip.showTip("请输入真实姓名")
        return
    elseif (not isChinese or len < 2 or len > 6) then
        GameTip.showTip("输入姓名不符合规范");
        return
    elseif (cardIdStr == "") then
        GameTip.showTip("请输入身份证号")
        return
    elseif (not self:checkCardId(cardIdStr)) then
        GameTip.showTip("输入的身份证号不规范")
        return
    elseif (telephone == "") then
        GameTip.showTip("请输入手机号码")
        return
    elseif not GameTools:isTelePhone(telephone) then
        GameTip.showTip("请输入正确的手机号码")
        return
    end

    if (self:getAge(cardIdStr) and self:getAge(cardIdStr) < 18) then
        if not self._info.realForciblySwitchState then
            GameTip.showTip("未满18周岁，实名认证失败")
        else
            NetSender.Certification( { name = nameStr, cardId = cardIdStr, ageType = 0, mobile = telephone });
            self.pageController.selectedIndex = 1
        end
    else
        NetSender.Certification( { name = nameStr, cardId = cardIdStr, ageType = 1, mobile = telephone });
        self:onCancelBtn(false)
    end
end

---@param str string
---@return boolean
function UICertificationPage:checkCardId(str)
    if (#str ~= 18) then
        return false
    end
    if string.match(str, "%d+") ~= str and string.match(str, "%d+x") ~= str then
        return false
    end
    local code = { "1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2" }
    local arr = {}
    local sum = 0
    for i = 1, string.len(str) do
        local char = string.sub(str, i, i)
        if (char ~= "X") then
            table.insert(arr, tonumber(char));
        else
            table.insert(arr, char);
        end
    end
    sum = arr[1] * 7 + arr[2] * 9 + arr[3] * 10 + arr[4] * 5 + arr[5] * 8 + arr[6] * 4 + arr[7] * 2 + arr[8] * 1
            + arr[9] * 6 + arr[10] * 3 + arr[11] * 7 + arr[12] * 9 + arr[13] * 10 + arr[14] * 5 + arr[15] * 8
            + arr[16] * 4 + arr[17] * 2
    if tostring(arr[18]) == code[sum % 11 + 1] then
        return true
    end
    return false
end

---@param identityCard string
---@return number
function UICertificationPage:getAge(identityCard)
    local len = #tostring(identityCard)
    if (len == 0) then
        return 0
    else
        if ((len ~= 15) and (len ~= 18)) then
            return 0
        end
    end
    local playerYear
    local playerMonth
    local playerDate
    if (len == 18) then
        playerYear = tonumber(string.sub(identityCard, 7, 10))
        playerMonth = tonumber(string.sub(identityCard, 11, 12))
        playerDate = tonumber(string.sub(identityCard, 13, 14))
    end
    if (len == 15) then
        playerYear = tonumber("19" .. string.sub(identityCard, 7, 8))
        playerMonth = tonumber(string.sub(identityCard, 9, 10))
        playerDate = tonumber(string.sub(identityCard, 11, 12))
    end
    local nowDateTime = os.date("*t")
    local nowYear = nowDateTime["year"]
    local nowMonth = nowDateTime["month"]
    local nowDate = nowDateTime["day"]
    local age = nowYear - playerYear
    if (nowMonth < playerMonth or (nowMonth == playerMonth and nowDate < playerDate)) then
        age = age - 1
    end
    return age
end

---@param isCancel boolean
function UICertificationPage:onCancelBtn(isCancel)
    self:clearInput()
    if (self._info.openFrom == GameConst.from_login) then
        GameEventDispatch.instance:Event(GameEvent.Regic)
    elseif (self._info.openFrom == GameConst.from_shop) then
        if (isCancel) then
            GameTip.showTip("实名认证后才能购买此商品");
        else
            GameTip.showConfirmTip(self._info.quitInfo)
        end
    elseif (self._info.openFrom == GameConst.from_month) then
        if (isCancel) then
            GameTip.showTip("实名认证后才能购买此商品");
        else
            GameEventDispatch.instance:Event(GameEvent.ShopBuy, self._info.buyInfo);
        end
    elseif (self._info.openFrom == GameConst.from_gift) then
        if (isCancel) then
            GameTip.showTip("实名认证后才能购买此商品");
        else
            UIManager:LoadView('MonthCardPage', false)
            GameEventDispatch.instance:Event(GameEvent.OpenGift, self._info.buyInfo);
        end
    elseif (self._info.openFrom == GameConst.from_bank) then
        if (isCancel) then

        else
            local batteryLevel = RoleInfoM.instance:getBattery()
            if (LoginInfoM.instance:getOpenBankBatteryLevel() ~= 0 and batteryLevel < LoginInfoM.instance:getOpenBankBatteryLevel()) then
                local batteryLv = cfg_battery.instance(LoginInfoM.instance:getOpenBankBatteryLevel()).comsume
                GameTip.showTip("请解锁" .. tostring(batteryLv) .. "炮倍")
            else
                if RoleInfoM.instance.is_bind_tel == 1 then
                    GameEventDispatch.instance:Event(GameEvent.OpenBankView);
                else
                    self.pageController.selectedIndex = 2
                    return
                end
            end
        end
    end
    CertificationM.instance:setInfo(nil)
    UIManager:ClosePanel("CertificationPage");
end

function UICertificationPage:clearInput()
    self.jjhNumber.text = ""
    self.jjhID.text = ""
    self.cipher.text = ""
    self.telephone.text = ""
    self.vCode.text = ""
    self.nameInput.text = ""
    self.idCardInput.text = ""
    self.telephoneInput.text = ""
end

function UICertificationPage:onExitBtn()
    GameEventDispatch.instance:Event(GameEvent.ExitsGame)
end

function UICertificationPage:onPrompt()
    if (self._info.bindState == 0) then
        self:onCancelBtn(false)
    else
        self.pageController.selectedIndex = 2
    end
end

function UICertificationPage:sendBindVCode()
    local tel = tostring(self.telephone.text)
    if (not self.canSendSms) then
        GameTip.showTip("请等待倒计时结束")
    elseif not GameTools:isTelePhone(tel) then
        GameTip.showTip("手机号不符合规范")
    else
        self.getvcode.onClick:Clear()
        self.bindCountDownNum = 60
        self.bindCountDown.text = "60s"
        self.bindCountDown.visible = true
        self.bindCountTimer = GameTimer.loop(1000, self, self.initBindCountDown)
        self.getvcode.grayed = true;
        self.canSendSms = false;
        NetSender.SendMobileCode({ phone = tel })
    end
end

function UICertificationPage:initBindCountDown()
    self.bindCountDownNum = self.bindCountDownNum - 1
    self.bindCountDown.visible = true
    self.bindCountDown.text = self.bindCountDownNum .. "s"
    if (self.bindCountDownNum < 0) then
        self.bindCountDown.visible = false
        self.getvcode.grayed = false
        self.canSendSms = true
        self.getvcode:onClick(self.sendBindVCode, self)
        if self.bindCountTimer then
            self.bindCountTimer:clear()
        end

    end
end

function UICertificationPage:bindTel()
    local pattern_vcode = "%d+"
    local pattern_id = "%d+"
    local jjhid = tostring(self.jjhID.text)
    local vcode = tostring(self.vCode.text)
    if not GameTools:isTelePhone(self.telephone.text) then
        GameTip.showTip("手机号不符合规范")
    elseif (#jjhid <= 0 or string.match(jjhid, pattern_id) ~= jjhid) then
        GameTip.showTip("集结号ID不符合规范，请填写数字")
    elseif #vcode ~= 6 or (string.match(vcode, pattern_vcode) ~= vcode) then
        GameTip.showTip("验证码不符合规范")
    else
        local userID = tostring(LoginInfoM.instance.uid)
        local number = self.jjhNumber.text
        local id = self.jjhID.text
        local password = self.cipher.text
        local tel = self.telephone.text
        local code = self.vCode.text
        NetSender.BindBank( {
            u_user_id = userID, phone = tel,
            jjhaccounts = number, jjhuserid = id,
            logonpass = password, code = code })
        self.bindCountDownNum = 0
        self:initBindCountDown()
    end
end

function UICertificationPage:refreshBox()
    if (RoleInfoM.instance.is_bind_tel == 1) then
        if (LoginM.instance:getIsCompleteCertification() == 0) then
            self._info.bindState = RoleInfoM.instance.is_bind_tel
            RoleInfoM.instance.jjhId = self.jjhID.text
            GameEventDispatch.instance:Event(GameEvent.SyncBankCoin)
            self:initView()
        else
            self._info.realState = LoginM.instance:getIsCompleteCertification()
            self:onCancelBtn()
        end
    end
end

function UICertificationPage:initView()
    if (self._info.openFrom == GameConst.from_shop) then
        self.desLabel.text = "为了保证您的账号安全，请在充值前进行实名认证；完成后会获得20钻石奖励"
    else
        self.desLabel.text = "为了您有更好的游戏体验，将进行实名认证；完成后会获得20钻石奖励"
    end
    if (self._info.realForciblySwitchState == 1) then
        if (self._info.ageState == 0) then
            self.pageController.selectedIndex = 1
        else
            self.pageController.selectedIndex = 0
            --self.confirmBtn.x = 812
            self.cancelBtn.visible = false
        end
    else
        --self.confirmBtn.x = 1047
        self.pageController.selectedIndex = 0
        self.cancelBtn.visible = true
    end
    self.confirmBtn.title = "确定"
    self.cancelBtn.title = "取消"
end

return UICertificationPage