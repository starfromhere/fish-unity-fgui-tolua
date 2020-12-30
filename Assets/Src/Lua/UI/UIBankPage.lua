---@class UIBankPage :UIDialogBase
local UIBankPage = class("UIBankPage", UIDialogBase)

function UIBankPage:init()
    self.packageName = "Bank"
    self.resName = "BankPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil

    self.BankInfo = nil;
    self.Bind = nil;
    self.Title = nil;
    self.timer = nil;
    self.getCodeTimer = nil;
    self.bindCountDownNum = 0;
end

function UIBankPage:StartGames(param)


    self:initView()
end

function UIBankPage:initComponent()

    self.contentView = self.view:GetChild("bankInfoView")

    self.telLabel = self.contentView:GetChild("telLabel")
    self.jjhIdLabel = self.contentView:GetChild("jjhIdLabel")
    self.carryCoin = self.contentView:GetChild("carryCoin")
    self.bankCoin = self.contentView:GetChild("bankCoin")
    self.depositTxt = self.contentView:GetChild("depositTxt")
    self.takeTxt = self.contentView:GetChild("takeTxt")
    self.bankPassword = self.contentView:GetChild("bankPassword")
    self.depositBtn = self.contentView:GetChild("depositBtn")
    self.takeBtn = self.contentView:GetChild("takeBtn")
    self.BankInfoQuitBtn = self.contentView:GetChild("BankInfoQuitBtn")

    self.depositBtn:onClick(self.onDeposit, self)
    self.takeBtn:onClick(self.onTake, self)

    self.BankInfoQuitBtn:onClick(self.onQuitClick, self)
end

function UIBankPage:initView()

    if self.timer then
        self.timer:clear()
    end

    self:initCoin();
    self:initPage();
end

function UIBankPage:initPage()
    self:cleanTextInput()
    self:setBindTel();
    self:addTimer()
end

function UIBankPage:setBindTel()
    self.telLabel.text = RoleInfoM.instance.jjhNumber;
    self.jjhIdLabel.text = RoleInfoM.instance.jjhId;
end

function UIBankPage:addTimer()
    self.timer = GameTimer.loop(10000, self, self.synCoin);
end

function UIBankPage:synCoin()
    NetSender.GetBankInfo()
end

function UIBankPage:initCoin()
    self.carryCoin.text = RoleInfoM.instance:getCoin()
    self.bankCoin.text = RoleInfoM.instance:getBankCoin()
end

function UIBankPage:onDeposit()
    local nums = tonumber(self.depositTxt.text)
    if string.len(self.depositTxt.text) == 0 then
        GameTip.showTip("请输入正确的金额")
    elseif nums < 50000 then
        GameTip.showTip("每次最少存入5万金币")
    elseif nums > 50000000 then
        GameTip.showTip("每次最多存入5000万金币")
    elseif nums > RoleInfoM.instance:getCoin() then
        GameTip.showTip("存入金币数量已超出携带金币数量")
    else
        NetSender.SaveMoney( { gold = nums })
    end
end

function UIBankPage:onTake()
    local nums = tonumber(self.takeTxt.text)
    if string.len(self.takeTxt.text) == 0 then
        GameTip.showTip("请输入正确的金额")
    elseif string.len(self.bankPassword.text) == 0 then
        GameTip.showTip("请输入密码")
    elseif nums < 50000 then
        GameTip.showTip("每次最少取出5万金币")
    elseif nums > 50000000 then
        GameTip.showTip("每次最多取出5000万金币")
    elseif nums > RoleInfoM.instance.bank_gold then
        GameTip.showTip("取出的金币数量已超出银行金币数量")
    else
        local password = self.bankPassword.text
        NetSender.WithdrawMoney(33004, { gold = nums, password = password })
    end
end

function UIBankPage:cleanTextInput()
    self.depositTxt.text = ""
    self.takeTxt.text = ""
    self.bankPassword.text = ""
end

function UIBankPage:onQuitClick()
    if self.timer then
        self.timer:clear()
    end
    UIManager:ClosePanel("BankPage",nil, false)
end

function UIBankPage:bankUpdate()
    self:initPage();
    self:initCoin();
    self:setBindTel()
end

--@override 注册事件监听
function UIBankPage:Register()
    self:AddRegister(GameEvent.BankUpdate, self, self.bankUpdate)
    self:AddRegister(GameEvent.EndBankTake, self, self.cleanTextInput);
    self:AddRegister(GameEvent.EndBankDeposit, self, self.cleanTextInput);
    self:AddRegister(GameEvent.SyncBankCoin, self, self.setBindTel);
end

return UIBankPage