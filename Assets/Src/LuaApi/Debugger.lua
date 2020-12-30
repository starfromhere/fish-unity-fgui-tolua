---@class Debugger : Object
---@field public useLog bool
---@field public threadStack string
---@field public logger ILogger
local Debugger={ }
---@public
---@param str string
---@return void
function Debugger.Log(str) end
---@public
---@param message Object
---@return void
function Debugger.Log(message) end
---@public
---@param str string
---@param arg0 Object
---@return void
function Debugger.Log(str, arg0) end
---@public
---@param str string
---@param arg0 Object
---@param arg1 Object
---@return void
function Debugger.Log(str, arg0, arg1) end
---@public
---@param str string
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return void
function Debugger.Log(str, arg0, arg1, arg2) end
---@public
---@param str string
---@param param Object[]
---@return void
function Debugger.Log(str, param) end
---@public
---@param str string
---@return void
function Debugger.LogWarning(str) end
---@public
---@param message Object
---@return void
function Debugger.LogWarning(message) end
---@public
---@param str string
---@param arg0 Object
---@return void
function Debugger.LogWarning(str, arg0) end
---@public
---@param str string
---@param arg0 Object
---@param arg1 Object
---@return void
function Debugger.LogWarning(str, arg0, arg1) end
---@public
---@param str string
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return void
function Debugger.LogWarning(str, arg0, arg1, arg2) end
---@public
---@param str string
---@param param Object[]
---@return void
function Debugger.LogWarning(str, param) end
---@public
---@param str string
---@return void
function Debugger.LogError(str) end
---@public
---@param message Object
---@return void
function Debugger.LogError(message) end
---@public
---@param str string
---@param arg0 Object
---@return void
function Debugger.LogError(str, arg0) end
---@public
---@param str string
---@param arg0 Object
---@param arg1 Object
---@return void
function Debugger.LogError(str, arg0, arg1) end
---@public
---@param str string
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return void
function Debugger.LogError(str, arg0, arg1, arg2) end
---@public
---@param str string
---@param param Object[]
---@return void
function Debugger.LogError(str, param) end
---@public
---@param e Exception
---@return void
function Debugger.LogException(e) end
---@public
---@param str string
---@param e Exception
---@return void
function Debugger.LogException(str, e) end
LuaInterface.Debugger = Debugger