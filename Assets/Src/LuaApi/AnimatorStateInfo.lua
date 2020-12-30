---@class AnimatorStateInfo : ValueType
---@field public fullPathHash Int32
---@field public nameHash Int32
---@field public shortNameHash Int32
---@field public normalizedTime Single
---@field public length Single
---@field public speed Single
---@field public speedMultiplier Single
---@field public tagHash Int32
---@field public loop bool
local AnimatorStateInfo={ }
---@public
---@param name string
---@return bool
function AnimatorStateInfo:IsName(name) end
---@public
---@param tag string
---@return bool
function AnimatorStateInfo:IsTag(tag) end
UnityEngine.AnimatorStateInfo = AnimatorStateInfo