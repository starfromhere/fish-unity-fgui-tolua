---@class TweenerCore`3 : Tweener
---@field public startValue Vector3
---@field public endValue Vector3
---@field public changeValue Vector3
---@field public plugOptions VectorOptions
---@field public getter DOGetter`1
---@field public setter DOSetter`1
local TweenerCore`3={ }
---@public
---@param newStartValue Object
---@param newDuration Single
---@return Tweener
function TweenerCore`3:ChangeStartValue(newStartValue, newDuration) end
---@public
---@param newEndValue Object
---@param snapStartValue bool
---@return Tweener
function TweenerCore`3:ChangeEndValue(newEndValue, snapStartValue) end
---@public
---@param newEndValue Object
---@param newDuration Single
---@param snapStartValue bool
---@return Tweener
function TweenerCore`3:ChangeEndValue(newEndValue, newDuration, snapStartValue) end
---@public
---@param newStartValue Object
---@param newEndValue Object
---@param newDuration Single
---@return Tweener
function TweenerCore`3:ChangeValues(newStartValue, newEndValue, newDuration) end
---@public
---@param newStartValue Vector3
---@param newDuration Single
---@return TweenerCore`3
function TweenerCore`3:ChangeStartValue(newStartValue, newDuration) end
---@public
---@param newEndValue Vector3
---@param snapStartValue bool
---@return TweenerCore`3
function TweenerCore`3:ChangeEndValue(newEndValue, snapStartValue) end
---@public
---@param newEndValue Vector3
---@param newDuration Single
---@param snapStartValue bool
---@return TweenerCore`3
function TweenerCore`3:ChangeEndValue(newEndValue, newDuration, snapStartValue) end
---@public
---@param newStartValue Vector3
---@param newEndValue Vector3
---@param newDuration Single
---@return TweenerCore`3
function TweenerCore`3:ChangeValues(newStartValue, newEndValue, newDuration) end
DG.Tweening.Core.TweenerCore`3 = TweenerCore`3
TweenerCoreV3V3VO = TweenerCore`3