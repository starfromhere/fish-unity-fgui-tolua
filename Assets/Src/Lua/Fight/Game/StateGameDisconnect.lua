StateGameDisconnect = class("StateGameDisconnect")

---@param game Game
function StateGameDisconnect:enter(game)
    Log.debug("StateGameDisconnect.enter")
    WebSocketManager.instance:Destroy()
    UIManager:LoadView("ResetCommonPage")
end

---@param game Game
function StateGameDisconnect:execute(game)
    if WebSocketManager.instance.isConnecting == false then
        if TimeTools.getCurMill() - Game.instance.lastReconnectTime > 3000 then
            Log.debug("StateGameDisconnect,reconnect")
            if Game.instance.reconnectTime > Game.instance.maxReconnectTime then
                local info = ConfirmTipInfo.new();
                info.content = "网络异常，请重试";
                info.state = ConfirmTipInfo.Middle
                info.autoCloseTime = 0
                info.middleClick = function()
                    Game.instance.fsm:changeState(StateGameLogin)
                end
                UIManager:ClosePanel("ResetCommonPage", nil, false)
                GameTip.showConfirmTip(info)
                WebSocketManager.instance.isConnecting = true
                return
            end
            Game.instance.reconnectTime = Game.instance.reconnectTime + 1
            WebSocketManager.instance:reconnect()
        end
    end
end
---@param game Game
function StateGameDisconnect:exit(game)
    Log.debug("StateGameDisconnect.exit")
    UIManager:ClosePanel("ResetCommonPage", nil, false)
    UIManager:ClosePanel("FishPage")
end
