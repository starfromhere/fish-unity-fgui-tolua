---@class GoWrapper : DisplayObject
---@field public supportStencil bool
---@field public wrapTarget GameObject
---@field public renderingOrder Int32
local GoWrapper={ }
---@public
---@param value Action`1
---@return void
function GoWrapper:add_onUpdate(value) end
---@public
---@param value Action`1
---@return void
function GoWrapper:remove_onUpdate(value) end
---@public
---@param target GameObject
---@param cloneMaterial bool
---@return void
function GoWrapper:setWrapTarget(target, cloneMaterial) end
---@public
---@param target GameObject
---@param cloneMaterial bool
---@return void
function GoWrapper:SetWrapTarget(target, cloneMaterial) end
---@public
---@return void
function GoWrapper:CacheRenderers() end
---@public
---@param context UpdateContext
---@return void
function GoWrapper:Update(context) end
---@public
---@return void
function GoWrapper:Dispose() end
FairyGUI.GoWrapper = GoWrapper