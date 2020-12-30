---@class WebSocket : Object
---@field public OnOpen OnWebSocketOpenDelegate
---@field public OnMessage OnWebSocketMessageDelegate
---@field public OnBinary OnWebSocketBinaryDelegate
---@field public OnClosed OnWebSocketClosedDelegate
---@field public OnError OnWebSocketErrorDelegate
---@field public OnIncompleteFrame OnWebSocketIncompleteFrameDelegate
---@field public State number
---@field public IsOpen bool
---@field public BufferedAmount Int32
---@field public StartPingThread bool
---@field public PingFrequency Int32
---@field public CloseAfterNoMesssage TimeSpan
---@field public InternalRequest HTTPRequest
---@field public Extensions IExtension[]
---@field public Latency Int32
---@field public LastMessageReceived DateTime
local WebSocket={ }
---@public
---@return void
function WebSocket:Open() end
---@public
---@param message string
---@return void
function WebSocket:Send(message) end
---@public
---@param buffer Byte[]
---@return void
function WebSocket:Send(buffer) end
---@public
---@param buffer Byte[]
---@param offset UInt64
---@param count UInt64
---@return void
function WebSocket:Send(buffer, offset, count) end
---@public
---@param frame WebSocketFrame
---@return void
function WebSocket:Send(frame) end
---@public
---@return void
function WebSocket:Close() end
---@public
---@param code UInt16
---@param message string
---@return void
function WebSocket:Close(code, message) end
---@public
---@param code UInt16
---@param message string
---@return Byte[]
function WebSocket.EncodeCloseData(code, message) end
BestHTTP.WebSocket.WebSocket = WebSocket