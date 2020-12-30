---@class Reference : Object
---@field public name string
---@field public refCount Int32
local Reference={ }
---@public
---@return bool
function Reference:IsUnused() end
---@public
---@return void
function Reference:Retain() end
---@public
---@return void
function Reference:Release() end
---@public
---@param obj Object
---@return void
function Reference:Require(obj) end
---@public
---@param obj Object
---@return void
function Reference:Dequire(obj) end
libx.Reference = Reference