---@class UIQuitTipPage :UIDialogBase
local UIQuitTipPage = class("UIQuitTipPage", UIDialogBase)

function UIQuitTipPage:init()
    self.packageName = "QuitTip"
    self.resName = "QuitTipPage"
    self.uiType = UIType.UI_TYPE_DLG
    self.view = nil  -- 界面对象引用

    ---@type ConfirmTipInfo
    self.info = nil

    self.count = 0
    self.timeContent = nil

    self.leftBtn = nil
    self.middleBtn = nil
    self.rightBtn = nil

    self.timeContent = nil
    self.timer = nil
end

function UIQuitTipPage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.leftBtn = self.contentView:GetChild("CancelBtn")
    self.middleBtn = self.contentView:GetChild("cBtn")
    self.rightBtn = self.contentView:GetChild("ConfirmBtn")

    self.timeContent = self.contentView:GetChild("timeContent")
    self.mainContent = self.contentView:GetChild("context")
end

---@param info ConfirmTipInfo
function UIQuitTipPage:StartGames(info)
    Log.debug("UIQuitTipPage:StartGames", info.state, info.content)
    self.info = info

    self.leftBtn.visible = bit.band(info.state, ConfirmTipInfo.Left) > 0
    self.middleBtn.visible = bit.band(info.state, ConfirmTipInfo.Middle) > 0
    self.rightBtn.visible = bit.band(info.state, ConfirmTipInfo.Right) > 0

    self.rightBtn:onClick(function()
        if self.info.rightClick then
            self.info.rightClick()
        end
        self:closePage()
    end, self)

    self.middleBtn:onClick(function()
        if self.info.middleClick then
            self.info.middleClick()
        end
        self:closePage()
    end, self)
    self.leftBtn:onClick(function()
        if self.info.leftClick then
            self.info.leftClick()
        end
        self:closePage()
    end, self)

    if info.autoCloseTime > 0 then
        self.timeContent.visible = true
        self.count = info.autoCloseTime
        self.timer = GameTimer.loop(1000, self, self.loopTick);
    else 
        self.timeContent.visible = false
    end
    self.mainContent.text = self.info.content

    self:setBtnText(self.leftBtn, self.info.leftTxt)
    self:setBtnText(self.middleBtn, self.info.middleTxt)
    self:setBtnText(self.rightBtn, self.info.rightTxt)

    self:updateCount(self.count)

end

---@param btn GComponent
function UIQuitTipPage:setBtnText(btn, text)
    btn:GetChild("title").text = text
end

function UIQuitTipPage:loopTick()
    self.count = self.count - 1
    self:updateCount(self.count)
    if self.count <= 0 then
        self:closePage()
    end
end

function UIQuitTipPage:updateCount(count)
    self.timeContent.text = "（" .. tostring(count) .. "秒以后自动关闭）"
end

function UIQuitTipPage:closePage()
    if self.timer then
        self.timer:clear()
    end
    UIManager:ClosePanel("QuitTipPage", true)
end

return UIQuitTipPage