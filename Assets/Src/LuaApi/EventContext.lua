---@class EventContext : Object
---@field public type string
---@field public data Object
---@field public sender EventDispatcher
---@field public initiator Object
---@field public inputEvent InputEvent
---@field public isDefaultPrevented bool
local EventContext={ }
---@public
---@return void
function EventContext:StopPropagation() end
---@public
---@return void
function EventContext:PreventDefault() end
---@public
---@return void
function EventContext:CaptureTouch() end
FairyGUI.EventContext = EventContext