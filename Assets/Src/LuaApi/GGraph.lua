---@class GGraph : GObject
---@field public color Color
---@field public shape Shape
local GGraph={ }
---@public
---@param target GObject
---@return void
function GGraph:ReplaceMe(target) end
---@public
---@param target GObject
---@return void
function GGraph:AddBeforeMe(target) end
---@public
---@param target GObject
---@return void
function GGraph:AddAfterMe(target) end
---@public
---@param obj DisplayObject
---@return void
function GGraph:SetNativeObject(obj) end
---@public
---@param aWidth Single
---@param aHeight Single
---@param lineSize Int32
---@param lineColor Color
---@param fillColor Color
---@return void
function GGraph:DrawRect(aWidth, aHeight, lineSize, lineColor, fillColor) end
---@public
---@param aWidth Single
---@param aHeight Single
---@param fillColor Color
---@param corner Single[]
---@return void
function GGraph:DrawRoundRect(aWidth, aHeight, fillColor, corner) end
---@public
---@param aWidth Single
---@param aHeight Single
---@param fillColor Color
---@return void
function GGraph:DrawEllipse(aWidth, aHeight, fillColor) end
---@public
---@param aWidth Single
---@param aHeight Single
---@param points IList`1
---@param fillColor Color
---@return void
function GGraph:DrawPolygon(aWidth, aHeight, points, fillColor) end
---@public
---@param aWidth Single
---@param aHeight Single
---@param points IList`1
---@param fillColor Color
---@param lineSize Single
---@param lineColor Color
---@return void
function GGraph:DrawPolygon(aWidth, aHeight, points, fillColor, lineSize, lineColor) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GGraph:Setup_BeforeAdd(buffer, beginPos) end
FairyGUI.GGraph = GGraph