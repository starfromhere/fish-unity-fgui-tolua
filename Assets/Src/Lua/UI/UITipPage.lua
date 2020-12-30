
---@class UITipPage :UIBase
local UITipPage = class("UITipPage", UIBase)

function UITipPage:init()
    self.packageName = "Tip"
    self.resName = "TipPage"
    self.uiType = UIType.UI_TYPE_MSG_TIP
    self.view = nil  -- 界面对象引用
    self.param = ""
end

function UITipPage:Register()
    self:AddRegister(GameEvent.CreateTipItem, self, self.CreateItem);
end

function UITipPage:StartGames(param)
   self:CreateItem(param)
end

function UITipPage:CreateItem(text)
    if is_empty(text) then
        return
    end
    ---@type GComponent
    local item = UIPackage.CreateObject("Tip","TipItem")
    item.pivot = Vector2.New(0.5,0.5)
    item.pivotAsAnchor = true
    self.view:AddChild(item)
    item.position = self.pos
    local tipText = item:GetChild("tipText")
    local bgImg = item:GetChild("bgImg")
    tipText.text = text
    local tipTween = item:GetTransition("tipAni")
    tipTween:Play(self.playCallback)
end

function UITipPage:initComponent(param)
    self.pos = Vector3.New(GameScreen.instance.adaptWidth / 2,GameScreen.instance.adaptHeight / 2,1000)
end

function UITipPage:playCallback()

end

function UITipPage:closePanel()
    UIManager:ClosePanel("TipPage",nil,true)
end

return UITipPage