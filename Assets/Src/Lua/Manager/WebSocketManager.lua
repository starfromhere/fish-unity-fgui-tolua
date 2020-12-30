---@type Uri
local Uri = System.Uri
---@type WebSocket
local WebSocket = BestHTTP.WebSocket.WebSocket

---@class WebSocketManager
---@field instance WebSocketManager
WebSocketManager = class("WebSocketManager")

---@field private socket WebSocket
function WebSocketManager:ctor()
    ---@type WebSocket
    self.socket = nil
    self.connectUrl = nil
    self.isConnected = false
    self.isConnecting = false

    self.ignore_print_ids = { 12016, 11001, 11002, 12017, 12035, 12014 }

    ---@type table<WebSocket,WebSocket>
    self.sockets = {}
    self.handlers = {
        onOpenHandler = nil,
        onErrorHandler = nil,
        onCloseHandler = nil,
        onReceiveHandler = nil,
        caller = nil
    }
end

---ConnectWebSocket 连接websocket
---@param url string
---@return void
function WebSocketManager:Connect(url)
    if self.socket then
        return
    end
    self.connectUrl = url
    self.socket = WebSocket(Uri(url))
    Log.info("websocket connect", url)
    self.socket.OnOpen = function(ws)
        if ws ~= self.socket then
            return
        end
        Log.info("websocket connected")
        self.isConnected = true
        self.isConnecting = false
        if self.handlers.onOpenHandler then
            self.handlers.onOpenHandler(self.handlers.caller)
        end
    end

    self.socket.OnError = function(ws, err)
        if ws ~= self.socket then
            return
        end
        Log.error("websocket error", err)
        self.isConnecting = false
        if self.handlers.onErrorHandler then
            --TODO  onError可能比最后一条协议更先执行，onError延后100ms执行
            GameTimer.once(100, self.handlers.caller, self.handlers.onErrorHandler, { ws })
        end
    end

    self.socket.OnClosed = function(ws, code, message)
        if ws ~= self.socket then
            return
        end
        self.isConnecting = false
        Log.info("websocket close,code = " .. code .. ",message=" .. message)
        if self.handlers.onCloseHandler then
            self.handlers.onCloseHandler(self.handlers.caller)
        end
    end

    self.socket.OnBinary = function(ws, data)
    end

    self.socket.OnMessage = function(ws, message)
        if ws ~= self.socket then
            return
        end

        if message == nil or #message <= 0 then
            Log.warning("消息为空")
            return
        end
        local protoMsg = decode(message)

        if protoMsg.id == nil then
            Log.warning("协议不存在协议号", message)
            return
        end

        if ENV.IN_EDITOR and table.indexOf(self.ignore_print_ids, protoMsg.id) < 0 then
            Log.info("【websocket Recv】", tostring(protoMsg.id), encode(protoMsg.a))
        end

        if self.handlers.onReceiveHandler then
            self.handlers.onReceiveHandler(self.handlers.caller, protoMsg)
        end
    end

    self.socket:Open()
end

---Destory
---@public
---@return void
function WebSocketManager:Destroy()
    Log.debug("WebSocketManager:Destroy")

    if self.socket and self.socket.IsOpen then
        self.socket:Close()
    end
    self.socket = nil
    self.isConnected = false
end

---Send 发送数据 兼容send
---@public
---@param id string or number
---@param info table
---@return void
function WebSocketManager:Send(id, info)
    if id == nil then
        Log.debug("不存在的协议号");
    end
    local sid = type(id) == "string" and tonumber(id) or id
    local sinfo = info
    sinfo = sinfo or {}

    local protoMsg = {}
    if (self.socket ~= nil and self.socket.IsOpen) then
        protoMsg["id"] = sid
        protoMsg["a"] = sinfo
        self.socket:Send(encode(protoMsg));
        if ENV.IN_EDITOR and table.indexOf(self.ignore_print_ids, protoMsg.id) < 0 then
            Log.debug(string.format("【websocket Send】id:%s, mdg:%s", tostring(id), encode(sinfo)))
        end
    end
end

function WebSocketManager:SendObject(obj)
    local protoMsg = {}
    if (self.socket ~= nil and self.socket.IsOpen) then
        protoMsg["id"] = obj.msg_id
        protoMsg["a"] = obj
        self.socket:Send(encode(protoMsg));
        if ENV.IN_EDITOR and table.indexOf(self.ignore_print_ids, protoMsg.id) < 0 then
            Log.debug(string.format("【websocket Send】id:%s, mdg:%s", tostring(obj.msg_id), encode(obj)))
        end
    end
end

function WebSocketManager:reconnect()
    Log.debug("【websocket reconnect】reconnecting！", self.socket, self.isConnecting)
    if self.socket == nil and self.isConnecting == false then
        self.isConnecting = true
        self:Connect(self.connectUrl);
        Game.instance.lastReconnectTime = TimeTools.getCurMill()
    end
end

WebSocketManager.send = WebSocketManager.Send
