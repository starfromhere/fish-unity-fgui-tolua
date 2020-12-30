---@class Enum : ValueType
local Enum={ }
---@public
---@param enumType Type
---@param value string
---@return Object
function Enum.Parse(enumType, value) end
---@public
---@param enumType Type
---@param value string
---@param ignoreCase bool
---@return Object
function Enum.Parse(enumType, value, ignoreCase) end
---@public
---@param enumType Type
---@return Type
function Enum.GetUnderlyingType(enumType) end
---@public
---@param enumType Type
---@return Array
function Enum.GetValues(enumType) end
---@public
---@param enumType Type
---@param value Object
---@return string
function Enum.GetName(enumType, value) end
---@public
---@param enumType Type
---@return String[]
function Enum.GetNames(enumType) end
---@public
---@param enumType Type
---@param value Object
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value Object
---@return bool
function Enum.IsDefined(enumType, value) end
---@public
---@param enumType Type
---@param value Object
---@param format string
---@return string
function Enum.Format(enumType, value, format) end
---@public
---@param obj Object
---@return bool
function Enum:Equals(obj) end
---@public
---@return Int32
function Enum:GetHashCode() end
---@public
---@return string
function Enum:ToString() end
---@public
---@param format string
---@param provider IFormatProvider
---@return string
function Enum:ToString(format, provider) end
---@public
---@param target Object
---@return Int32
function Enum:CompareTo(target) end
---@public
---@param format string
---@return string
function Enum:ToString(format) end
---@public
---@param provider IFormatProvider
---@return string
function Enum:ToString(provider) end
---@public
---@param flag Enum
---@return bool
function Enum:HasFlag(flag) end
---@public
---@return number
function Enum:GetTypeCode() end
---@public
---@param enumType Type
---@param value SByte
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value Int16
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value Int32
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value Byte
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value UInt16
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value UInt32
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value Int64
---@return Object
function Enum.ToObject(enumType, value) end
---@public
---@param enumType Type
---@param value UInt64
---@return Object
function Enum.ToObject(enumType, value) end
System.Enum = Enum