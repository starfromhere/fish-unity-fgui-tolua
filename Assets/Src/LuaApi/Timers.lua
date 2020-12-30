---@class Timers : Object
---@field public repeat Int32
---@field public time Single
---@field public catchCallbackExceptions bool
---@field public inst Timers
local Timers={ }
---@public
---@param interval Single
---@param repeat Int32
---@param callback TimerCallback
---@return void
function Timers:Add(interval, repeat, callback) end
---@public
---@param interval Single
---@param repeat Int32
---@param callback TimerCallback
---@param callbackParam Object
---@return void
function Timers:Add(interval, repeat, callback, callbackParam) end
---@public
---@param callback TimerCallback
---@return void
function Timers:CallLater(callback) end
---@public
---@param callback TimerCallback
---@param callbackParam Object
---@return void
function Timers:CallLater(callback, callbackParam) end
---@public
---@param callback TimerCallback
---@return void
function Timers:AddUpdate(callback) end
---@public
---@param callback TimerCallback
---@param callbackParam Object
---@return void
function Timers:AddUpdate(callback, callbackParam) end
---@public
---@param routine IEnumerator
---@return void
function Timers:StartCoroutine(routine) end
---@public
---@param callback TimerCallback
---@return bool
function Timers:Exists(callback) end
---@public
---@param callback TimerCallback
---@return void
function Timers:Remove(callback) end
---@public
---@return void
function Timers:Update() end
FairyGUI.Timers = Timers