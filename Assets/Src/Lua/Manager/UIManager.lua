local UIType = require 'UI.Assist.UIType'
local GComponent = FairyGUI.GComponent
local GRoot = FairyGUI.GRoot

---@class UIManager
---@field public instance UIManager
local _M = class("UIManager")

---ctor 构造函数
---@private
---@return void
function _M:ctor()
    self:init()
end

---init 实体类不调用
---@protected
---@return void
function _M:init()

    self._name = ''

    ---@type table<string, UIBase>
    self._caches = {}

    ---@type UIBase
    self._currentView = nil;

    ---@type table<UIType, GComponent>
    self._layers = {}
    ---@type table<UIType, number>
    self._maxIndex = {}

    local layerIndex = {
        UIType.UI_TYPE_NORMAL,
        UIType.UI_TYPE_DLG,
        UIType.UI_TYPE_DISCONNECT,
        UIType.UI_TYPE_MSG_TIP
    }
    for _, key in ipairs(layerIndex) do
        self._layers[key] = GComponent()
        self._layers[key].name = key
        self._maxIndex[key] = 0
        GRoot.inst:AddChild(self._layers[key])
    end
end

---UIInCache
---@public
---@param name string 目前保存的为ui的名称
---@return boolean
function _M:UIInCache(name)
    return self._caches[name] and true or false
end

---raiseZorder  提升ui层级，使得新打开的ui一定是最上层
---@private
---@param view UIBase
---@return void
function _M:raiseZorder(view)
    local uitype = view.uiType;
    local index = self._maxIndex[uitype] + 1
    self._layers[uitype]:SetChildIndex(view.view, index+1)
    self._maxIndex[uitype] = index
end

---LoadView 加载UI界面
---@public
---@param name string 界面名称
---@param param table 创建界面时传递的参数
---@param effectType UIEffectType 打开界面的效果
---@return void
function _M:LoadView(name, param, effectType)
    name = name or ''
    param = param or nil
    effectType = effectType or nil

    if (name == 'MonthCard') then
        GameEventDispatch:event(GameEvent.MsgTipContent, "需要月卡");
    elseif name == 'FirstCharge' then
        GameEventDispatch:event(GameEvent.MsgTipContent, "功能未开放");
    else
        effectType = effectType or UIEffectType.SMALL_TO_BIG;
        self._name = name
        --if self._name ~= "HorseTip" then
        --    GameEventDispatch:event(GameEvent.OpenWait);
        --end

        if self:UIInCache(name) then
            local cacheView = self._caches[name]
            --self._currentView = self._caches[name]
            if cacheView.view and not cacheView.view.visible then
                self:raiseZorder(cacheView)
                self._currentView = cacheView
                self._currentView:_startGame(param, effectType);
            end
        else
            self:CreateUI(name, param, effectType);
        end
    end
end

---CreateUI 根据UI名称创建UI, TODO: 目前这样做绑定了UI名称，需要灵活处理,改用ID
---@private
---@param name string 界面名称
---@param param table 创建界面时传递的参数
---@param effectType UIEffectType
---@return UIBase 返回对应的UI界面
function _M:CreateUI(name, param, effectType)
    local pageClass = require("UI.UI" .. name);
    Log.debug("CreateUI  ------------>>> ", "UI.UI" .. name)
    local page = pageClass.new();
    pageClass.instance = page
    self._caches[name] = page;
    self._currentView = page;

    local uitype = self._currentView.uiType;
    self._layers[uitype]:AddChild(self._currentView.view)
    self._maxIndex[uitype] = self._layers[uitype]:GetChildIndex(self._currentView.view)

    if self._currentView.initComponent then
        self._currentView:initComponent(param)
    end
    self._currentView:_startGame(param, effectType)
    GameEventDispatch.instance:Event(GameEvent.LoadUi, name);
    return page;
    -- return fgui page entity
end

---ClosePanel 关闭已打开界面
---@public
---@param name string  界面名称
---@param isRemove boolean  关闭界面时是否从缓存移除
---@param effectType UIEffectType  关闭界面的效果
---@return void
function _M:ClosePanel(name, effectType, isRemove)
    assert(name ~= nil and #name > 0, "invalid page name  " .. name)
    effectType = effectType or nil
    isRemove = isRemove or isRemove

    local page = self._caches[name]
    if page then
        page:_closePage()
    end
    if isRemove then
        page:Remove()
        self._caches[name] = nil
    end

    GameEventDispatch.instance:Event(GameEvent.CloseUi, name);
end

UIManager = UIManager or {}
setmetatable(UIManager, { __index = function(_, v)
    return _M.instance[v]
end })