---@class RuleC
---@field public instance RuleC
RuleC = class("RuleC")
function RuleC:ctor()
    GameEventDispatch.instance:On(GameEvent.GetGoldPoolAward, self, self.getGoldPoolAward)

end
function RuleC:getGoldPoolAward(data)
    RuleM.instance:coinCount(data.value)
    RuleM.instance:goodsId(1)
    RuleM.instance:activityID(data.reward_item_ids)
    RuleM.instance:activityNum(data.reward_item_nums)
    UIManager:LoadView("PrizePage")

end