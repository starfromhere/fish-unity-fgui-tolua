---@class GMovieClip : GObject
---@field public onPlayEnd EventListener
---@field public playing bool
---@field public frame Int32
---@field public color Color
---@field public flip number
---@field public material Material
---@field public shader string
---@field public timeScale Single
---@field public ignoreEngineTimeScale bool
local GMovieClip={ }
---@public
---@return void
function GMovieClip:Rewind() end
---@public
---@param anotherMc GMovieClip
---@return void
function GMovieClip:SyncStatus(anotherMc) end
---@public
---@param time Single
---@return void
function GMovieClip:Advance(time) end
---@public
---@param start Int32
---@param end Int32
---@param times Int32
---@param endAt Int32
---@return void
function GMovieClip:SetPlaySettings(start, end, times, endAt) end
---@public
---@return void
function GMovieClip:ConstructFromResource() end
---@public
---@param buffer ByteBuffer
---@param beginPos Int32
---@return void
function GMovieClip:Setup_BeforeAdd(buffer, beginPos) end
FairyGUI.GMovieClip = GMovieClip