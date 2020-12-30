---@class Button : GButton
Button = fgui.extension_class(GButton)

--注意这里不是构造函数，是当组件已经构建完毕后调用的

function Button:ctor(...)
    self:init()
end

--init mybutton
function Button:init(...)
    self.audioClipPath = "Music/click.mp3"
    --self.sound = UIPackage.GetItemAssetByURL(str)
end

function Button:setAudioClip(path)
    self.audioClipPath = path
end

--添加自定义的方法和字段
function Button:onClick(func, caller, ...)
    local data = {...}
    local callback = function(_,context)
        table.insert(data, context)
        self:onClickEffect()
        if caller then
            func(caller, unpack(data))
        else
            func(unpack(data))
        end
    end

    self.base.onClick:Set(callback, self)
end

function Button:onClickEffect()
    if self.audioClipPath then
        SoundManager.PlayEffect(self.audioClipPath)
    end
end

local get = tolua.initget(Button)
local set = tolua.initset(Button)
get.myProp = function(self)
    return self._myProp
end

set.myProp = function(self, value)
    self._myProp = value
    self.text = value
end

fgui.register_extension("ui://CommonComponent/greenButton", Button)
fgui.register_extension("ui://CommonComponent/orangeButton", Button)
fgui.register_extension("ui://CommonComponent/quitButton", Button)
fgui.register_extension("ui://CommonComponent/blueButton", Button)
fgui.register_extension("ui://CommonComponent/midGreenButton", Button)
fgui.register_extension("ui://CommonComponent/CommonBtn", Button)
fgui.register_extension("ui://CommonComponent/scrollButton", Button)

fgui.register_extension("ui://ChangeSkin/Button1", Button)

fgui.register_extension("ui://Exchange/Button", Button)
fgui.register_extension("ui://Exchange/alipayButton", Button)
fgui.register_extension("ui://Exchange/orderButton", Button)
fgui.register_extension("ui://Exchange/tabButton", Button)
fgui.register_extension("ui://Exchange/wxButton", Button)

fgui.register_extension("ui://ChangeSkin/Button1", Button)

fgui.register_extension("ui://Login/Button2", Button)
fgui.register_extension("ui://Login/blueButton", Button)

fgui.register_extension("ui://Fish/Button", Button)
fgui.register_extension("ui://Fish/Button2", Button)
fgui.register_extension("ui://Fish/Button3", Button)
fgui.register_extension("ui://Fish/Button4", Button)
fgui.register_extension("ui://Fish/btn_boom", Button)
fgui.register_extension("ui://Fish/btn_skill", Button)
fgui.register_extension("ui://Fish/zeroButton", Button)

fgui.register_extension("ui://Info/copyBtn", Button)
fgui.register_extension("ui://Info/editBtn", Button)
fgui.register_extension("ui://Info/changeBtn", Button)
fgui.register_extension("ui://Pack/Button1", Button)

fgui.register_extension("ui://Main/Button2", Button)
fgui.register_extension("ui://Main/Button3", Button)
fgui.register_extension("ui://Main/FastButton", Button)
fgui.register_extension("ui://Setting/Button1", Button)

fgui.register_extension("ui://Rank/coinButton", Button)
fgui.register_extension("ui://Rank/strengeButton", Button)
fgui.register_extension("ui://Register/btn", Button)
fgui.register_extension("ui://Reward/tab_btn", Button)
fgui.register_extension("ui://Reward/leftIconText", Button)
fgui.register_extension("ui://TaskNew/Button", Button)
fgui.register_extension("ui://TaskNew/ItemVital", Button)
fgui.register_extension("ui://TaskNew/taskButton", Button)
fgui.register_extension("ui://TaskNew/orangeButton", Button)
fgui.register_extension("ui://TaskNew/lotteryButton", Button)
fgui.register_extension("ui://TaskNew/greenButton", Button)
fgui.register_extension("ui://Shop/Btn", Button)