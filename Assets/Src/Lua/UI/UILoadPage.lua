---@class UILoadPage :UIBase
local UILoadPage = class("UILoadPage", UIBase)

function UILoadPage:init()
    self.packageName = "Load"
    self.resName = "LoadPage"
    self.view = nil  -- 界面对象引用
    self.uiType = UIType.UI_TYPE_DLG

    ---@type GTextField
    self.textInfo = nil
    ---@type GProgressBar
    self.progress = nil
    
    self.currentText = ""
end

function UILoadPage:initComponent()
    self.textInfo = self.view:GetChild("tex_info")
    self.progress = self.view:GetChild("pb_progress")

end

function UILoadPage:StartGames(param)
    self.progress.value = 0
    self.currentText = "正在初始化游戏场景......"
    self.textInfo.text = self.currentText
end

function UILoadPage:Register()
    self:AddRegister(GameEvent.LoadPressBarChange, self, self.onPressChange);
end

function UILoadPage:onPressChange(value, text)
    self.progress:TweenValue(value, 0.1)
    if text and self.currentText ~= text then
        self.currentText = text
        self.textInfo.text = self.currentText
    end
end

return UILoadPage