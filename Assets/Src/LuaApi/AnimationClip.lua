---@class AnimationClip : Motion
---@field public length Single
---@field public frameRate Single
---@field public wrapMode number
---@field public localBounds Bounds
---@field public legacy bool
---@field public humanMotion bool
---@field public empty bool
---@field public hasGenericRootTransform bool
---@field public hasMotionFloatCurves bool
---@field public hasMotionCurves bool
---@field public hasRootCurves bool
---@field public events AnimationEvent[]
local AnimationClip={ }
---@public
---@param go GameObject
---@param time Single
---@return void
function AnimationClip:SampleAnimation(go, time) end
---@public
---@param relativePath string
---@param type Type
---@param propertyName string
---@param curve AnimationCurve
---@return void
function AnimationClip:SetCurve(relativePath, type, propertyName, curve) end
---@public
---@return void
function AnimationClip:EnsureQuaternionContinuity() end
---@public
---@return void
function AnimationClip:ClearCurves() end
---@public
---@param evt AnimationEvent
---@return void
function AnimationClip:AddEvent(evt) end
UnityEngine.AnimationClip = AnimationClip