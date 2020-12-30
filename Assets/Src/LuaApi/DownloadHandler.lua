---@class DownloadHandler : Object
---@field public isDone bool
---@field public data Byte[]
---@field public text string
local DownloadHandler={ }
---@public
---@return void
function DownloadHandler:Dispose() end
UnityEngine.Networking.DownloadHandler = DownloadHandler