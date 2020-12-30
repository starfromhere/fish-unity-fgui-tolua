---@class UILoginPage :UIDialogBase
local UILoginPage = class("UILoginPage", UIDialogBase)
--function UILoginPage:ctor()
--    构造函数，如果没有特殊传参需求，不需要动
--end

--@override 复写父类init
function UILoginPage:init()
    self.packageName = "Login"
    self.resName = "LoginPage"
    self.loginBtn = nil         -- 登录按钮
    self.userInput = nil        -- 登录账号信息
    self.registerItem=nil       --注册界面
    self.loginState = 0
    self.logintimer = nil
end

-- @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
function UILoginPage:initComponent()

    self.contentView = self.view:GetChild("contentView")

    self.loginItem = self.contentView:GetChild("LoginItem")
    self.userInput = self.loginItem:GetChild("usernameInput"):GetChild("input")
    self.passwordInput = self.loginItem:GetChild("passwordInput"):GetChild("input")
    self.loginBtn = self.loginItem:GetChild("loginBtn")
    self.registerBtn = self.loginItem:GetChild("registerBtn")
    self.selectBtn = self.loginItem:GetChild("selectBtn")
    self.recodeBand = self.loginItem:GetChild("recodeBand")
    self.loginBtn:onClick(self.OnLoginBtn, self)
    self.selectBtn:onClick(self.showRecode, self)

    self.registerItem=self.contentView:GetChild("RegisterItem")
    self.cancelBtn = self.registerItem:GetChild("cancelBtn")
    self.confirmBtn = self.registerItem:GetChild("confirmBtn")
    self.usernameInput = self.registerItem:GetChild("usernameInput"):GetChild("input")
    self.passInput = self.registerItem:GetChild("passInput"):GetChild("input")
    self.rePassInput = self.registerItem:GetChild("rePassInput"):GetChild("input")
    self.nameInput = self.registerItem:GetChild("nameInput"):GetChild("input")
    self.idCardInput = self.registerItem:GetChild("idCardInput"):GetChild("input")
    self.telephoneInput = self.registerItem:GetChild("telephoneInput"):GetChild("input")
    self.codeInput = self.registerItem:GetChild("codeInput"):GetChild("input")
    self.codeBtn = self.contentView:GetChild("RegisterItem"):GetChild("codeBtn")
    self:initPrompt()

    self.registerItem.visible=false;
   -- self.userInput.onKeyDown:Add(self.OnLoginBtn, self)
    self.registerBtn:onClick(self.onRegister, self)
    self.confirmBtn:onClick(self.onConfirmBtn, self)
    self.cancelBtn:onClick(self.onCancelBtn, self)
end

function UILoginPage:initPrompt()
    self.nameInput.promptText = "[color=#165a86]请输入真实姓名[/color]"
    self.idCardInput.promptText = "[color=#165a86]请输入身份证号码[/color]"
    self.telephoneInput.promptText = "[color=#165a86]请输入手机号码[/color]"
    self.codeInput.promptText = "[color=#165a86]请输入验证码[/color]"
end

function UILoginPage:onCancelBtn()
    self:clearInput()
    self.registerItem.visible=false;
end

function UILoginPage:clearInput()
    self.nameInput.text = ""
    self.idCardInput.text = ""
    self.telephoneInput.text = ""
    self.codeInput.text=""
end

function UILoginPage:onConfirmBtn()
    local usernameStr = self.usernameInput.text;
    local passStr = self.passInput.text;
    local rePassStr = self.rePassInput.text;
    local nameStr = self.nameInput.text;
    local cardIdStr = self.idCardInput.text;
    local telephone = self.telephoneInput.text;
    local code= self.codeInput.text;
    local isChinese, len = GameTools:isChineseWord(nameStr)

    if (usernameStr == "") then
        GameTip.showTip("请输入账户名")
        return
    elseif (passStr == "") then
        GameTip.showTip("请输入密码");
        return
    elseif (rePassStr == "") then
        GameTip.showTip("请重复密码");
        return
    elseif (rePassStr ~= passStr) then
        GameTip.showTip("请确认密码是否一致");
        return
    end
   --todo  暂时不验证身份证手机号这些参数
    --if (nameStr == "") then
    --    GameTip.showTip("请输入真实姓名")
    --    return
    --elseif (not isChinese or len < 2 or len > 6) then
    --    GameTip.showTip("输入姓名不符合规范");
    --    return
    --elseif (code== "") then
    --    GameTip.showTip("请输入验证码");
    --    return
    --elseif (cardIdStr == "") then
    --    GameTip.showTip("请输入身份证号")
    --    return
    --elseif (not self:checkCardId(cardIdStr)) then
    --    GameTip.showTip("输入的身份证号不规范")
    --    return
    --elseif (telephone == "") then
    --    GameTip.showTip("请输入手机号码")
    --    return
    --elseif not GameTools:isTelePhone(telephone) then
    --    GameTip.showTip("请输入正确的手机号码")
    --    return
    --end

    ApiManager.instance:UnityRegister(usernameStr,passStr,rePassStr,nameStr,
            cardIdStr,telephone,code,
            self, self.normalLogin)
    --if (self:getAge(cardIdStr) and self:getAge(cardIdStr) < 18) then
    --    if not self._info.realForciblySwitchState then
    --        GameTip.showTip("未满18周岁，实名认证失败")
    --    else
    --        --WebSocketManager.instance:Send(60001, { name = nameStr, cardId = cardIdStr, ageType = 0, mobile = telephone });
    --        --self.pageController.selectedIndex = 1
    --        GameTip.showTip("111111111")
    --    end
    --else
    --    --WebSocketManager.instance:Send(60001, { name = nameStr, cardId = cardIdStr, ageType = 1, mobile = telephone });
    --    GameTip.showTip("222222222222")
    --end
end


function UILoginPage:checkCardId(str)
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
function UILoginPage:getAge(identityCard)
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

-- @override 派生类可重写
--@param  param  @type: table, 打开界面时传递的参数
function UILoginPage:StartGames(param)
    --UIConfig.buttonSound = UIPackage.GetItemAssetByURL("Assets/Res/UI/CommonComponent/click.mp3");
    --FairyGUI:SetUIButtonSound
end

function UILoginPage:onRegister()
    self.registerItem.visible=true;
end

function UILoginPage:showRecode()
    Log.info('记住密码功能');
end
function UILoginPage:OnLoginBtn(context)
    --SoundManager.PlayEffect("Music/click")
    if string.len(self.userInput.text) > 0  then
        if self.loginState > 0 then
            GameTip.showTip("操作频繁")
            return
        end
        self.loginState = 1
        self.logintimer = GameTimer.once(1000,self,function()
            self.loginState = 0
        end)
        if string.len(self.passwordInput.text) > 0 then
            ApiManager.instance:UnityLogin(self.userInput.text,self.passwordInput.text, self, self.onLoginSuccess)
        else
            --游客
            ApiManager.instance:ThirdLogin(self.userInput.text, self, self.onLoginSuccess)
        end
    else
        GameTip.showTip("请输入账户名")
    end
end

--注册后直接登录
function UILoginPage:normalLogin(resData)
    local data = resData.data
    if resData.code=="success" then
        GameTip.showTip("注册成功")
        ApiManager.instance:UnityLogin(self.usernameInput.text,self.passInput.text, self, self.onLoginSuccess)
    else
        GameTip.showTip(resData.msg)
    end
end

function UILoginPage:onLoginSuccess(resData)
    self.loginState = 0
    if self.logintimer then
        self.logintimer:clear()
    end
    local data = resData.data

    --if data.access_token then
    --    LoginInfoM:setUserToken(data.access_token)
    --end
    if resData.code=="success" then
        LoginInfoM:setUserToken(data.access_token)
    else
        GameTip.showTip(resData.msg)
        return
    end
    
    local server_domain = data.server_domain;
    local server_name = data.server_name;
    local access_token = data.access_token;
    --RoleInfoM.instance:setAvatar(data.avatar)
    RoleInfoM.instance.jjhId = data.uid
    RoleInfoM.instance.is_test_user = data.is_test_user
    local baseUrl = "wss://"..server_domain.."/".."abbey_test3".."?access="..access_token;
    -- 大刚
    -- local baseUrl = "ws://183.131.147.69:9560/local_server/".."?access=" ..access_token
    -- 王力
    --local baseUrl = "ws://192.168.89.42:5500/local_server/".."?access=" ..access_token
    -- 谭相旭
    -- local baseUrl = "ws://39.108.168.206:5500/abner_sever/".."?access=" ..access_token
    local url = baseUrl.."&login=".."1".."&flag="..TimeTools.getCurMill();

    WebSocketManager.instance:Connect(url);
end

return UILoginPage