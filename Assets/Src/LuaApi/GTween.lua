---@class GTween : Object
---@field public catchCallbackExceptions bool
local GTween={ }
---@public
---@param startValue Single
---@param endValue Single
---@param duration Single
---@return GTweener
function GTween.To(startValue, endValue, duration) end
---@public
---@param startValue Vector2
---@param endValue Vector2
---@param duration Single
---@return GTweener
function GTween.To(startValue, endValue, duration) end
---@public
---@param startValue Vector3
---@param endValue Vector3
---@param duration Single
---@return GTweener
function GTween.To(startValue, endValue, duration) end
---@public
---@param startValue Vector4
---@param endValue Vector4
---@param duration Single
---@return GTweener
function GTween.To(startValue, endValue, duration) end
---@public
---@param startValue Color
---@param endValue Color
---@param duration Single
---@return GTweener
function GTween.To(startValue, endValue, duration) end
---@public
---@param startValue number
---@param endValue number
---@param duration Single
---@return GTweener
function GTween.ToDouble(startValue, endValue, duration) end
---@public
---@param delay Single
---@return GTweener
function GTween.DelayedCall(delay) end
---@public
---@param startValue Vector3
---@param amplitude Single
---@param duration Single
---@return GTweener
function GTween.Shake(startValue, amplitude, duration) end
---@public
---@param target Object
---@return bool
function GTween.IsTweening(target) end
---@public
---@param target Object
---@param propType number
---@return bool
function GTween.IsTweening(target, propType) end
---@public
---@param target Object
---@return void
function GTween.Kill(target) end
---@public
---@param target Object
---@param complete bool
---@return void
function GTween.Kill(target, complete) end
---@public
---@param target Object
---@param propType number
---@param complete bool
---@return void
function GTween.Kill(target, propType, complete) end
---@public
---@param target Object
---@return GTweener
function GTween.GetTween(target) end
---@public
---@param target Object
---@param propType number
---@return GTweener
function GTween.GetTween(target, propType) end
---@public
---@return void
function GTween.Clean() end
FairyGUI.GTween = GTween