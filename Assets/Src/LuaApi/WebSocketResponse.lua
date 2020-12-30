---@class WebSocketResponse : HTTPResponse
---@field public RTTBufferCapacity Int32
---@field public OnText Action`2
---@field public OnBinary Action`2
---@field public OnIncompleteFrame Action`2
---@field public OnClosed Action`3
---@field public lastMessage DateTime
---@field public WebSocket WebSocket
---@field public ConnectionKey HostConnectionKey
---@field public IsClosed bool
---@field public PingFrequnecy TimeSpan
---@field public MaxFragmentSize UInt16
---@field public BufferedAmount Int32
---@field public Latency Int32
local WebSocketResponse={ }
---@public
---@param message string
---@return void
function WebSocketResponse:Send(message) end
---@public
---@param data Byte[]
---@return void
function WebSocketResponse:Send(data) end
---@public
---@param data Byte[]
---@param offset UInt64
---@param count UInt64
---@return void
function WebSocketResponse:Send(data, offset, count) end
---@public
---@param frame WebSocketFrame
---@return void
function WebSocketResponse:Send(frame) end
---@public
---@return void
function WebSocketResponse:Close() end
---@public
---@param code UInt16
---@param msg string
---@return void
function WebSocketResponse:Close(code, msg) end
---@public
---@param frequency Int32
---@return void
function WebSocketResponse:StartPinging(frequency) end
BestHTTP.WebSocket.WebSocketResponse = WebSocketResponse