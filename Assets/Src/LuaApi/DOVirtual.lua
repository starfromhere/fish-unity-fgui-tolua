---@class DOVirtual : Object
local DOVirtual={ }
---@public
---@param from Single
---@param to Single
---@param duration Single
---@param onVirtualUpdate TweenCallback`1
---@return Tweener
function DOVirtual.Float(from, to, duration, onVirtualUpdate) end
---@public
---@param from Single
---@param to Single
---@param lifetimePercentage Single
---@param easeType number
---@return Single
function DOVirtual.EasedValue(from, to, lifetimePercentage, easeType) end
---@public
---@param from Single
---@param to Single
---@param lifetimePercentage Single
---@param easeType number
---@param overshoot Single
---@return Single
function DOVirtual.EasedValue(from, to, lifetimePercentage, easeType, overshoot) end
---@public
---@param from Single
---@param to Single
---@param lifetimePercentage Single
---@param easeType number
---@param amplitude Single
---@param period Single
---@return Single
function DOVirtual.EasedValue(from, to, lifetimePercentage, easeType, amplitude, period) end
---@public
---@param from Single
---@param to Single
---@param lifetimePercentage Single
---@param easeCurve AnimationCurve
---@return Single
function DOVirtual.EasedValue(from, to, lifetimePercentage, easeCurve) end
---@public
---@param delay Single
---@param callback TweenCallback
---@param ignoreTimeScale bool
---@return Tween
function DOVirtual.DelayedCall(delay, callback, ignoreTimeScale) end
DG.Tweening.DOVirtual = DOVirtual