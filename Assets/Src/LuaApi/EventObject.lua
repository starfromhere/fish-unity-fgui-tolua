---@class EventObject : Object
local EventObject={ }
---@public
---@param a EventObject
---@param b Delegate
---@return EventObject
function EventObject.op_Addition(a, b) end
---@public
---@param a EventObject
---@param b Delegate
---@return EventObject
function EventObject.op_Subtraction(a, b) end
LuaInterface.EventObject = EventObject