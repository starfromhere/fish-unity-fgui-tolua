---@class MatchStateWaitStart
---@field public instance MatchStateWaitStart
MatchStateWaitStart = class("MatchStateWaitStart")

---@param fishery Fishery
function MatchStateWaitStart:enter(fishery)
    Log.debug("=======MatchStateWaitStart=========================")
    UIFishPage.instance.MatchController.selectedPage = "Match"
    UIFishPage.instance.StartBtn.visible = false
    UIFishPage.instance.WaitBtn.visible = false
    UIFishPage.instance.WaitGroupOne.visible = false
    UIFishPage.instance.MatchGroup.visible = true
    UIFishPage.instance.WaitGroup.visible = true
    UIFishPage.instance.MatchMaskPanel.visible = true
    Log.debug(Fishery.instance:matchIsHost() )
    if Fishery.instance:matchIsHost() then
        UIFishPage.instance.StartBtn.visible = true
        UIFishPage.instance.WaitGroup.visible = false
        -- MatchStateWaitStart:countDown()
        self:countDown()
        UIFishPage.instance.WaitGroupOne.visible = true
    else
        UIFishPage.instance.WaitGroup.visible = true
        UIFishPage.instance.WaitText.text = "请等待房主开始"
        UIFishPage.instance.StartBtn.visible = false
        UIFishPage.instance.WaitGroupOne.visible = false
    end
end

function MatchStateWaitStart:countDown()

    UIFishPage.instance.WaitTimeOneText.text = "准备倒计时：" .. os.date("%M:%S", Fishery.instance.matchEndTime)
    if Fishery.instance.matchEndTime <= 0 then
        -- if MatchStateWaitStart.matchTimer then
        --     MatchStateWaitStart.matchTimer:clear()
        -- end
        if self.matchTimer then
            self.matchTimer:clear()
        end
    else
        -- MatchStateWaitStart.matchTimer = GameTimer.loop(1000, self, function()
        self.matchTimer = GameTimer.loop(1000, self, function()
            -- if Fishery.instance.matchEndTime <= 0 then
            --     MatchStateWaitStart.matchTimer:clear()
            -- end
            if Fishery.instance.matchEndTime <= 0 then
                self.matchTimer:clear()
            end
            Fishery.instance.matchEndTime = Fishery.instance.matchEndTime - 1
            UIFishPage.instance.WaitTimeOneText.text = "准备倒计时："..os.date("%M:%S", Fishery.instance.matchEndTime)
        end)
    end
end

---@param fishery Fishery
function MatchStateWaitStart:execute(fishery)
end

---@param fishery Fishery
function MatchStateWaitStart:exit(fishery)
    -- if MatchStateWaitStart.matchTimer then
    --     MatchStateWaitStart.matchTimer:clear()
    -- end
    if self.matchTimer then
        self.matchTimer:clear()
    end
end
