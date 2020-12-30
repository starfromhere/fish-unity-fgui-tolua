---@class EventDispatcher : Object
local EventDispatcher={ }
---@public
---@param strType string
---@param callback EventCallback1
---@return void
function EventDispatcher:AddEventListener(strType, callback) end
---@public
---@param strType string
---@param callback EventCallback0
---@return void
function EventDispatcher:AddEventListener(strType, callback) end
---@public
---@param strType string
---@param callback EventCallback1
---@return void
function EventDispatcher:RemoveEventListener(strType, callback) end
---@public
---@param strType string
---@param callback EventCallback0
---@return void
function EventDispatcher:RemoveEventListener(strType, callback) end
---@public
---@param strType string
---@param callback EventCallback1
---@return void
function EventDispatcher:AddCapture(strType, callback) end
---@public
---@param strType string
---@param callback EventCallback1
---@return void
function EventDispatcher:RemoveCapture(strType, callback) end
---@public
---@return void
function EventDispatcher:RemoveEventListeners() end
---@public
---@param strType string
---@return void
function EventDispatcher:RemoveEventListeners(strType) end
---@public
---@param strType string
---@return bool
function EventDispatcher:hasEventListeners(strType) end
---@public
---@param strType string
---@return bool
function EventDispatcher:isDispatching(strType) end
---@public
---@param strType string
---@return bool
function EventDispatcher:DispatchEvent(strType) end
---@public
---@param strType string
---@param data Object
---@return bool
function EventDispatcher:DispatchEvent(strType, data) end
---@public
---@param strType string
---@param data Object
---@param initiator Object
---@return bool
function EventDispatcher:DispatchEvent(strType, data, initiator) end
---@public
---@param context EventContext
---@return bool
function EventDispatcher:DispatchEvent(context) end
---@public
---@param strType string
---@param data Object
---@return bool
function EventDispatcher:BubbleEvent(strType, data) end
---@public
---@param strType string
---@param data Object
---@return bool
function EventDispatcher:BroadcastEvent(strType, data) end
FairyGUI.EventDispatcher = EventDispatcher