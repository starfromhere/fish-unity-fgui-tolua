---@class BundleRequest : AssetRequest
---@field public children List`1
---@field public parent string
---@field public assetBundle AssetBundle
local BundleRequest={ }
---@public
---@return void
function BundleRequest:Release() end
libx.BundleRequest = BundleRequest