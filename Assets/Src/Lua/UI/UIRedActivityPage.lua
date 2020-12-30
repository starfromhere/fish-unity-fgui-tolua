
---@class UIRedActivityPage :UIDialogBase
local UIRedActivityPage = class("UIRedActivityPage", UIDialogBase)

---init @override 派生类可重写，成员变量或者其他内容的初始化
---@protected
---@return void
function UIRedActivityPage:init()
    self.packageName = "RedActivity"
    self.resName = "RedActivityPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.showEffectType = UIEffectType.SMALL_TO_BIG
    self.hideEffectType = UIEffectType.BIG_TO_SMALL
end

---initComponent @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
---@protected
---@return void
function UIRedActivityPage:initComponent()

    self.contentView = self.view:GetChild("contentView")
    self.quitBtn = self.contentView:GetChild("quitBtn")
    self.quitBtn:onClick(self.onQuitBtn, self)
end

---StartGames @override 派生类可重写
---@public
---@param param table 打开界面时传递的参数
---@return void
function UIRedActivityPage:StartGames(param)
end

function UIRedActivityPage:onQuitBtn()
    UIManager:ClosePanel("RedActivityPage")
end

return UIRedActivityPage