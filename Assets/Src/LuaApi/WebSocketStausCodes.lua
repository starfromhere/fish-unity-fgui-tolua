---@class WebSocketStausCodes : Enum
---@field public value__ UInt16
---@field public NormalClosure number
---@field public GoingAway number
---@field public ProtocolError number
---@field public WrongDataType number
---@field public Reserved number
---@field public NoStatusCode number
---@field public ClosedAbnormally number
---@field public DataError number
---@field public PolicyError number
---@field public TooBigMessage number
---@field public ExtensionExpected number
---@field public WrongRequest number
---@field public TLSHandshakeError number
local WebSocketStausCodes={ }
BestHTTP.WebSocket.WebSocketStausCodes = WebSocketStausCodes