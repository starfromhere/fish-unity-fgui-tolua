StateGameLogin = class("StateGameLogin")

---@param game Game
function StateGameLogin:enter(game)
    UIManager:LoadView("LoginPage", nil, UIEffectType.SMALL_TO_BIG)
end

---@param game Game
function StateGameLogin:execute(game)
end
---@param game Game
function StateGameLogin:exit(game)
    UIManager:ClosePanel("LoginPage",nil,true)
end
