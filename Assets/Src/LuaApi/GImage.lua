---@class GImage : GObject
---@field public color Color
---@field public flip number
---@field public fillMethod number
---@field public fillOrigin Int32
---@field public fillClockwise bool
---@field public fillAmount Single
---@field public texture NTexture
---@field public material Material
---@field public shader string
local GImage={ }
---@public
---@return void
function GImage:ConstructFromResource() end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GImage:Setup_BeforeAdd(buffer, beginPos) end
FairyGUI.GImage = GImage