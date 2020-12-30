---@class TextFormat : Object
---@field public size Int32
---@field public font string
---@field public color Color
---@field public lineSpacing Int32
---@field public letterSpacing Int32
---@field public bold bool
---@field public underline bool
---@field public italic bool
---@field public strikethrough bool
---@field public gradientColor Color32[]
---@field public align number
---@field public specialStyle number
---@field public outline Single
---@field public outlineColor Color
---@field public shadowOffset Vector2
---@field public shadowColor Color
local TextFormat={ }
---@public
---@param value UInt32
---@return void
function TextFormat:SetColor(value) end
---@public
---@param aFormat TextFormat
---@return bool
function TextFormat:EqualStyle(aFormat) end
---@public
---@param source TextFormat
---@return void
function TextFormat:CopyFrom(source) end
---@public
---@param vertexColors Color32[]
---@return void
function TextFormat:FillVertexColors(vertexColors) end
FairyGUI.TextFormat = TextFormat