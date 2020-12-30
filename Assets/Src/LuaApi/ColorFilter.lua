---@class ColorFilter : Object
---@field public target DisplayObject
local ColorFilter={ }
---@public
---@return void
function ColorFilter:Dispose() end
---@public
---@return void
function ColorFilter:Update() end
---@public
---@return void
function ColorFilter:Invert() end
---@public
---@param sat Single
---@return void
function ColorFilter:AdjustSaturation(sat) end
---@public
---@param value Single
---@return void
function ColorFilter:AdjustContrast(value) end
---@public
---@param value Single
---@return void
function ColorFilter:AdjustBrightness(value) end
---@public
---@param value Single
---@return void
function ColorFilter:AdjustHue(value) end
---@public
---@param color Color
---@param amount Single
---@return void
function ColorFilter:Tint(color, amount) end
---@public
---@return void
function ColorFilter:Reset() end
---@public
---@param values Single[]
---@return void
function ColorFilter:ConcatValues(values) end
FairyGUI.ColorFilter = ColorFilter