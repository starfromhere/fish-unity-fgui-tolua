---@class GGroup : GObject
---@field public layout number
---@field public lineGap Int32
---@field public columnGap Int32
---@field public excludeInvisibles bool
---@field public autoSizeDisabled bool
---@field public mainGridMinSize Int32
---@field public mainGridIndex Int32
local GGroup={ }
---@public
---@param positionChangedOnly bool
---@return void
function GGroup:SetBoundsChangedFlag(positionChangedOnly) end
---@public
---@return void
function GGroup:EnsureBoundsCorrect() end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GGroup:Setup_BeforeAdd(buffer, beginPos) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GGroup:Setup_AfterAdd(buffer, beginPos) end
FairyGUI.GGroup = GGroup