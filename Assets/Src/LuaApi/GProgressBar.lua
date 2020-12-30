---@class GProgressBar : GComponent
---@field public titleType number
---@field public min number
---@field public max number
---@field public value number
---@field public reverse bool
local GProgressBar={ }
---@public
---@param value number
---@param duration Single
---@return GTweener
function GProgressBar:TweenValue(value, duration) end
---@public
---@param newValue number
---@return void
function GProgressBar:Update(newValue) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GProgressBar:Setup_AfterAdd(buffer, beginPos) end
FairyGUI.GProgressBar = GProgressBar