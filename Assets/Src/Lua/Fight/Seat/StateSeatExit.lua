---@class StateSeatExit
---@field public instance StateSeatExit
StateSeatExit = class("StateSeatExit")
---@param seat Seat
function StateSeatExit:enter(seat)
    if not seat:isMySeat() then
        --seat.waitComponent.visible = true
        --seat.playerComponent.visible = false
        seat:changeSkin(3)
        seat:setCoin(0)
        seat:setFortLev(cfg_battery.instance(1).comsume)
        seat.playerNameText.text = "等待加入"
        seat.myCoinCount = 0
    end
    seat:closeAuto()
    seat:onZuantoupaoEffectCompleted()
    seat:showAutoShoot(false)
    GameTimer.clearTarget(seat)
    seat.seatInfo = nil
    seat.bingoController:resetUi()
end

---@param seat Seat
function StateSeatExit:execute(seat)
end
---@param seat Seat
function StateSeatExit:exit(seat)
end
