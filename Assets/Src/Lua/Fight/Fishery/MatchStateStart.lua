---@class MatchStateStart
---@field public instance MatchStateStart
MatchStateStart = class("MatchStateStart")

---@param fishery Fishery
function MatchStateStart:enter(fishery)
    Log.debug("===MatchStateStart=================")
    UIFishPage.instance.StartBtn.visible = false
    UIFishPage.instance.WaitBtn.visible = false
    UIFishPage.instance.MatchGroup.visible = false
    UIFishPage.instance.MatchMaskPanel.visible = false

    for i = 1, 4 do
        local seat  = SeatRouter.instance:getSeatById(i)
        seat.NoReadyText.visible = false
        seat.AlreadyText.visible = false
    end
    MatchStateStart:setContestEndTime()
end

function MatchStateStart:setContestEndTime()
    UIFishPage.instance.ContestTimeGroup.y = 155
    UIFishPage.instance.ContestTimeGroup.visible = true
    UIFishPage.instance.ContestTimeText.text = "本局倒计时：".. os.date("%M:%S", Fishery.instance.contestEndTime)
    if Fishery.instance.contestEndTime <= 0 then
        if MatchStateStart.matchTimer then
            MatchStateStart.matchTimer:clear()
            MatchStateStart.matchTimer = nil
        end
    else
        MatchStateStart.matchTimer = GameTimer.loop(1000, self, function()
            if Fishery.instance.contestEndTime <= 0 then
                MatchStateStart.matchTimer:clear()
                MatchStateStart.matchTimer = nil
                return
            end
            Fishery.instance.contestEndTime = Fishery.instance.contestEndTime - 1
            UIFishPage.instance.ContestTimeText.text = "本局倒计时："..os.date("%M:%S", Fishery.instance.contestEndTime)
        end)
    end
end

---@param fishery Fishery
function MatchStateStart:execute(fishery)
end

---@param fishery Fishery
function MatchStateStart:exit(fishery)
    if MatchStateStart.matchTimer then
        MatchStateStart.matchTimer:clear()
    end
end
