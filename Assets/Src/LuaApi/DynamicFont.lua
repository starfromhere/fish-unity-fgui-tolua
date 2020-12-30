---@class DynamicFont : BaseFont
---@field public nativeFont Font
local DynamicFont={ }
---@public
---@return void
function DynamicFont:Dispose() end
---@public
---@param format TextFormat
---@param fontSizeScale Single
---@return void
function DynamicFont:SetFormat(format, fontSizeScale) end
---@public
---@param text string
---@return void
function DynamicFont:PrepareCharacters(text) end
---@public
---@param ch Char
---@param width Single&
---@param height Single&
---@param baseline Single&
---@return bool
function DynamicFont:GetGlyph(ch, width, height, baseline) end
---@public
---@param x Single
---@param y Single
---@param vertList List`1
---@param uvList List`1
---@param uv2List List`1
---@param colList List`1
---@return Int32
function DynamicFont:DrawGlyph(x, y, vertList, uvList, uv2List, colList) end
---@public
---@param x Single
---@param y Single
---@param width Single
---@param fontSize Int32
---@param type Int32
---@param vertList List`1
---@param uvList List`1
---@param uv2List List`1
---@param colList List`1
---@return Int32
function DynamicFont:DrawLine(x, y, width, fontSize, type, vertList, uvList, uv2List, colList) end
---@public
---@param ch Char
---@return bool
function DynamicFont:HasCharacter(ch) end
---@public
---@param size Int32
---@return Int32
function DynamicFont:GetLineHeight(size) end
FairyGUI.DynamicFont = DynamicFont