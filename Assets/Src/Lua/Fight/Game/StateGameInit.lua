StateGameInit = class("StateGameInit")

---@param game Game
function StateGameInit:enter(game)
    GRoot.inst:SetContentScaleFactor(1920, 1080, ScreenMatchMode.MatchWidthOrHeight)
    GameScreen.instance:setAdaptWidthAndHeight(GRoot.inst.width, GRoot.inst.height)

    Log.debug("UnityEngine.Screen.width", UnityEngine.Screen.width, UnityEngine.Screen.height)
    Log.debug("GRoot.inst.width", GRoot.inst.width, GRoot.inst.height)

    game:initManager()
    game:initFightContext()
    game:preLoad()
    ApiManager.instance:GetAnnounce("outside", nil, function(msg)
        local m = msg.data.notice
        if m ~= nil and table.len(m) ~= 0 then
            game.fsm:changeState(StateGameNotice)
        else
            game.fsm:changeState(StateGameLogin)
        end

    end)

end

---@param game Game
function StateGameInit:execute(game)
end
---@param game Game
function StateGameInit:exit(game)
end
