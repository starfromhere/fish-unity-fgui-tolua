---@class LuaField : Object
local LuaField={ }
---@public
---@param L IntPtr
---@return Int32
function LuaField:Get(L) end
---@public
---@param L IntPtr
---@return Int32
function LuaField:Set(L) end
LuaInterface.LuaField = LuaField