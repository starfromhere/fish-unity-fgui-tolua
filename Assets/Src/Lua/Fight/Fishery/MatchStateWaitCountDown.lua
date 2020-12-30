---@class MatchStateWaitCountDown
---@field public instance MatchStateWaitPrepare
MatchStateWaitCountDown = class("MatchStateWaitCountDown")

---@param fishery Fishery
function MatchStateWaitCountDown:enter(fishery)
    Log.debug("===MatchStateWaitCountDown=========================")

    UIFishPage.instance.WaitGroupOne.visible = true
    self:countDown()
end

function MatchStateWaitCountDown:countDown()

    UIFishPage.instance.WaitTimeOneText.text = "准备倒计时：" .. os.date("%M:%S", Fishery.instance.matchEndTime)
    if Fishery.instance.matchEndTime <= 0 then
        if self.matchTimer then
            self.matchTimer:clear()
        end
    else
        self.matchTimer = GameTimer.loop(1000, self, function()
            if Fishery.instance.matchEndTime <= 0 then
                self.matchTimer:clear()
                return
            end
            Fishery.instance.matchEndTime = Fishery.instance.matchEndTime - 1
            UIFishPage.instance.WaitTimeOneText.text = "准备倒计时："..os.date("%M:%S", Fishery.instance.matchEndTime)
        end)
    end
end

---@param fishery Fishery
function MatchStateWaitCountDown:execute(fishery)
end

---@param fishery Fishery
function MatchStateWaitCountDown:exit(fishery)

end
