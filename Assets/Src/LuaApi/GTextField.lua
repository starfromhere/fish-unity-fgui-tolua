---@class GTextField : GObject
---@field public text string
---@field public templateVars Dictionary`2
---@field public textFormat TextFormat
---@field public color Color
---@field public align number
---@field public verticalAlign number
---@field public singleLine bool
---@field public stroke Single
---@field public strokeColor Color
---@field public shadowOffset Vector2
---@field public UBBEnabled bool
---@field public autoSize number
---@field public textWidth Single
---@field public textHeight Single
local GTextField={ }
---@public
---@param name string
---@param value string
---@return GTextField
function GTextField:SetVar(name, value) end
---@public
---@return void
function GTextField:FlushVars() end
---@public
---@param ch Char
---@return bool
function GTextField:HasCharacter(ch) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GTextField:Setup_BeforeAdd(buffer, beginPos) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GTextField:Setup_AfterAdd(buffer, beginPos) end
FairyGUI.GTextField = GTextField