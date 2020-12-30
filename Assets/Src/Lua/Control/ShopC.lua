---@class ShopC
---@field public instance ShopC

ShopC = class("ShopC")

function ShopC:ctor()
    GameEventDispatch.instance:On(GameEvent.Shop, self, self.openShop);
    GameEventDispatch.instance:On(GameEvent.ShopBuy, self, self.buy);
    GameEventDispatch.instance:On(GameEvent.ChangeSkin, self, self.changeSkin);

    GameEventDispatch.instance:On(tostring(13005), self, self.updateSkins);
    GameEventDispatch.instance:On(tostring(12027), self, self.batteryChange)

    GameEventDispatch.instance:On(tostring(14007), self, self.finishAcceptMonthCardReward);
    GameEventDispatch.instance:On(tostring(14009), self, self.finishAcceptMonthCardReward);

    GameEventDispatch.instance:On(tostring(14010), self, self.buyJump);
    GameEventDispatch.instance:On(tostring(14011), self, self.buySuccess);

    GameEventDispatch.instance:On(tostring(14003), self, self.endChargeReward);
    GameEventDispatch.instance:On(tostring(14015), self, self.endExchange);
    GameEventDispatch.instance:On(tostring(14016), self, self.syncExchange);
    GameEventDispatch.instance:On(tostring(14023), self, self.syncMiniBalance);
    GameEventDispatch.instance:On(tostring(14021), self, self.syncActivityTicket);

    GameEventDispatch.instance:On(tostring(14018), self, self.endGift);
    GameEventDispatch.instance:On(tostring(14020), self, self.endConfirmGift);
    GameEventDispatch.instance:On(tostring(14030), self, self.showRewardTip);
    GameEventDispatch.instance:On(tostring(14029), self, self.endUseMonthCard);
    GameEventDispatch.instance:On(tostring(14032), self, self.appOrderCheckRet);
end

function ShopC:updateSkins(data)
    if data.skins then
        RoleInfoM.instance:setSkins(data.skins)
    end
end

function ShopC:buySuccess(data)
    if data.code == 0 then
        if data.skins then
            RoleInfoM.instance:setSkins(data.skins)
        end
        if data.purchased_items then
            RoleInfoM.instance:setPurchasedItems(data.purchased_items)
        end
        if data.charge_times then
            RoleInfoM.instance:setChargeTimes(data.charge_times)
        end
        if data.charge_total then
            RoleInfoM.instance:setChargeTotal(data.charge_total)
        end
        if data.vip_exp then
            RoleInfoM.instance:setVipExp(data.vip_exp)
        end
        if data.vip then
            RoleInfoM.instance:setVip(data.vip)
        end
        if data.month_card then
            RoleInfoM.instance:setMonthCard(data.month_card)
        end

        GameEventDispatch.instance:Event(GameEvent.UpdateProfile)
        GameEventDispatch.instance:Event(GameEvent.MonthCardUpdate)
        GameEventDispatch.instance:Event(GameEvent.ShopRefresh, data.tab);
        GameEventDispatch.instance:Event(GameEvent.RewardTip, { data.reward_item_ids, data.reward_item_nums });
    end
end

function ShopC:endChargeReward(data)
    if 0 == data.code then
        RoleInfoM.instance:setFirstChargeRewardAccepted(1)
        local index = table.indexOf(data.reward_item_ids,23)

        if index > -1 then
            table.splice(data.reward_item_ids,index)
            table.splice(data.reward_item_nums,index)
        end

        GameEventDispatch.instance:Event(GameEvent.RewardTip, {data.reward_item_ids, data.reward_item_nums});
        GameEventDispatch.instance:Event(GameEvent.UpdateFirstCharge);
    else
        GameTip.showTip("重复领取")
    end
end

function ShopC:openShop(value)
    UIManager:LoadView("ShopPage", value, UIEffectType.SMALL_TO_BIG)
end

function ShopC:changeSkin(skin_id)
    local p = {}
    p["skin"] = tonumber(skin_id)
    p["battery"] = 0
    NetSender.ChangeBatterySkin(p);
end

function ShopC:batteryChange(data)
    --RoleInfoM.instance:setCurSkin(data.cskin)
    --GameEventDispatch.instance:event(GameEvent.ChangeSkin)
end

function ShopC:buy(commodity)
    local a = {}
    a.id = commodity.id;
    a.platform = "";
    NetSender.Buy(a);
end

function ShopC:finishAcceptMonthCardReward(data)
    if data.month_card then
        RoleInfoM.instance:setMonthCard(data.month_card)
    end
    if data.reward_item_ids then

        GameEventDispatch.instance:Event(GameEvent.RewardTip, { data.reward_item_ids, data.reward_item_nums });
    end

    GameEventDispatch.instance:Event(GameEvent.MonthCardUpdate);
end

function ShopC:endExchange(data)
    if data.code == 0 then
        local type = data.result["data"].type
        if (type == "red_pack") then
            if (ExchangeM.instance:getCurSelect() == 1) then
                GameTip.showTip("兑换成功,请前往《集结号捕鱼H5》公众号,领取福袋");
                --GameEventDispatch.instance.event(GameEvent.MsgTipContent, {
                --    str: "兑换成功,请前往《集结号捕鱼H5》公众号,领取福袋",
                --    time: 1500
                --})
            elseif (ExchangeM.instance:getCurSelect() == 2) then
                GameTip.showTip("兑换成功,请前往《集结号福袋》小程序,领取福袋");
                --TODO 写延时tips
                --GameEventDispatch.instance.event(GameEvent.MsgTipContent, {
                --    str: "兑换成功,请前往《集结号福袋》小程序,领取福袋",
                --    time: 1500
                --})
            end
        else
            if (data.is_show) then
                GameEventDispatch.instance:Event(GameEvent.RewardTip,{data.reward_item_ids, data.reward_item_nums});
            end
            GameEventDispatch.instance:Event(GameEvent.ExchangeFinish, data);
        end
    elseif (1 == data.code) then
        GameTip.showTip("喇叭不足");
    elseif (2 == data.code) then
        GameTip.showTip("库存不足");
    elseif (3 == data.code) then
        GameTip.showTip("金币不足");
    elseif (4 == data.code) then
        GameTip.showTip("参数错误");
    elseif (5 == data.code) then
        GameTip.showTip("商品兑换时间已结束");
    elseif (6 == data.code) then
        GameTip.showTip("更新库存失败");
    elseif (8 == data.code) then
        GameTip.showTip("用户数据错误");
    elseif (9 == data.code) then
        GameTip.showTip("喇叭兑换失败,请稍后重试");
    elseif (10 == data.code) then
        GameTip.showTip("兑换超过限制");
    elseif (11 == data.code) then
        GameTip.showTip("喇叭兑换失败,请稍后重试");
    elseif (13 == data.code) then
        GameTip.showTip("该账号存在风险，已被微信拦截");
    elseif (14 == data.code) then
        GameTip.showTip("您已达到上限");
    elseif (15 == data.code) then
        GameTip.showTip("请先关注《集结号捕鱼H5》公众号");
    elseif (20 == data.code) then
        GameTip.showTip("系统错误");
    elseif (30 == data.code) then
        GameTip.showTip("账号未绑定");
    elseif (31 == data.code) then
        GameTip.showTip("该渠道兑换已关闭");
    elseif (32 == data.code) then
        GameTip.showTip("兑换喇叭参数错误");
        --                  福利转转转活动
    elseif (100 == data.code) then
        GameTip.showTip("福利转转转活动已结束");
    elseif (101 == data.code) then
        GameTip.showTip("皮肤已经拥有");
    elseif (102 == data.code) then
        GameTip.showTip("您已经兑换过该皮肤");
    else
        GameTools.dealCode(data.code);
    end
    GameEventDispatch.instance:Event(GameEvent.UpdateExchangeBtn)
end

function ShopC:syncExchange(data)
    local exchange = { data["exchange"] }
    RoleInfoM.instance:setExchange(exchange);
    GameEventDispatch.instance:event(GameEvent.UpdateExchange, exchange);
end

function ShopC:syncMiniBalance(data)
    if data.code == 0 then
        local balance = data["balance"]

        if data["charge_times"] then
            local chargeTime = data["charge_times"]
            RoleInfoM.instance:setChargeTimes(chargeTime)
        end

        GameEventDispatch.instance:event(GameEvent.UpdateMiniBalance, balance);
        GameEventDispatch.instance:event(GameEvent.UpdateFirstCharge);
    end
end

function ShopC:endGift(data)
    if data.code == 0 then
        GameTip.showTip("赠送成功")
        GameEventDispatch.instance:Event(GameEvent.GiftFinish, data);
    elseif data.code == 1 then
        GameTip.showTip("道具不足");
    elseif data.code == 2 then
        GameTip.showTip("不能赠送给自己");
    elseif data.code == 3 then
        GameTip.showTip("该道具不能赠送");
    elseif data.code == 5 then
        GameTip.showTipById(46);
    elseif data.code == 6 then
        GameTip.showTip("激活月卡，开放赠送功能");
    elseif data.code == 7 then
        GameTip.showTip("解锁炮台，开放赠送功能");
    end
end

function ShopC:endConfirmGift(data)
    if data.code == 0 then
        if data.reward_item_ids then
            GameEventDispatch.instance:Event(GameEvent.RewardTip, { data.reward_item_ids, data.reward_item_nums });
        end
        GameEventDispatch.instance:event(GameEvent.GiftConfirmFinish, data);
    elseif data.code == 1 then
        GameTip.showTip("重复领取");
    elseif data.code == 2 then
        GameTip.showTip("操作失败");
    end
end

function ShopC:isShowFirstIcon()
    if RoleInfoM.instance:getFirstChargeRewardAccepted() == 1 then
        return false
    else
        if RoleInfoM.instance:getLevel() >= cfg_first_charge.instance(1).level then
            return true
        end
        if RoleInfoM.instance:getChargeTimes() > 0 then
            return true
        end
        return false
    end
end

function ShopC:showRewardTip(data)
    GameEventDispatch.instance:Event(GameEvent.RewardTip, { data.reward_item_ids, data.reward_item_nums })
end
        