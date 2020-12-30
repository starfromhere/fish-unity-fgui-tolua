---@class AssetRequest : Reference
---@field public assetType Type
---@field public url string
---@field public extensionName string
---@field public completed Action`1
---@field public loadState number
---@field public isDone bool
---@field public progress Single
---@field public error string
---@field public text string
---@field public bytes Byte[]
---@field public asset Object
---@field public Current Object
local AssetRequest={ }
---@public
---@return bool
function AssetRequest:MoveNext() end
---@public
---@return void
function AssetRequest:Reset() end
libx.AssetRequest = AssetRequest