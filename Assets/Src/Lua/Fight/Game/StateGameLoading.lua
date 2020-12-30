StateGameLoading = class("StateGameLoading")

---@param game Game
function StateGameLoading:enter(game)
    Log.debug("StateGameFish:enter", encode(game.loadingRes))

    UIManager:LoadView("LoadPage",nil ,UIEffectType.NORMAL)
    for _, res in ipairs(game.loadingRes) do
        UIPackageManager.instance:AddPackage(res.path, res.packageName)
    end

    UIManager:LoadView("FishPage",nil ,UIEffectType.NORMAL)
    --if game.nextState then
    --    game.fsm:changeState(game.nextState)
    --    game.nextState = nil
    --end
    
    GameTimer.once(1800, self, function ()
        game.loadingResComplete = true
        Log.debug("game.loadingResComplete value: ", game.loadingResComplete)
    end)
end

---@param game Game
function StateGameLoading:execute(game)
    local offset = (90 - game.progressValue)*0.1
    local completeValue = game.loadingResComplete and 100 or 90;
    game.progressValue = game.progressValue + offset >= completeValue and completeValue or game.progressValue + offset
    local value = game.progressValue
    GameEventDispatch.instance:Event(GameEvent.LoadPressBarChange, value)
    
    if game.nextState and game.loadingResComplete then
        game.fsm:changeState(game.nextState)
        game.nextState = nil
        game.loadingResComplete = false
        game.progressValue = 0
    end
end
---@param game Game
function StateGameLoading:exit(game)
    UIManager:ClosePanel("LoadPage")
end
