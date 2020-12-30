---@class GSlider : GComponent
---@field public changeOnClick bool
---@field public canDrag bool
---@field public onChanged EventListener
---@field public onGripTouchEnd EventListener
---@field public titleType number
---@field public min number
---@field public max number
---@field public value number
---@field public wholeNumbers bool
local GSlider={ }
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GSlider:Setup_AfterAdd(buffer, beginPos) end
FairyGUI.GSlider = GSlider