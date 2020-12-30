---@class UIBrokePage :UIDialogBase
local UIBrokePage = class("UIBrokePage",UIDialogBase)

function UIBrokePage:init()
    self.packageName = "Broke"
    self.resName = "BrokePage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
end

function UIBrokePage:StartGames(param)
    self.contentView = self.view:GetChild("contentView")


    self.contentView:GetChild("ConfirmBtn"):onClick(self.onConfirmBtnClick,self)
    self.contentView:GetChild("CancelBtn"):onClick(self.onCancelClick,self)
    self:initView()
end


function UIBrokePage:initView()
end

function UIBrokePage:onConfirmBtnClick()
end


function UIBrokePage:onCancelClick()
    UIManager:ClosePanel("BrokePage",nil, false)
end


return UIBrokePage