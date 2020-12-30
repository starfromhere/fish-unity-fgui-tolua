---@class LevelC
---@field public instance LevelC
LevelC = class("LevelC")
function LevelC:ctor()
    GameEventDispatch.instance:on(tostring(42000), self, self.isHaveRankReward)
    GameEventDispatch.instance:on(tostring(42002), self, self.onGetReward)
    GameEventDispatch.instance:on(tostring(42005), self, self.fishGoldBoxIsShow)
    GameEventDispatch.instance:on("LevelC", self, self.LevelTip)
    GameEventDispatch.instance:on("OpenSubscibe", self, self.onOpenSubscibe)

end

function LevelC:onOpenSubscibe()
    WxC:subscribeInfo({ 1 })
end

function LevelC:fishGoldBoxIsShow(res)
    if res then
        LoginInfoM.instance:setIsShowRankAniBox(res.show)
        GameEventDispatch.instance:event("RankAniRefesh")
    end
end

function LevelC:onGetReward(res)
    if res.code == 0 then
        GameEventDispatch.instance:event("MsgTipContent", "领取成功")
    else
        if res.code == 1 then
            GameEventDispatch.instance:event("MsgTipContent", "领取成功")
        else
            Log.debug("不明错误/code:" .. res.code)
        end
    end
end

function LevelC:isHaveRankReward(res)
    if res then
        LevelM.instance:isCanReward(res.can_reward)
        if res.data["1"] then
            LevelM.instance:coinRankLv(res.data['1'].ranking or -1)
            LevelM.instance:coinReward(res.data["1"].reward or {})
        else
            LevelM.instance:coinReward({})
            LevelM.instance:coinRankLv(-1)
        end

        if res.data["2"] then
            LevelM.instance:strengthRankLv(res.data['2'].ranking or -1)
            LevelM.instance:strengthReward(res.data['2'].reward or {})
        else
            LevelM.instance:strengthRankLv(-1)
            LevelM.instance:strengthReward({})
        end
        GameEventDispatch.instance:event(GameEvent.SynRankReward)

    end
end

function LevelC:LevelTip(data)
    LevelM.instance:setInfo(data)
    UiManager.instance:loadView("Level")

end