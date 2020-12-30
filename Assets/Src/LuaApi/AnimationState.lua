---@class AnimationState : Object
---@field public Data AnimationStateData
---@field public Tracks ExposedList`1
---@field public TimeScale Single
local AnimationState={ }
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:add_Start(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:remove_Start(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:add_Interrupt(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:remove_Interrupt(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:add_End(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:remove_End(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:add_Dispose(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:remove_Dispose(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:add_Complete(value) end
---@public
---@param value TrackEntryDelegate
---@return void
function AnimationState:remove_Complete(value) end
---@public
---@param value TrackEntryEventDelegate
---@return void
function AnimationState:add_Event(value) end
---@public
---@param value TrackEntryEventDelegate
---@return void
function AnimationState:remove_Event(value) end
---@public
---@param delta Single
---@return void
function AnimationState:Update(delta) end
---@public
---@param skeleton Skeleton
---@return bool
function AnimationState:Apply(skeleton) end
---@public
---@return void
function AnimationState:ClearTracks() end
---@public
---@param trackIndex Int32
---@return void
function AnimationState:ClearTrack(trackIndex) end
---@public
---@param trackIndex Int32
---@param animationName string
---@param loop bool
---@return TrackEntry
function AnimationState:SetAnimation(trackIndex, animationName, loop) end
---@public
---@param trackIndex Int32
---@param animation Animation
---@param loop bool
---@return TrackEntry
function AnimationState:SetAnimation(trackIndex, animation, loop) end
---@public
---@param trackIndex Int32
---@param animationName string
---@param loop bool
---@param delay Single
---@return TrackEntry
function AnimationState:AddAnimation(trackIndex, animationName, loop, delay) end
---@public
---@param trackIndex Int32
---@param animation Animation
---@param loop bool
---@param delay Single
---@return TrackEntry
function AnimationState:AddAnimation(trackIndex, animation, loop, delay) end
---@public
---@param trackIndex Int32
---@param mixDuration Single
---@return TrackEntry
function AnimationState:SetEmptyAnimation(trackIndex, mixDuration) end
---@public
---@param trackIndex Int32
---@param mixDuration Single
---@param delay Single
---@return TrackEntry
function AnimationState:AddEmptyAnimation(trackIndex, mixDuration, delay) end
---@public
---@param mixDuration Single
---@return void
function AnimationState:SetEmptyAnimations(mixDuration) end
---@public
---@param trackIndex Int32
---@return TrackEntry
function AnimationState:GetCurrent(trackIndex) end
---@public
---@return string
function AnimationState:ToString() end
Spine.AnimationState = AnimationState