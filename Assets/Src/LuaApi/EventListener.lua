---@class EventListener : Object
---@field public type string
---@field public isEmpty bool
---@field public isDispatching bool
local EventListener={ }
---@public
---@param callback EventCallback1
---@return void
function EventListener:AddCapture(callback) end
---@public
---@param callback EventCallback1
---@return void
function EventListener:RemoveCapture(callback) end
---@public
---@param callback EventCallback1
---@return void
function EventListener:Add(callback) end
---@public
---@param callback EventCallback1
---@return void
function EventListener:Remove(callback) end
---@public
---@param callback EventCallback1
---@return void
function EventListener:Set(callback) end
---@public
---@param func LuaFunction
---@param self LuaTable
---@return void
function EventListener:Add(func, self) end
---@public
---@param func LuaFunction
---@param self GComponent
---@return void
function EventListener:Add(func, self) end
---@public
---@param func LuaFunction
---@param self LuaTable
---@return void
function EventListener:Remove(func, self) end
---@public
---@param func LuaFunction
---@param self GComponent
---@return void
function EventListener:Remove(func, self) end
---@public
---@param func LuaFunction
---@param self LuaTable
---@return void
function EventListener:Set(func, self) end
---@public
---@param func LuaFunction
---@param self GComponent
---@return void
function EventListener:Set(func, self) end
---@public
---@return void
function EventListener:Clear() end
---@public
---@return bool
function EventListener:Call() end
---@public
---@param data Object
---@return bool
function EventListener:Call(data) end
---@public
---@param data Object
---@return bool
function EventListener:BubbleCall(data) end
---@public
---@return bool
function EventListener:BubbleCall() end
---@public
---@param data Object
---@return bool
function EventListener:BroadcastCall(data) end
---@public
---@return bool
function EventListener:BroadcastCall() end
FairyGUI.EventListener = EventListener