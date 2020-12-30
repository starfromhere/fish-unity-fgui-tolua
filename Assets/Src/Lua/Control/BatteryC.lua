---@class BatteryC
BatteryC = class("BatteryC")
function BatteryC:ctor()
    GameEventDispatch.instance:on(tostring(13004), self, self.onFinishChangeSkin)
    GameEventDispatch.instance:on(tostring(13008), self, self.onDoubleChange)
    GameEventDispatch.instance:on(tostring(13010), self, self.onEndBuyDouble)

end
function BatteryC:onEndBuyDouble(data)
    if 0 == data.code then

        
    else
        if 1 == data.code then
            GameTip.showTip("钻石不足")

        end
    end

end
function BatteryC:onDoubleChange(data)
    if 0 == data.code then
        RoleInfoM.instance().coin_rate = data['coin_rate']
        RoleInfoM.instance().chance_rate = data['chance_rate']
        RoleInfoM.instance().coin_rate_buy = data['coin_rate_buy']
        RoleInfoM.instance().chance_rate_buy = data['chance_rate_buy']
        GameEventDispatch.instance:event(GameEvent.BatteryRateChagne)
    else
        GameTools:dealCode(data.code)
    end
end

function BatteryC:onFinishChangeSkin(data)
    if data.code == 0 then
        RoleInfoM.instance():setCurSkin(data['cskin'])
        GameEventDispatch.instance:event(GameEvent.FinishChangeSkin)
    else
        GameEventDispatch.instance:event("MsgTipContent", "切换失败")
    end
end
