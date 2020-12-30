local UIType = require 'UI.Assist.UIType'

---@class UIBase
UIBase = class("UIBase")

---ctor
---@protected
---@param name table
---@param type table
---@return UIBase
function UIBase:ctor(name, type)
    self:_init(name, type)
    self:init()

    -- 此时ui还没有创建
    self:loadPackage();
end

-- @Rule 双下划线给基类使用
---_init
---@private
---@param name table
---@param type table
---@return void
function UIBase:_init(name, type)
    self.packageName = name
    self.resName = name and name .. "Page" or nil
    self.FullScreen = true
    self.showEffectType = UIEffectType.NORMAL
    self.hideEffectType = UIEffectType.NORMAL

    ---@type GComponent
    self.view = nil
    self.uiType = type or UIType.UI_TYPE_NORMAL;
end

---@_startGame
---@private
---@param param table  打开界面时传递的参数
---@param effectType UIEffectType  打开界面时传递的缓动动画效果
---@return void
function UIBase:_startGame(param, effectType)
    -- TODO
    self:Register()
    self:OnShow(effectType)
    self:StartGames(param)
end

---_closePage 关闭界面
---@public
---@param effectType UIEffectType 关闭界面的效果
---@return void
function UIBase:_closePage(effectType)
    self:OnHide(effectType);
    self:UnRegister();
end

-- TODO 优化
---loadPackage @override 派生类可重写
---@protected
---@return void
function UIBase:loadPackage()
    UIPackageManager.instance:AddPackage("Assets/Res/UI/" .. self.packageName .. "/" .. self.packageName, self.packageName)
    self.view = UIPackage.CreateObject(self.packageName, self.resName)
    -- 第一次创建出来默认隐藏
    self.view.visible = false;
    if self.view == nil then
        Log.error("CreateUI Error", self.packageName, self.resName)
    end
end

---init @override 派生类可重写，成员变量或者其他内容的初始化
---@protected
---@return void
function UIBase:init()
end

---initComponent @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
---@protected
---@return void
function UIBase:initComponent()
end

---@override 派生类可重写
---update
---@private
---@param delta number 每帧更新间隔时间
---@return void
function UIBase:update(delta)
    -- TODO
end

---StartGames @override 派生类可重写
---@public
---@param param table 打开界面时传递的参数
---@return void
function UIBase:StartGames(param)

end

function UIBase:AddRegister(eventType, caller, func)
    if not self.registerArr then
        self.registerArr = {}
    end
    local temp = { eventType = eventType, caller = caller, func = func }
    table.insert(self.registerArr, temp)
    GameEventDispatch.instance:On(temp.eventType, temp.caller, temp.func);
end

function UIBase:ClearRegister()
    if not self.registerArr or #self.registerArr <= 0 then
        return
    end
    for i = #self.registerArr, 1, -1 do
        local temp = self.registerArr[i]
        table.remove(self.registerArr, i)
        GameEventDispatch.instance:Off(temp.eventType, temp.caller, temp.func);
    end
end

---Register @override 注册监听
---@public
---@return void
function UIBase:Register()

end

---UnRegister @override 移除监听
---@public
---@return void
function UIBase:UnRegister()
    self:ClearRegister()
end

---OnShow  打开界面
---@public
---@param effectType UIEffectType 打开界面效果
---@return GComponent
function UIBase:OnShow(effectType)
    if self.view == nil then
        Log.fatal("invalid view")
    end

    if UIManager._currentView.FullScreen then
        UIManager._currentView.view:MakeFullScreen()
    end

    if not self.view.visible then
        self.view.visible = true;
        effectType = effectType
        UIEffectManager.Create(self.view, effectType)
    end
    Log.debug("show" .. self.resName .. " Page")
    return self.view
end

---OnHide   关闭界面
---@public
---@param effectType UIEffectType  关闭界面的效果
---@return GComponent
function UIBase:OnHide(effectType)
    if self.view == nil then
        Log.fatal("invalid view")
    end
    local handler = Handler.Create(function()
        self.view.visible = false
    end)
    effectType = effectType or nil
    UIEffectManager.Create(self.view, effectType, handler)
    self.view.visible = false;
    Log.debug("Hide" .. self.resName .. " Page")
end

---Remove 移除引用对象释放内存
---@public
---@return void
function UIBase:Remove()
    self.view:RemoveFromParent()
    self.view:Dispose();
    self:RemovePackage()
end

---RemovePackage 从内存中移除 fgui包
---@public
---@return void
function UIBase:RemovePackage()
    UIPackageManager.instance:RemovePackage(self.packageName)
end

-- 创建UI界面，class中调用
--function UIBase.create()
--    return UIBase.new()
--end

return UIBase