---@class GObjectPool : Object
---@field public initCallback InitCallbackDelegate
---@field public count Int32
local GObjectPool={ }
---@public
---@return void
function GObjectPool:Clear() end
---@public
---@param url string
---@return GObject
function GObjectPool:GetObject(url) end
---@public
---@param obj GObject
---@return void
function GObjectPool:ReturnObject(obj) end
FairyGUI.GObjectPool = GObjectPool