---@class SkeletonAnimation : SkeletonRenderer
---@field public state AnimationState
---@field public loop bool
---@field public timeScale Single
---@field public AnimationState AnimationState
---@field public AnimationName string
local SkeletonAnimation={ }
---@public
---@param value UpdateBonesDelegate
---@return void
function SkeletonAnimation:add_UpdateLocal(value) end
---@public
---@param value UpdateBonesDelegate
---@return void
function SkeletonAnimation:remove_UpdateLocal(value) end
---@public
---@param value UpdateBonesDelegate
---@return void
function SkeletonAnimation:add_UpdateWorld(value) end
---@public
---@param value UpdateBonesDelegate
---@return void
function SkeletonAnimation:remove_UpdateWorld(value) end
---@public
---@param value UpdateBonesDelegate
---@return void
function SkeletonAnimation:add_UpdateComplete(value) end
---@public
---@param value UpdateBonesDelegate
---@return void
function SkeletonAnimation:remove_UpdateComplete(value) end
---@public
---@param gameObject GameObject
---@param skeletonDataAsset SkeletonDataAsset
---@return SkeletonAnimation
function SkeletonAnimation.AddToGameObject(gameObject, skeletonDataAsset) end
---@public
---@param skeletonDataAsset SkeletonDataAsset
---@return SkeletonAnimation
function SkeletonAnimation.NewSkeletonAnimationGameObject(skeletonDataAsset) end
---@public
---@return void
function SkeletonAnimation:ClearState() end
---@public
---@param overwrite bool
---@return void
function SkeletonAnimation:Initialize(overwrite) end
---@public
---@param deltaTime Single
---@return void
function SkeletonAnimation:Update(deltaTime) end
Spine.Unity.SkeletonAnimation = SkeletonAnimation