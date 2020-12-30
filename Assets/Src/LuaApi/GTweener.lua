---@class GTweener : Object
---@field public delay Single
---@field public duration Single
---@field public repeat Int32
---@field public target Object
---@field public userData Object
---@field public startValue TweenValue
---@field public endValue TweenValue
---@field public value TweenValue
---@field public deltaValue TweenValue
---@field public normalizedTime Single
---@field public completed bool
---@field public allCompleted bool
local GTweener={ }
---@public
---@param value Single
---@return GTweener
function GTweener:SetDelay(value) end
---@public
---@param value Single
---@return GTweener
function GTweener:SetDuration(value) end
---@public
---@param value Single
---@return GTweener
function GTweener:SetBreakpoint(value) end
---@public
---@param value number
---@return GTweener
function GTweener:SetEase(value) end
---@public
---@param value Single
---@return GTweener
function GTweener:SetEasePeriod(value) end
---@public
---@param value Single
---@return GTweener
function GTweener:SetEaseOvershootOrAmplitude(value) end
---@public
---@param times Int32
---@param yoyo bool
---@return GTweener
function GTweener:SetRepeat(times, yoyo) end
---@public
---@param value Single
---@return GTweener
function GTweener:SetTimeScale(value) end
---@public
---@param value bool
---@return GTweener
function GTweener:SetIgnoreEngineTimeScale(value) end
---@public
---@param value bool
---@return GTweener
function GTweener:SetSnapping(value) end
---@public
---@param value GPath
---@return GTweener
function GTweener:SetPath(value) end
---@public
---@param value Object
---@return GTweener
function GTweener:SetTarget(value) end
---@public
---@param value Object
---@param propType number
---@return GTweener
function GTweener:SetTarget(value, propType) end
---@public
---@param value Object
---@return GTweener
function GTweener:SetUserData(value) end
---@public
---@param callback GTweenCallback1
---@return GTweener
function GTweener:OnUpdate(callback) end
---@public
---@param callback GTweenCallback1
---@return GTweener
function GTweener:OnStart(callback) end
---@public
---@param callback GTweenCallback1
---@return GTweener
function GTweener:OnComplete(callback) end
---@public
---@param value ITweenListener
---@return GTweener
function GTweener:SetListener(value) end
---@public
---@param paused bool
---@return GTweener
function GTweener:SetPaused(paused) end
---@public
---@param time Single
---@return void
function GTweener:Seek(time) end
---@public
---@param complete bool
---@return void
function GTweener:Kill(complete) end
FairyGUI.GTweener = GTweener