---@class EaseFactory : Object
local EaseFactory={ }
---@public
---@param motionFps Int32
---@param ease Nullable`1
---@return EaseFunction
function EaseFactory.StopMotion(motionFps, ease) end
---@public
---@param motionFps Int32
---@param animCurve AnimationCurve
---@return EaseFunction
function EaseFactory.StopMotion(motionFps, animCurve) end
---@public
---@param motionFps Int32
---@param customEase EaseFunction
---@return EaseFunction
function EaseFactory.StopMotion(motionFps, customEase) end
DG.Tweening.EaseFactory = EaseFactory