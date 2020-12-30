---@class AsyncOperation : YieldInstruction
---@field public isDone bool
---@field public progress Single
---@field public priority Int32
---@field public allowSceneActivation bool
local AsyncOperation={ }
---@public
---@param value Action`1
---@return void
function AsyncOperation:add_completed(value) end
---@public
---@param value Action`1
---@return void
function AsyncOperation:remove_completed(value) end
UnityEngine.AsyncOperation = AsyncOperation