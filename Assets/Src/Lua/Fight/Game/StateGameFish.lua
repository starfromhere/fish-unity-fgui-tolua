StateGameFish = class("StateGameFish")

---@param game Game
function StateGameFish:enter(game)
    Log.debug("StateGameFish:enter")

    UIManager:LoadView("FishPage", nil, UIEffectType.NORMAL)
end

---@param game Game
function StateGameFish:execute(game)
end
---@param game Game
function StateGameFish:exit(game)
    Log.debug("StateGameFish:exit")

    Fishery.instance:exitFight()
    FightM.instance:dataReset()
    UIManager:ClosePanel("FishPage")
    SoundManager.PlayMusic("Music/bgmusic.mp3")

    GameEventDispatch.instance:Event(GameEvent.FightStop)
end
