---@class UIHorseTipPage :UIBase
local UIHorseTipPage = class("UIHorseTipPage", UIBase)

---init @override 派生类可重写，成员变量或者其他内容的初始化
---@protected
---@return void
function UIHorseTipPage:init()
    self.packageName = "HorseTip"
    self.resName = "HorseTipPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.showEffectType = UIEffectType.SMALL_TO_BIG
    self.hideEffectType = UIEffectType.BIG_TO_SMALL
    self.uiType = UIType.UI_TYPE_MSG_TIP

    self.horseCount = 0
    self.timeHandle = nil
end

---initComponent @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
---@protected
---@return void
function UIHorseTipPage:initComponent()
    self.panel = self.view:GetChild("panel")
    self.htmlText = self.panel:GetChildAt(0):GetChild("htmlDiv")
end

---StartGames @override 派生类可重写
---@public
---@param param table 打开界面时传递的参数
---@return void
function UIHorseTipPage:StartGames(param)
    self:showHorse()
    self:initData()
end

function UIHorseTipPage:showHorse()
    if self.horseCount <= 0 and HorseM.instance:getHorseTipNum() > 0 then
        self.htmlText.text = HorseM.instance:getHtml()
        self.htmlText.x = self.panel.width + 10
        self.horseCount = HorseM.instance:getRepeatNum()
        self.htmlText.width = HorseM.instance:getHtmlWidth()
    end
end

function UIHorseTipPage:initData()
    if not self.timeHandle then
        self.timeHandle = GameTimer.loop(100, self, self.start)
    end
end

function UIHorseTipPage:start()
    if self.htmlText then
        self.htmlText.x = self.htmlText.x - 3
        if (self.htmlText.width + self.htmlText.x) < -10 then
            self.htmlText.x = self.panel.width + 10
            self.horseCount = self.horseCount - 1
            if self.horseCount > 0 then
                self.htmlText.x = self.panel.width + 10
            else
                if HorseM.instance:getHorseTipNum() > 0 then
                    self:showHorse()
                else
                    self.timeHandle:clear()
                    self.timeHandle = nil
                    HorseM.instance:setIsIn(false)
                    UIManager:ClosePanel("HorseTipPage")
                end
            end
        end
    end
end

return UIHorseTipPage