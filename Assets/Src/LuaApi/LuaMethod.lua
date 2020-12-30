---@class LuaMethod : Object
local LuaMethod={ }
---@public
---@param L IntPtr
---@return Int32
function LuaMethod:Call(L) end
---@public
---@return void
function LuaMethod:Destroy() end
LuaInterface.LuaMethod = LuaMethod