---@class ShowGetCoinInfo
ShowGetCoinInfo = class("ShowGetCoinInfo")

--一次射击的上下文
function ShowGetCoinInfo:ctor()
    self.pos_x = nil
    self.pos_y = nil
    self.seat_id = nil
    self.goodId = nil
    self.delay = nil
    self.useTime = nil
    --@type boolean
    self.isOwn = nil
    --@type table
    self.rnd = nil
end

return ShowGetCoinInfo