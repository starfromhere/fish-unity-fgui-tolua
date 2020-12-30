---@class MatchStateWaitPrepare
---@field public instance MatchStateWaitPrepare
MatchStateWaitPrepare = class("MatchStateWaitPrepare")

---@param fishery Fishery
function MatchStateWaitPrepare:enter(fishery)
    Log.debug("===MatchStateWaitPrepare=========================")

    UIFishPage.instance.MatchController.selectedPage = "Match"
    UIFishPage.instance.StartBtn.visible = false
    UIFishPage.instance.WaitBtn.visible = false
    UIFishPage.instance.WaitGroupOne.visible = false
    UIFishPage.instance.MatchGroup.visible = true
    UIFishPage.instance.WaitGroup.visible = true
    UIFishPage.instance.MatchMaskPanel.visible = true
    UIFishPage.instance.WaitText.text = "还有玩家未准备请稍等 \n......"

    if Fishery.instance:matchIsHost() then
        UIFishPage.instance.WaitGroup.visible = true
    else
        UIFishPage.instance.WaitGroup.visible = false
        UIFishPage.instance.WaitBtn.visible = true
    end
end

---@param fishery Fishery
function MatchStateWaitPrepare:execute(fishery)
end

---@param fishery Fishery
function MatchStateWaitPrepare:exit(fishery)

end
