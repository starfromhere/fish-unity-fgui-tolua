---@class MatchC
---@field public instance MatchC
MatchC = class("MatchC")
function MatchC:ctor()
    GameEventDispatch.instance:on(tostring(12052), self, self.end_daily_sign)
    GameEventDispatch.instance:on(tostring(12053), self, self.end_snatch_sign)
    GameEventDispatch.instance:on(tostring(35000), self, self.daily_match_settle)
    GameEventDispatch.instance:on(tostring(35001), self, self.challenge_match_settle)
    GameEventDispatch.instance:on(tostring(35004), self, self.end_accept_match_reward)
    GameEventDispatch.instance:on(tostring(35006), self, self.end_accept_daily_match_reward)

    GameEventDispatch.instance:on(tostring(12100), self, self.synRoomHostMsg)
    GameEventDispatch.instance:on(tostring(12102), self, self.synPlayersPrepareState)
    GameEventDispatch.instance:on(tostring(12103), self, self.synRoomTManMsg)
    GameEventDispatch.instance:on(tostring(12105), self, self.synMatchGameStart)
    GameEventDispatch.instance:on(tostring(12108), self, self.synMatchGameRoomNum)
    GameEventDispatch.instance:on(tostring(12109), self, self.synMatchGameResultMsg)
    GameEventDispatch.instance:on(tostring(12113), self, self.synMatchGameAgainMsg)
    GameEventDispatch.instance:on(tostring(12107), self, self.synMatchGamePalyerTMsg)
    GameEventDispatch.instance:on(tostring(12111), self, self.findMatchGameDataFromRoomNum)
end

function MatchC:findMatchGameDataFromRoomNum(res)
    if res.contest_id then
        if res.contest_id == -1 then
            LoginM.instance.roomId = -1
            --GameEventDispatch.instance:event("MsgTipContent","请输入正确的房间号")
            GameTip.showTip("请输入正确的房间号")
        else
            MatchM.instance.findRoomData = {
                gameId = res.contest_id, costId = res.consume_goods_id,
                costNum = res.consume_goods_num, isFree = res.is_free }
            GameEventDispatch.instance:event(GameEvent.SynFindMatchGameData)
        end
    end
end

function MatchC:synMatchGamePalyerTMsg()
    if MatchM.instance:isMatchSettleShow() then
        UIManager:ClosePanel("MatchSettlePage", nil, false)
    end
    --GameEventDispatch.instance:event("MsgTipContent","您已被踢出房间")
    GameTip.showTip("您已被踢出房间")
end

function MatchC:synMatchGameAgainMsg(res)
    if res.code == 0 then
        --GameEventDispatch.instance:event("MatchingGameAgainStart")
        Log.debug(Fishery.instance.matchPlayerNum)
        if Fishery.instance.matchPlayerNum == 1 then
            Fishery.instance.fsmMatch:changeState(MatchStateWaitJoin)
        elseif Fishery.instance.matchPlayerNum > 1 then
            if Fishery.instance.matchPreparePlayerNum == Fishery.instance.matchPlayerNum - 1 then
                Fishery.instance.fsmMatch:changeState(MatchStateWaitStart)
            else
                Fishery.instance.fsmMatch:changeState(MatchStateWaitPrepare)
            end
        end

        MatchM:initMatchingGameData(true)
    elseif res.code == 1 then
        --GameEventDispatch.instance:event("MsgTipContent","没有此类型比赛")
        GameTip.showTip("没有此类型比赛")
    elseif res.code == 2 then
        --GameEventDispatch.instance:event("MsgTipContent","没有比赛信息")
        GameTip.showTip("没有比赛信息")
    elseif res.code == 3 then
        GameTip.showTip("不在比赛时间内")
        --GameEventDispatch.instance:event("MsgTipContent","不在比赛时间内")
    elseif res.code == 4 then
        --GameEventDispatch.instance:event("MsgTipContent","道具不足")
        GameTip.showTip("道具不足")
    else
        GameTools:dealCode(res.code)
    end
end

function MatchC:synMatchGameResultMsg(res)
    if not is_empty(res.rank) then
        res['type'] = 'match'
        MatchM.instance.resultMsg = res
        UIManager:LoadView("MatchSettlePage", res)
        GameEventDispatch.instance:event(GameEvent.MatchingSynResultMsg)
    end
end

function MatchC:synMatchGameRoomNum(res)

    Fishery.instance:changeMatchPlayerNum(res.playerNum)
    local seat = SeatRouter.instance:getSeatById(res.seat_id)
    if seat then
        seat.fsm:changeState(StateSeatExit)
    end
    --if res.playerNum then
    --	if res.playerNum ~= MatchM.instance.theRoomNumber then
    --		MatchM.instance.countDownTime = -1
    --		MatchM.instance.tManSeat = -1
    --	end
    --	MatchM.instance.theRoomNumber = res.playerNum
    --	GameEventDispatch.instance:event("MatchingGameSynState")
    --end
end

function MatchC:synMatchGameStart(res)
    if res.code == 0 then
        MatchM.instance.isMatchStart = 1
        if Fishery.instance.sceneId == 7 then
            Fishery.instance:startMatchGame()
        end
    elseif res.code == 1 then
        GameTip.showTip("不在有效比赛时间内")
    elseif res.code == 2 then
        GameTip.showTip("不是房主不能开始比赛")
    elseif res.code == 3 then
        GameTip.showTip("没有此比赛项目")
    elseif res.code == 4 then
        GameTip.showTip("没有比赛信息")
    elseif res.code == 10 then
        GameTip.showTip("其他比赛错误")
    elseif res.code == 11 then
        GameTip.showTip("有玩家未准备")
    elseif res.code == 12 then
        GameTip.showTip("一个人不能进行游戏")
    else
        GameTools:dealCode(res.code)
    end
end

function MatchC:synRoomTManMsg(res)
    Fishery.instance:matchAllPrepare(res.seat_id, res.end_time)
    --MatchM.instance.startTime = true
    --MatchM.instance.tManSeat = SeatRouter.instance:getShowSeatId(res.seat_id)
    MatchM.instance.countDownTime = res.end_time
    --GameEventDispatch.instance:event("MatchingGameTManMsg")
end

function MatchC:synPlayersPrepareState(res)
    if Fishery.instance.fsmMatch:isInState(MatchStateStart) then
    else
        if Fishery.instance.sceneId == 7 then
            Fishery.instance:changePrepareStatus(res.prepare_status)
            MatchM.instance:setPrepareState(res.prepare_status)
        end
    end
    --if res.prepare_status then
    --	MatchM.instance:setPrepareState(res.prepare_status)
    --	GameEventDispatch.instance:event("MatchingGameSynState")
    --end
end

---@param res S2C_12100
function MatchC:synRoomHostMsg(res)

    Fishery.instance.matchHostSeatId = res.master_seat_id
    if Fishery.instance.sceneId == 7 then
        Fishery.instance:startMatch()
    end

    --
    --if res.master_seat_id then
    --
    --    if res.master_seat_id ~= MatchM.instance.hostSeat then
    --        MatchM.instance.startTime = false
    --    end
    --    MatchM.instance.hostSeat = res.master_seat_id
    --    GameEventDispatch.instance:event("MatchingGameSynState")
    --end
end

function MatchC:end_snatch_sign(data)
    if 0 == data.code then
        GameEventDispatch.instance:event("EndSnatchMatchSign")
    end
end

function MatchC:end_accept_daily_match_reward(data)
    if 0 == data.code then
        GameEventDispatch.instance:event("RewardTip", { data.reward_item_ids, data.reward_item_nums })
        GameEventDispatch.instance:event(GameEvent.EndAcceptDailyMatchReward)
    else
        Log.warning("领取比赛错误")
        Log.debug(encode(data))
    end
end

function MatchC:end_accept_match_reward(data)
    if 0 == data.code then
        local reward_item_ids = {}
        local reward_item_nums = {}
        for i = 1, table.len(data.award) , 2 do
            reward_item_ids[table.len(reward_item_ids) + 1] = data.award[i]
            reward_item_nums[table.len(reward_item_nums) + 1] = data.award[i + 1]
        end
        GameEventDispatch.instance:event(GameEvent.EndAcceptChallengeMatchReward)
        GameEventDispatch.instance:Event(GameEvent.RewardTip, { reward_item_ids, reward_item_nums })
    else
        GameTools:dealCode(data.code)
    end
end

function MatchC:daily_match_settle(data)
    data['type'] = 'daily'
    UIManager:LoadView("MatchSettlePage", data)
end

function MatchC:challenge_match_settle(data)
    data['type'] = 'challenge'
    UIManager:LoadView("MatchSettlePage", data)
end

function MatchC:end_daily_sign(data)
    if 0 == data.code then
        if data.roomNumber then
            MatchM.instance.roomName = data.roomNumber
            GameEventDispatch.instance:event(GameEvent.MatchingSynRoomData)
        end
        GameEventDispatch.instance:event(GameEvent.EndDailyMatchSign)
    else
        GameTools:dealCode(data.code)
    end
end
        