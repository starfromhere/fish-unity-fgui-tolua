---@class BaseFont : Object
---@field public name string
---@field public mainTexture NTexture
---@field public canTint bool
---@field public customBold bool
---@field public customBoldAndItalic bool
---@field public customOutline bool
---@field public shader string
---@field public keepCrisp bool
---@field public version Int32
local BaseFont={ }
---@public
---@param graphics NGraphics
---@return void
function BaseFont:UpdateGraphics(graphics) end
---@public
---@param format TextFormat
---@param fontSizeScale Single
---@return void
function BaseFont:SetFormat(format, fontSizeScale) end
---@public
---@param text string
---@return void
function BaseFont:PrepareCharacters(text) end
---@public
---@param ch Char
---@param width Single&
---@param height Single&
---@param baseline Single&
---@return bool
function BaseFont:GetGlyph(ch, width, height, baseline) end
---@public
---@param x Single
---@param y Single
---@param vertList List`1
---@param uvList List`1
---@param uv2List List`1
---@param colList List`1
---@return Int32
function BaseFont:DrawGlyph(x, y, vertList, uvList, uv2List, colList) end
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
function BaseFont:DrawLine(x, y, width, fontSize, type, vertList, uvList, uv2List, colList) end
---@public
---@param ch Char
---@return bool
function BaseFont:HasCharacter(ch) end
---@public
---@param size Int32
---@return Int32
function BaseFont:GetLineHeight(size) end
---@public
---@return void
function BaseFont:Dispose() end
FairyGUI.BaseFont = BaseFont