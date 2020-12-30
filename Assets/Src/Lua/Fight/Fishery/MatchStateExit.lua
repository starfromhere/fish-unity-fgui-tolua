---@class MatchStateExit
---@field public instance MatchStateExit
MatchStateExit = class("MatchStateExit")

---@param fishery Fishery
function MatchStateExit:enter(fishery)
    Log.debug("===MatchStateExit=================")
    for i = 1, 4 do
        local seat  = SeatRouter.instance:getSeatById(i)
        seat.NoReadyText.visible = false
        seat.AlreadyText.visible = false
        seat.RoomHost.visible = false
    end
    ---@param controller Controller
    for _, controller in ipairs(UIFishPage.instance.fishMatchControllers) do
        controller.selectedPage = "fish"
    end
    self:resetSeatComponent()
end

function MatchStateExit:resetSeatComponent()
    for i = 2, 4  do
        local seat  = SeatRouter.instance:getSeatById(i)
        if MatchM.instance.prepareState[i] == 0 then
            seat.fsm:changeState(StateSeatExit)
        end
    end
end

---@param fishery Fishery
function MatchStateExit:execute(fishery)
end

---@param fishery Fishery
function MatchStateExit:exit(fishery)

end
