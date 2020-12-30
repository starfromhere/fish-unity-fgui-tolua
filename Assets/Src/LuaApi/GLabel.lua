---@class GLabel : GComponent
---@field public icon string
---@field public title string
---@field public text string
---@field public editable bool
---@field public titleColor Color
---@field public titleFontSize Int32
---@field public color Color
local GLabel={ }
---@public
---@return GTextField
function GLabel:GetTextField() end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GLabel:Setup_AfterAdd(buffer, beginPos) end
FairyGUI.GLabel = GLabel