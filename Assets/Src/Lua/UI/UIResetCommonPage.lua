---@class ResetInfo
---@field New ResetInfo
ResetInfo = class("ResetInfo")
function ResetInfo:ctor()
    self.callback = nil
    self.title = nil
    self.tip = nil
    self.autoReconnect = false
end

---@class UIResetCommonPage :UIBase
local UIResetCommonPage = class("UIResetCommonPage", UIBase)

function UIResetCommonPage:init()
    self.packageName = "ResetCommon"
    self.resName = "ResetCommonPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.uiType = UIType.UI_TYPE_DISCONNECT
end

---@param param ResetInfo
function UIResetCommonPage:StartGames(param)

end

function UIResetCommonPage:initComponent()

end

return UIResetCommonPage
