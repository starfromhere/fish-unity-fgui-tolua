---@class LuaProperty : Object
local LuaProperty={ }
---@public
---@param L IntPtr
---@return Int32
function LuaProperty:Get(L) end
---@public
---@param L IntPtr
---@return Int32
function LuaProperty:Set(L) end
LuaInterface.LuaProperty = LuaProperty