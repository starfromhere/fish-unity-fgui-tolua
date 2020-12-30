---@class TextWriter : MarshalByRefObject
---@field public Null TextWriter
---@field public FormatProvider IFormatProvider
---@field public Encoding Encoding
---@field public NewLine string
local TextWriter={ }
---@public
---@return void
function TextWriter:Close() end
---@public
---@return void
function TextWriter:Dispose() end
---@public
---@return void
function TextWriter:Flush() end
---@public
---@param writer TextWriter
---@return TextWriter
function TextWriter.Synchronized(writer) end
---@public
---@param value Char
---@return void
function TextWriter:Write(value) end
---@public
---@param buffer Char[]
---@return void
function TextWriter:Write(buffer) end
---@public
---@param buffer Char[]
---@param index Int32
---@param count Int32
---@return void
function TextWriter:Write(buffer, index, count) end
---@public
---@param value bool
---@return void
function TextWriter:Write(value) end
---@public
---@param value Int32
---@return void
function TextWriter:Write(value) end
---@public
---@param value UInt32
---@return void
function TextWriter:Write(value) end
---@public
---@param value Int64
---@return void
function TextWriter:Write(value) end
---@public
---@param value UInt64
---@return void
function TextWriter:Write(value) end
---@public
---@param value Single
---@return void
function TextWriter:Write(value) end
---@public
---@param value number
---@return void
function TextWriter:Write(value) end
---@public
---@param value Decimal
---@return void
function TextWriter:Write(value) end
---@public
---@param value string
---@return void
function TextWriter:Write(value) end
---@public
---@param value Object
---@return void
function TextWriter:Write(value) end
---@public
---@param format string
---@param arg0 Object
---@return void
function TextWriter:Write(format, arg0) end
---@public
---@param format string
---@param arg0 Object
---@param arg1 Object
---@return void
function TextWriter:Write(format, arg0, arg1) end
---@public
---@param format string
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return void
function TextWriter:Write(format, arg0, arg1, arg2) end
---@public
---@param format string
---@param arg Object[]
---@return void
function TextWriter:Write(format, arg) end
---@public
---@return void
function TextWriter:WriteLine() end
---@public
---@param value Char
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param buffer Char[]
---@return void
function TextWriter:WriteLine(buffer) end
---@public
---@param buffer Char[]
---@param index Int32
---@param count Int32
---@return void
function TextWriter:WriteLine(buffer, index, count) end
---@public
---@param value bool
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value Int32
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value UInt32
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value Int64
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value UInt64
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value Single
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value number
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value Decimal
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value string
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param value Object
---@return void
function TextWriter:WriteLine(value) end
---@public
---@param format string
---@param arg0 Object
---@return void
function TextWriter:WriteLine(format, arg0) end
---@public
---@param format string
---@param arg0 Object
---@param arg1 Object
---@return void
function TextWriter:WriteLine(format, arg0, arg1) end
---@public
---@param format string
---@param arg0 Object
---@param arg1 Object
---@param arg2 Object
---@return void
function TextWriter:WriteLine(format, arg0, arg1, arg2) end
---@public
---@param format string
---@param arg Object[]
---@return void
function TextWriter:WriteLine(format, arg) end
---@public
---@param value Char
---@return Task
function TextWriter:WriteAsync(value) end
---@public
---@param value string
---@return Task
function TextWriter:WriteAsync(value) end
---@public
---@param buffer Char[]
---@return Task
function TextWriter:WriteAsync(buffer) end
---@public
---@param buffer Char[]
---@param index Int32
---@param count Int32
---@return Task
function TextWriter:WriteAsync(buffer, index, count) end
---@public
---@param value Char
---@return Task
function TextWriter:WriteLineAsync(value) end
---@public
---@param value string
---@return Task
function TextWriter:WriteLineAsync(value) end
---@public
---@param buffer Char[]
---@return Task
function TextWriter:WriteLineAsync(buffer) end
---@public
---@param buffer Char[]
---@param index Int32
---@param count Int32
---@return Task
function TextWriter:WriteLineAsync(buffer, index, count) end
---@public
---@return Task
function TextWriter:WriteLineAsync() end
---@public
---@return Task
function TextWriter:FlushAsync() end
System.IO.TextWriter = TextWriter