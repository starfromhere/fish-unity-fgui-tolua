---@class LuaConstructor : Object
local LuaConstructor={ }
---@public
---@param L IntPtr
---@return Int32
function LuaConstructor:Call(L) end
---@public
---@return void
function LuaConstructor:Destroy() end
LuaInterface.LuaConstructor = LuaConstructor