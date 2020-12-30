---@class FontManager : Object
---@field public sFontFactory Dictionary`2
local FontManager={ }
---@public
---@param font BaseFont
---@param alias string
---@return void
function FontManager.RegisterFont(font, alias) end
---@public
---@param font BaseFont
---@return void
function FontManager.UnregisterFont(font) end
---@public
---@param name string
---@return BaseFont
function FontManager.GetFont(name) end
---@public
---@return void
function FontManager.Clear() end
FairyGUI.FontManager = FontManager