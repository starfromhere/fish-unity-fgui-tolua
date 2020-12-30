function Game:onNetworkReceive(protoMsg)
    self.lastReceiveTs = TimeTools.getCurMill()
    GameEventDispatch.instance:Event(tostring(protoMsg.id), protoMsg.a)
end

---@param ws WebSocket
function Game:onNetworkError(ws)
    if ws == WebSocketManager.instance.socket then
        WebSocketManager.instance:Destroy()
        Game.instance.fsm:changeState(StateGameDisconnect)
        GameEventDispatch.instance:Event(GameEvent.WsError);
    end
end
function Game:onNetworkClose()

end
function Game:onNetworkOpen()
    self.lastReceiveTs = TimeTools.getCurMill()
    Game.instance.reconnectTime = 0
    if self.fsm:isInState(StateGameDisconnect) and Game.instance._IsFirstEntryGame==false then
        Log.info("=============== 是否会出现空白用户登录的情况");
        self.fsm:changeState(StateGameMain)
    end
end

---是否已经连上网络
function Game:networkIsUp()
    return WebSocketManager.instance.isConnected
end

---检察协议超时
function Game:_checkWsTimeOut()
    if self:networkIsUp() then
        if TimeTools.getCurMill() - self.lastReceiveTs > self.timeOut then
            self.resetInfo.tip = "网络重连中..."
            self.resetInfo.autoReconnect = true
            self.fsm:changeState(StateGameDisconnect)
        end
    end
end

---发送心跳
function Game:_sendHeartBeat()
    if self:networkIsUp() then
        local currentTime = TimeTools.getCurMill()
        if currentTime - self.lastHeartBeatTs >= 2000 then
            NetSender.HeartBeat()
            self.lastHeartBeatTs = currentTime
        end
    end
end
