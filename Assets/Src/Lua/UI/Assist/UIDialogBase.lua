---@class UIDialogBase:UIBase
UIDialogBase = class("Dialog", UIBase)

-- @Rule 双下划线给基类使用
---_init
---@private
---@param name table
---@param type table
---@return void
function UIDialogBase:_init(name, type)
    self.packageName = name
    self.resName = name and name .. "Page" or nil
    self.FullScreen = true
    self.showEffectType = UIEffectType.NORMAL
    self.hideEffectType = UIEffectType.NORMAL

    ---@type GComponent
    self.view = nil
    
    ---@type GComponent
    self.bgMask = nil

    ---@type GComponent
    self.contentView = nil
    self.uiType = type or UIType.UI_TYPE_NORMAL;
end

function UIDialogBase:loadPackage()
    UIPackageManager.instance:AddPackage("Assets/Res/UI/" .. self.packageName .. "/" .. self.packageName, self.packageName)
    self.view = UIPackage.CreateObject(self.packageName, self.resName)
    -- 第一次创建出来默认隐藏
    self.view.visible = false;
    if self.view == nil then
        Log.error("CreateUI Error", self.packageName, self.resName)
    end
    
    ---@type GComponent
    self.bgMask = UIPackage.CreateObject("CommonComponent", "MaskPanel")
    ---@type GComponent
    self.view:AddChild(self.bgMask)
    self.view:SetChildIndex(self.bgMask, 0)
    self.bgMask:AddRelation(self.view, RelationType.Width)
    self.bgMask:AddRelation(self.view, RelationType.Height)
end

---OnShow  打开界面
---@public
---@param effectType UIEffectType 打开界面效果
---@return GComponent
function UIDialogBase:OnShow(effectType)
    if self.view == nil then
        Log.fatal("invalid view")
    end

    if UIManager._currentView.FullScreen then
        UIManager._currentView.view:MakeFullScreen()
    end

    if UIManager._currentView.contentView then
        UIManager._currentView.contentView:MakeFullScreen()
    end

    if not self.view.visible then
        self.view.visible = true;
        effectType = effectType
        UIEffectManager.Create(self.contentView, effectType)
    end
    Log.debug("show" .. self.resName .. " Dialog")
    return self.view
end

---OnHide   关闭界面
---@public
---@param effectType UIEffectType  关闭界面的效果
---@return GComponent
function UIDialogBase:OnHide(effectType)
    if self.view == nil then
        Log.fatal("invalid view")
    end
    local handler = Handler.Create(function()
        self.view.visible = false
    end)
    effectType = effectType or nil
    UIEffectManager.Create(self.contentView, effectType, handler)
    self.view.visible = false;
    Log.debug("Hide" .. self.resName .. " Dialog")
end