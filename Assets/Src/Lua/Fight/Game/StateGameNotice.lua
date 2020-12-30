StateGameNotice = class("StateGameNotice")

---@param game Game
function StateGameNotice:enter(game)

    UIManager:LoadView("InsidePage", "outside")
end

---@param game Game
function StateGameNotice:execute(game)
end
---@param game Game
function StateGameNotice:exit(game)
end
