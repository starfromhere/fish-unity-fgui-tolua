---@class GameTip
---@field public instance GameTip
GameTip = class("GameTip")

function GameTip.showTipById(id)
    local cfgTip = cfg_tip.instance(tonumber(id))
    GameTip.showTip(cfgTip.txtContent)
end

function GameTip.showTip(text)
    if UIManager:UIInCache("TipPage") then
        GameEventDispatch.instance:Event(GameEvent.CreateTipItem, text);
    else
        UIManager:LoadView("TipPage", text, UIEffectType.NORMAL)
    end
end

---@param info ConfirmTipInfo
function GameTip.showConfirmTip(info)
    Log.debug("UIQuitTipPage:StartGames", info.state, info.content)

    UIManager:LoadView("QuitTipPage", info)
end