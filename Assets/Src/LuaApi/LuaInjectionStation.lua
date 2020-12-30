---@class LuaInjectionStation : Object
---@field public NOT_INJECTION_FLAG Byte
---@field public INVALID_INJECTION_FLAG Byte
local LuaInjectionStation={ }
---@public
---@param index Int32
---@param injectFlag Byte
---@param func LuaFunction
---@return void
function LuaInjectionStation.CacheInjectFunction(index, injectFlag, func) end
---@public
---@return void
function LuaInjectionStation.Clear() end
LuaInterface.LuaInjectionStation = LuaInjectionStation