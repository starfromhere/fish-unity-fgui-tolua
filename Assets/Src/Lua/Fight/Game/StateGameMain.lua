StateGameMain = class("StateGameMain")

---@param game Game
function StateGameMain:enter(game, preSceneId)

    Log.debug("StateGameMain:enter", preSceneId)
    if Game.instance._IsFirstEntryGame then
        UIManager:LoadView("InsidePage", "inside")
        Game.instance._IsFirstEntryGame = false
    end

    UIManager:LoadView("MainPage", { preSceneId = preSceneId }, UIEffectType.NORMAL)
end

---@param game Game
function StateGameMain:execute(game)
end
---@param game Game
function StateGameMain:exit(game)
    Log.debug("StateGameMain:exit")
end
