
---@param data
function CmdGateIn:handshake(data)
    local handshake = data
    LoginInfoM.instance.uid = handshake.uid
    LoginInfoM.instance:setShopRate(handshake.shop_rate)
    GameEventDispatch.instance:event("ReceiveHandshake", data)
    --local goldPoolAwardMsg=nil--[TODO] new C2s_30002()
    local goldPoolAwardMsg = {}
    RuleM.instance:setTime(handshake.time)
    FightM.instance:setGoldPoolTotalValue(handshake.gold_pool_value)
    goldPoolAwardMsg.value = handshake.gold_pool_value
    RoleInfoM.instance:setAwardValue(handshake.gold_pool_value)
    NetSender.OnlineReward()
    NetSender.GetSignInInfo()
    if 0 == handshake.in_fight then
        if Game.instance.firstEnterLogin and (0 == handshake.enter_main) then
            NetSender.QuickEnterRoom()
        else
            GameEventDispatch.instance:Event("ExitLoginView", nil)
            GameEventDispatch.instance:Event("FightStop")
            HorseC.instance:loopNotice()

            Game.instance.fsm:changeState(StateGameMain)
        end
    end
    if handshake.gold_pool_value > 0 then
        NetSender.PoolReward(goldPoolAwardMsg)
    end
    Game.instance.firstEnterLogin = false
end

function CmdGateIn:heartbeat(protoData)
    RuleM.instance:setTime(protoData.time);
end

function CmdGateIn:server_error(protoData)
end

function CmdGateIn:user_check_error(protoData)
end

function CmdGateIn:network_error(protoData)
end

function CmdGateIn:kicked(protoData)
end

--账号被顶
function CmdGateIn:accountReplace(protoData)

    WebSocketManager.instance:Destroy()
    -- GameTip.showTip("账号在其他设备登录，请重新登录")

    local info = ConfirmTipInfo.new();
    info.content = "账号在其他设备登录，请重新登录";
    info.state = ConfirmTipInfo.Middle
    info.autoCloseTime = 0
    info.middleClick = function()
        Game.instance.fsm:changeState(StateGameLogin)
    end
    GameTip.showConfirmTip(info)

   
    -- Game.instance.resetInfo.tip = "账号在其他设备登录，请重新登录"
    -- Game.instance.resetInfo.title = nil
    -- Game.instance.resetInfo.callback = function()
    --     Log.debug("Game.instance.resetInfo.callback")
    --     Game.instance.fsm:changeState(StateGameLogin)
    -- end
    -- Log.debug("UIResetCommonPage:StartGames11", Game.instance.resetInfo.tip, Game.instance.resetInfo.title)

    -- Game.instance.fsm:changeState(StateGameDisconnect)
end


