---@class GLoader : GObject
---@field public showErrorSign bool
---@field public url string
---@field public icon string
---@field public align number
---@field public verticalAlign number
---@field public fill number
---@field public shrinkOnly bool
---@field public autoSize bool
---@field public playing bool
---@field public frame Int32
---@field public timeScale Single
---@field public ignoreEngineTimeScale bool
---@field public material Material
---@field public shader string
---@field public color Color
---@field public fillMethod number
---@field public fillOrigin Int32
---@field public fillClockwise bool
---@field public fillAmount Single
---@field public image Image
---@field public movieClip MovieClip
---@field public component GComponent
---@field public texture NTexture
---@field public filter IFilter
---@field public blendMode number
local GLoader={ }
---@public
---@return void
function GLoader:Dispose() end
---@public
---@param time Single
---@return void
function GLoader:Advance(time) end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GLoader:Setup_BeforeAdd(buffer, beginPos) end
FairyGUI.GLoader = GLoader