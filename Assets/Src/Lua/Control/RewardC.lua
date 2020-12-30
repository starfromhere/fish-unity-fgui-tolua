RewardC = class("RewardC")
function RewardC:ctor()
    GameEventDispatch.instance:on(tostring(15005), self, self.updateRecord)
end


function RewardC:updateRecord(res)
    if res ~= nil then
        RewardM.instance:currentList(res.list)
        GameEventDispatch.instance:event(GameEvent.RefreshLotteryRecord);

    end
end
