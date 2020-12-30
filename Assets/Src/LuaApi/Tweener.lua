---@class Tweener : Tween
local Tweener={ }
---@public
---@param newStartValue Object
---@param newDuration Single
---@return Tweener
function Tweener:ChangeStartValue(newStartValue, newDuration) end
---@public
---@param newEndValue Object
---@param newDuration Single
---@param snapStartValue bool
---@return Tweener
function Tweener:ChangeEndValue(newEndValue, newDuration, snapStartValue) end
---@public
---@param newEndValue Object
---@param snapStartValue bool
---@return Tweener
function Tweener:ChangeEndValue(newEndValue, snapStartValue) end
---@public
---@param newStartValue Object
---@param newEndValue Object
---@param newDuration Single
---@return Tweener
function Tweener:ChangeValues(newStartValue, newEndValue, newDuration) end
DG.Tweening.Tweener = Tweener