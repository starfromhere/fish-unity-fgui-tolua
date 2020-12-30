---@class MsgC
---@field public instance MsgC
MsgC = class("MsgC")
function MsgC:ctor()
    GameEventDispatch.instance:on("MsgTp", self, self.MsgTip)
    GameEventDispatch.instance:on("MsgTipContent", self, self.MsgTipContent)

    GameEventDispatch.instance:on(tostring(41001), self, self.checkSubscribe)
    GameEventDispatch.instance:on(tostring(39001), self, self.giftCodeInfoReturn)

end

function MsgC:checkSubscribe(res)
    if (res.code == 0) then
    elseif (res.code == 1) then

    elseif (res.code == 2) then
        GameEventDispatch.instance:Event(GameEvent.ResetSubBtn, { true });
    elseif (res.code == 3) then
    else
        GameTip.showTip("网络请求失败,请重试")
    end

    if (not ifgetListArr) then
        ifgetListArr = true;
        GameEventDispatch.instance:Event(GameEvent.UpdateGiftlist, { res.reward });
    end
end

function MsgC:giftCodeInfoReturn(re)
    if (re.code == 0) then
    elseif (1 == re.code) then
        GameTip.showTip("礼包码错误");
    elseif (2 == re.code) then
        GameTip.showTip("礼包码错误");
    elseif (3 == re.code) then
        GameTip.showTip("礼包码错误");
    elseif (4 == re.code) then
        GameTip.showTip("礼包码错误");
    elseif (5 == re.code) then
        GameTip.showTip("该礼包码已过期");
    elseif (6 == re.code) then
        GameTip.showTip("该礼包码不可使用");
    elseif (7 == re.code) then
        GameTip.showTip("该礼包码不可使用");
    elseif (8 == re.code) then
        GameTip.showTip("该礼包码不可使用");
    elseif (9 == re.code) then
        GameTip.showTip("已经领取完该礼包");
    elseif (10 == re.code) then
        GameTip.showTip("已经使用过该礼包码");
    elseif (11 == re.code) then
        GameTip.showTip("该礼包码不可使用");
    elseif (12 == re.code) then
        GameTip.showTip("服务器繁忙，请稍后重试");
    elseif (13 == re.code) then
        GameTip.showTip("该礼包码不可使用");
    else
        GameTools.dealCode(re.code)
    end
end

function MsgC:MsgTipContent(data)
    if MsgM.instance.content == nil then
        -- UiManager.instance:loadView("GoldTip")


    else

    end
    MsgM.instance:setContentInfo(data)

end
function MsgC:MsgTip(data)
    if MsgM.instance.content == nil then
        -- UiManager.instance:loadView("GoldTip")
    else
    end
    MsgM.instance:setContentInfo(ConfigManager.getConfValue("cfg_tip", data, "txtContent"))
end