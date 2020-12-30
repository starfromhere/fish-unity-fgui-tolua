---@class LuaProfiler : Object
---@field public list List`1
local LuaProfiler={ }
---@public
---@return void
function LuaProfiler.Clear() end
---@public
---@param name string
---@return Int32
function LuaProfiler.GetID(name) end
---@public
---@param id Int32
---@return void
function LuaProfiler.BeginSample(id) end
---@public
---@return void
function LuaProfiler.EndSample() end
.LuaProfiler = LuaProfiler