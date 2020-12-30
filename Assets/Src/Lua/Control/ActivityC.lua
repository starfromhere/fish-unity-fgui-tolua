---@class ActivityC
---@field public instance ActivityC
ActivityC = class("ActivityC")
function ActivityC:ctor()
    self.is_reward = nil
    self.teams = nil
    self.worldcup_info = nil
    GameEventDispatch.instance:on(tostring(32000), self, self.syncActivityData)
    GameEventDispatch.instance:on(tostring(32001), self, self.syncActivityStatus)
    GameEventDispatch.instance:on(tostring(36009), self, self.bettingSuccess)
    GameEventDispatch.instance:on(tostring(36012), self, self.endAcceptReward)
    GameEventDispatch.instance:on(tostring(36016), self, self.endSyncJackpotInfo)
    GameEventDispatch.instance:on(tostring(40006), self, self.actRegister)
    GameEventDispatch.instance:on(tostring(40008), self, self.registerState)
    GameEventDispatch.instance:on(tostring(40009), self, self.exchangeTime)
    GameEventDispatch.instance:on(tostring(32003), self, self.actCurrency)
    GameEventDispatch.instance:on(tostring(40011), self, self.exchangeReturn)
    GameEventDispatch.instance:on(tostring(40012), self, self.giftData)
    GameEventDispatch.instance:on(tostring(40014), self, self.giftReturn)
    GameEventDispatch.instance:on(tostring(40015), self, self.synAirBalloonRankData)
    GameEventDispatch.instance:on(tostring(40019), self, self.synAirBalloonAccountData)
    GameEventDispatch.instance:on(tostring(40017), self, self.synAirBalloonGameData)
    GameEventDispatch.instance:on(tostring(40020), self, self.synAirBalloonGameState)

    GameEventDispatch.instance:on(tostring(19010), self, self.synRedData)
    GameEventDispatch.instance:on(tostring(19012), self, self.synRedReturn)
    GameEventDispatch.instance:on(tostring(19013), self, self.synCoinData)

end

function ActivityC:loopSyncActivity()
    self:loopSyncActivityByName('worldcup2')
end

function ActivityC:synCoinData(data)
    if data then
        ActivityM.instance.gainCoin = data["g"]
        if ActivityM.instance.gainCoin < 0 then
            ActivityM.instance.gainCoin = 0
        end
        self:updateMoney()
    end
    GameEventDispatch.instance:Event(GameEvent.SynTaskCoinData)
end

function ActivityC:synRedReturn(data)
    if data.code == 0 then
    else
        if data.code == 1 then
            GameTip.showTip("任务未完成")
        else
            GameTools:dealCode(data.code)
        end
    end
end

function ActivityC:synRedData(data)
    if data and data.red_task_msg then
        local msg = data.red_task_msg
        ActivityM.instance.gainCoin = msg.g
        if ActivityM.instance.gainCoin < 0 then
            ActivityM.instance.gainCoin = 0
        end
        if msg.reward_times then
            ActivityM.instance.rewardTimes = msg.reward_times
        end
        ActivityM.instance.redState = msg.state
        self:updateMoney()
    end
    GameEventDispatch.instance:Event(GameEvent.SynRedData)
    GameEventDispatch.instance:Event(GameEvent.SynTaskCoinData)

end

function ActivityC:updateMoney()
    local redArr = ConfigManager.items("cfg_task_red_reward")
    if redArr then
        if ActivityM.instance.gainCoin >= ActivityM.instance.taskRequire or ActivityM.instance.gainCoin <= ActivityM.instance.lowRequireCoin then
            local redRewardData = redArr[#redArr]
            if ActivityM.instance.gainCoin >= redRewardData.taskNum then
                ActivityM.instance.lowRequireCoin = redArr[#redArr - 1].taskNum
                ActivityM.instance.lowMoney = { redArr[#redArr - 1].reward_money_1, redArr[#redArr - 1].reward_money_2, redArr[#redArr - 1].reward_money_3 }
                ActivityM.instance.taskRequire = redRewardData.taskNum
                ActivityM.instance.maxTaskId = #redArr
                ActivityM.instance.taskMoney = { redRewardData.reward_money_1, redRewardData.reward_money_2, redRewardData.reward_money_3 }
            else
                for i = 1, #redArr do
                    redRewardData = redArr[i]
                    if ActivityM.instance.gainCoin < redRewardData.taskNum then
                        if i == 1 then
                            ActivityM.instance.lowRequireCoin = 0
                            ActivityM.instance.lowMoney = {}
                            ActivityM.instance.taskRequire = redRewardData.taskNum
                            ActivityM.instance.maxTaskId = 1
                            ActivityM.instance.taskMoney = { redRewardData.reward_money_1, redRewardData.reward_money_2, redRewardData.reward_money_3 }
                        else
                            ActivityM.instance.lowRequireCoin = redArr[i - 1].taskNum
                            ActivityM.instance.lowMoney = { redArr[i - 1].reward_money_1, redArr[i - 1].reward_money_2, redArr[i - 1].reward_money_3 }
                            ActivityM.instance.taskRequire = redRewardData.taskNum
                            ActivityM.instance.maxTaskId = i
                            ActivityM.instance.taskMoney = { redRewardData.reward_money_1, redRewardData.reward_money_2, redRewardData.reward_money_3 }
                        end
                        break
                    end
                end
            end
        end
    end
end

function ActivityC:loopSyncActivityByName(activity)
    local extraTime = ActivityM.instance:getActivityExtraTime(activity)
    local now = TimeTools.getCurSec()
    console:log("extraTime:" + extraTime)
    console:log("now:" + now)
    if ActivityM.instance:activityIsExtraTime(activity) then
        if now > extraTime then
            if not ActivityM.instance:activityIsDown(activity) then
                console:log("sendSync")
                NetSender.ActivityStatus()
            end
        end
    end
end

function ActivityC:syncActivityData(result)
    ActivityM.instance.activity_data = result["list"]
    ActivityM.instance:setCommonImage()
    GameEventDispatch.instance:event("SyncActivityData")

end
function ActivityC:syncActivityStatus(result)
    ActivityM.instance.activity_status = result["activity_status"]
    ActivityM.instance.sub_activity_status = result["sub_activity_status"]
    GameEventDispatch.instance:event(GameEvent.SyncActivityStatus)

end
function ActivityC:bettingSuccess(re)
    if 0 == re.code then
        GameEventDispatch.instance:event("MsgTipContent", "下注成功")
        GameEventDispatch.instance:event("stcBettingSuccess")


    else

    end

end
function ActivityC:actRegister(re)
    ActivityM.instance.actRegister_data = re["data"]
    ActivityM.instance.actRegister_time = re["day"]
    GameEventDispatch.instance:event("ActRegister")

end
function ActivityC:exchangeReturn(data)
    if 0 == data.code then
        GameEventDispatch.instance:event("MsgTipContent", "兑换成功")


    else
        if 1 == data.code then
            GameEventDispatch.instance:event("MsgTipContent", "活动未开启或无效")


        else
            if 2 == data.code then
                GameEventDispatch.instance:event("MsgTipContent", "活动币不足")


            else
                if 3 == data.code then
                    GameEventDispatch.instance:event("MsgTipContent", "兑换剩余次数不足")


                else
                    if 4 == data.code then
                        GameEventDispatch.instance:event("MsgTipContent", "活动已关闭")


                    else
                        if 5 == data.code then
                            GameEventDispatch.instance:event("MsgTipContent", "参数错误")


                        else
                            GameTools:dealCode(data.code)

                        end
                    end
                end
            end
        end
    end

end
function ActivityC:giftReturn(data)
    if 0 == data.code then
        GameEventDispatch.instance:event("MsgTipContent", "兑换成功")


    else
        if 1 == data.code then
            GameEventDispatch.instance:event("MsgTipContent", "活动已关闭")


        else
            if 2 == data.code then
                GameEventDispatch.instance:event("MsgTipContent", "已兑换")


            else
                if 3 == data.code then
                    GameEventDispatch.instance:event("MsgTipContent", "无活动数据")


                else
                    if 4 == data.code then
                        GameEventDispatch.instance:event("MsgTipContent", "活动币不足")


                    else
                        if 5 == data.code then
                            GameEventDispatch.instance:event("MsgTipContent", "兑换错误")


                        else
                            GameTools:dealCode(data.code)

                        end
                    end
                end
            end
        end
    end

end
function ActivityC:actCurrency(data)
    ActivityM.instance.actCurrency_data = data["user_at_coin"]
    GameEventDispatch.instance:event("ActCurrency")

end
function ActivityC:exchangeTime(data)
    ActivityM.instance.exchange_times = data["exchange_times"]
    GameEventDispatch.instance:event("ExchangeTime")

end
function ActivityC:giftData(data)
    ActivityM.instance.is_exchange = data["is_exchange"]
    ActivityM.instance.cdkeys_id = data["cdkeys"]
    GameEventDispatch.instance:event("ActCdk")

end
function ActivityC:registerState(data)
    if 0 == data.code then
        GameEventDispatch.instance:event("MsgTipContent", "签到成功")


    else
        if 1 == data.code then
            GameEventDispatch.instance:event("MsgTipContent", "请勿重复签到")


        else
            if 2 == data.code then
                GameEventDispatch.instance:event("MsgTipContent", "签到状态错误")


            else
                GameTools:dealCode(data.code)

            end
        end
    end

end
function ActivityC:endAcceptReward(re)
    if 0 == re.code then
        --36014 服务端也没有了
        --WebSocketManager.instance:send(36014, {})


    else
        if 1 == re.code then
            GameEventDispatch.instance:event("MsgTipContent", "活动未开启")


        else
            if 3 == re.code then
                GameEventDispatch.instance:event("MsgTipContent", "已领奖或未中奖")


            else
                if 4 == re.code then
                    GameEventDispatch.instance:event("MsgTipContent", "活动未结束")


                else
                    if 2 == re.code then
                        GameEventDispatch.instance:event("MsgTipContent", "无人中奖")


                    else
                        GameTools:dealCode(re.code)

                    end
                end
            end
        end
    end

end
function ActivityC:endSyncJackpotInfo(re)
    ActivityM.instance.is_reward = re['is_reward']
    ActivityM.instance.bet_teams = re['teams']
    ActivityM.instance.worldcup_info = re['worldcup_info']
    ActivityM.instance.is_receive = re['is_receive']
    GameEventDispatch.instance:event("OnSyncBetData")

end
function ActivityC:synAirBalloonRankData(res)
    ActivityM.instance.airBalloonRank = res

end
function ActivityC:synAirBalloonAccountData(res)
    if res.code == 0 then
        GameEventDispatch.instance:event("CloseAccount", res)


    else
        if res.code == 1 then
            GameEventDispatch.instance:event("MsgTipContent", "结算分错误")


        else
            if res.code == 2 then
                GameEventDispatch.instance:event("MsgTipContent", "有未结算的分")


            else
                if res.code == 3 then
                    GameEventDispatch.instance:event("MsgTipContent", "有未结算的分")


                else
                    if res.code == 10 then
                        GameEventDispatch.instance:event("MsgTipContent", "其他错误")


                    else
                        GameTools:dealCode(res.code)

                    end
                end
            end
        end
    end

end
function ActivityC:synAirBalloonGameData(res)
    if res.code == 0 then


    else
        if res.code == 1 then
            GameEventDispatch.instance:event("MsgTipContent", "只能扎6个")


        else
            if res.code == 2 then
                GameEventDispatch.instance:event("MsgTipContent", "活动数据错误")


            else
                if res.code == 3 then
                    GameEventDispatch.instance:event("MsgTipContent", "活动已结束")


                else
                    if res.code == 4 then
                        GameEventDispatch.instance:event("MsgTipContent", "活动币不足")


                    else
                        if res.code == 10 then
                            GameEventDispatch.instance:event("MsgTipContent", "参数错误")


                        else
                            GameTools:dealCode(res.code)

                        end
                    end
                end
            end
        end
    end

end
function ActivityC:synAirBalloonGameState(res)
    ActivityM.instance:setHitBalloonArr(res)
end 