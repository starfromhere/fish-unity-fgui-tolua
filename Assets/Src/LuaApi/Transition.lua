---@class Transition : Object
---@field public invalidateBatchingEveryFrame bool
---@field public name string
---@field public playing bool
---@field public timeScale Single
---@field public ignoreEngineTimeScale bool
local Transition={ }
---@public
---@return void
function Transition:Play() end
---@public
---@param onComplete PlayCompleteCallback
---@return void
function Transition:Play(onComplete) end
---@public
---@param times Int32
---@param delay Single
---@param onComplete PlayCompleteCallback
---@return void
function Transition:Play(times, delay, onComplete) end
---@public
---@param times Int32
---@param delay Single
---@param startTime Single
---@param endTime Single
---@param onComplete PlayCompleteCallback
---@return void
function Transition:Play(times, delay, startTime, endTime, onComplete) end
---@public
---@return void
function Transition:PlayReverse() end
---@public
---@param onComplete PlayCompleteCallback
---@return void
function Transition:PlayReverse(onComplete) end
---@public
---@param times Int32
---@param delay Single
---@param onComplete PlayCompleteCallback
---@return void
function Transition:PlayReverse(times, delay, onComplete) end
---@public
---@param value Int32
---@return void
function Transition:ChangePlayTimes(value) end
---@public
---@param autoPlay bool
---@param times Int32
---@param delay Single
---@return void
function Transition:SetAutoPlay(autoPlay, times, delay) end
---@public
---@return void
function Transition:Stop() end
---@public
---@param setToComplete bool
---@param processCallback bool
---@return void
function Transition:Stop(setToComplete, processCallback) end
---@public
---@param paused bool
---@return void
function Transition:SetPaused(paused) end
---@public
---@return void
function Transition:Dispose() end
---@public
---@param label string
---@param aParams Object[]
---@return void
function Transition:SetValue(label, aParams) end
---@public
---@param label string
---@param callback TransitionHook
---@return void
function Transition:SetHook(label, callback) end
---@public
---@return void
function Transition:ClearHooks() end
---@public
---@param label string
---@param newTarget GObject
---@return void
function Transition:SetTarget(label, newTarget) end
---@public
---@param label string
---@param value Single
---@return void
function Transition:SetDuration(label, value) end
---@public
---@param label string
---@return Single
function Transition:GetLabelTime(label) end
---@public
---@param tweener GTweener
---@return void
function Transition:OnTweenStart(tweener) end
---@public
---@param tweener GTweener
---@return void
function Transition:OnTweenUpdate(tweener) end
---@public
---@param tweener GTweener
---@return void
function Transition:OnTweenComplete(tweener) end
---@public
---@param buffer ByteBuffer
---@return void
function Transition:Setup(buffer) end
FairyGUI.Transition = Transition