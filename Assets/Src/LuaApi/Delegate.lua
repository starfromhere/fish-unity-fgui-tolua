---@class Delegate : Object
---@field public Method MethodInfo
---@field public Target Object
local Delegate={ }
---@public
---@param type Type
---@param firstArgument Object
---@param method MethodInfo
---@param throwOnBindFailure bool
---@return Delegate
function Delegate.CreateDelegate(type, firstArgument, method, throwOnBindFailure) end
---@public
---@param type Type
---@param firstArgument Object
---@param method MethodInfo
---@return Delegate
function Delegate.CreateDelegate(type, firstArgument, method) end
---@public
---@param type Type
---@param method MethodInfo
---@param throwOnBindFailure bool
---@return Delegate
function Delegate.CreateDelegate(type, method, throwOnBindFailure) end
---@public
---@param type Type
---@param method MethodInfo
---@return Delegate
function Delegate.CreateDelegate(type, method) end
---@public
---@param type Type
---@param target Object
---@param method string
---@return Delegate
function Delegate.CreateDelegate(type, target, method) end
---@public
---@param type Type
---@param target Type
---@param method string
---@param ignoreCase bool
---@param throwOnBindFailure bool
---@return Delegate
function Delegate.CreateDelegate(type, target, method, ignoreCase, throwOnBindFailure) end
---@public
---@param type Type
---@param target Type
---@param method string
---@return Delegate
function Delegate.CreateDelegate(type, target, method) end
---@public
---@param type Type
---@param target Type
---@param method string
---@param ignoreCase bool
---@return Delegate
function Delegate.CreateDelegate(type, target, method, ignoreCase) end
---@public
---@param type Type
---@param target Object
---@param method string
---@param ignoreCase bool
---@param throwOnBindFailure bool
---@return Delegate
function Delegate.CreateDelegate(type, target, method, ignoreCase, throwOnBindFailure) end
---@public
---@param type Type
---@param target Object
---@param method string
---@param ignoreCase bool
---@return Delegate
function Delegate.CreateDelegate(type, target, method, ignoreCase) end
---@public
---@param args Object[]
---@return Object
function Delegate:DynamicInvoke(args) end
---@public
---@return Object
function Delegate:Clone() end
---@public
---@param obj Object
---@return bool
function Delegate:Equals(obj) end
---@public
---@return Int32
function Delegate:GetHashCode() end
---@public
---@param info SerializationInfo
---@param context StreamingContext
---@return void
function Delegate:GetObjectData(info, context) end
---@public
---@return Delegate[]
function Delegate:GetInvocationList() end
---@public
---@param a Delegate
---@param b Delegate
---@return Delegate
function Delegate.Combine(a, b) end
---@public
---@param delegates Delegate[]
---@return Delegate
function Delegate.Combine(delegates) end
---@public
---@param source Delegate
---@param value Delegate
---@return Delegate
function Delegate.Remove(source, value) end
---@public
---@param source Delegate
---@param value Delegate
---@return Delegate
function Delegate.RemoveAll(source, value) end
---@public
---@param d1 Delegate
---@param d2 Delegate
---@return bool
function Delegate.op_Equality(d1, d2) end
---@public
---@param d1 Delegate
---@param d2 Delegate
---@return bool
function Delegate.op_Inequality(d1, d2) end
System.Delegate = Delegate