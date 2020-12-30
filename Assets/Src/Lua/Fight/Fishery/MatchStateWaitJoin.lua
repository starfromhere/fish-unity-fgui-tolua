---@class MatchStateWaitJoin
---@field public instance MatchStateWaitJoin
MatchStateWaitJoin = class("MatchStateWaitJoin")

---@param fishery Fishery
function MatchStateWaitJoin:enter(fishery)
    Log.debug("====MatchStateWaitJoin============================")
    UIFishPage.instance.MatchController.selectedPage = "Match"
    UIFishPage.instance.StartBtn.visible = false
    UIFishPage.instance.WaitBtn.visible = false
    UIFishPage.instance.WaitGroupOne.visible = false
    UIFishPage.instance.MatchGroup.visible = true
    UIFishPage.instance.WaitGroup.visible = true
    UIFishPage.instance.WaitText.text = "等待其他玩家加入 \n......"
    UIFishPage.instance.MatchMaskPanel.visible = true

    local seat = SeatRouter.instance.mySeat
    if SeatRouter.instance.mySeatId == Fishery.instance.matchHostSeatId then
        seat.RoomHost.visible = true
        seat.NoReadyText.visible = false
        seat.AlreadyText.visible = false
    else
        seat.RoomHost.visible = false
        seat.NoReadyText.visible = true
        seat.AlreadyText.visible = false
        Fishery.instance:waitPrepareMatchGame()
    end


end

---@param fishery Fishery
function MatchStateWaitJoin:execute(fishery)
end

---@param fishery Fishery
function MatchStateWaitJoin:exit(fishery)

end
