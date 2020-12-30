---@class TweenParams : Object
---@field public Params TweenParams
local TweenParams={ }
---@public
---@return TweenParams
function TweenParams:Clear() end
---@public
---@param autoKillOnCompletion bool
---@return TweenParams
function TweenParams:SetAutoKill(autoKillOnCompletion) end
---@public
---@param id Object
---@return TweenParams
function TweenParams:SetId(id) end
---@public
---@param target Object
---@return TweenParams
function TweenParams:SetTarget(target) end
---@public
---@param loops Int32
---@param loopType Nullable`1
---@return TweenParams
function TweenParams:SetLoops(loops, loopType) end
---@public
---@param ease number
---@param overshootOrAmplitude Nullable`1
---@param period Nullable`1
---@return TweenParams
function TweenParams:SetEase(ease, overshootOrAmplitude, period) end
---@public
---@param animCurve AnimationCurve
---@return TweenParams
function TweenParams:SetEase(animCurve) end
---@public
---@param customEase EaseFunction
---@return TweenParams
function TweenParams:SetEase(customEase) end
---@public
---@param recyclable bool
---@return TweenParams
function TweenParams:SetRecyclable(recyclable) end
---@public
---@param isIndependentUpdate bool
---@return TweenParams
function TweenParams:SetUpdate(isIndependentUpdate) end
---@public
---@param updateType number
---@param isIndependentUpdate bool
---@return TweenParams
function TweenParams:SetUpdate(updateType, isIndependentUpdate) end
---@public
---@param action TweenCallback
---@return TweenParams
function TweenParams:OnStart(action) end
---@public
---@param action TweenCallback
---@return TweenParams
function TweenParams:OnPlay(action) end
---@public
---@param action TweenCallback
---@return TweenParams
function TweenParams:OnRewind(action) end
---@public
---@param action TweenCallback
---@return TweenParams
function TweenParams:OnUpdate(action) end
---@public
---@param action TweenCallback
---@return TweenParams
function TweenParams:OnStepComplete(action) end
---@public
---@param action TweenCallback
---@return TweenParams
function TweenParams:OnComplete(action) end
---@public
---@param action TweenCallback
---@return TweenParams
function TweenParams:OnKill(action) end
---@public
---@param action TweenCallback`1
---@return TweenParams
function TweenParams:OnWaypointChange(action) end
---@public
---@param delay Single
---@return TweenParams
function TweenParams:SetDelay(delay) end
---@public
---@param isRelative bool
---@return TweenParams
function TweenParams:SetRelative(isRelative) end
---@public
---@param isSpeedBased bool
---@return TweenParams
function TweenParams:SetSpeedBased(isSpeedBased) end
DG.Tweening.TweenParams = TweenParams