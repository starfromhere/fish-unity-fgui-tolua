---@class ActivityM
---@field public instance ActivityM
ActivityM = class("ActivityM")
function ActivityM:ctor()
    self.activity_data = {}
    self.activity_status = {}
    self.is_in_worldcup_lottery = false
    self.is_reward = nil
    self.is_receive = nil
    self.bet_teams = {}
    self.worldcup_info = {}
    self._loginShowActivityPannel = false
    self._loginNew = false
    self._activityMoneyConfig = nil
    self._activityPictureConfig = nil
    self._activityExplainConfig = nil
    self._firstRankList = { score = 0, rank = 0, rank_arr = {} }
    self._secondRankList = { score = 0, rank = 0, rank_arr = {} }
    self._thirdRankList = { score = 0, rank = 0, rank_arr = {} }
    self._airBalloonRank = nil
    self._rankRewards = nil
    self.betData = {}
    self.actRegister_data = nil
    self.actRegister_time = nil
    self.actCurrency_data = nil
    self.sub_activity_status = {}
    self.exchange_times = {}
    self.is_exchange = nil
    self.cdkeys_id = nil
    self.hitBalloonArr_81 = nil
    self.hitBalloonArr_82 = nil
    self.hitBalloonArr_83 = nil
    self.gainCoin = 0
    self.redState = 1
    self.taskRequire = 0
    self.taskMoney = {}
    self.maxTaskId = -1
    self.lowRequireCoin = 0
    self.lowMoney = {}
    self.rewardTimes = { 1, 1, 1, 1 }
    self._countDownTimes = 10
    self._countDownArr = {}
    self._isRefresh = false
end

function ActivityM:countDownLoop()
    self._isRefresh = false
    for i, v in pairs(self._countDownArr) do
        if v > 0 then
            self._countDownArr[i] = self._countDownArr[i] - 1
            self._isRefresh = true
        end
    end

    if self._isRefresh then
        GameEventDispatch.instance:event(GameEvent.RefreshVirtualList)
    end
end

function ActivityM:exchangeConversion(id, num)
    local endNum = num
    if id == 60 then
        endNum = string.format("%.2f", (num / 100))
    end
    return endNum
end

function ActivityM:isShowRewRebate()
    return self:commonActivityOnOff(GameConst.activity_common_rew);
end

function ActivityM:isShowSinceRebate()
    return self:commonActivityOnOff(GameConst.activity_common_since)
end

function ActivityM:_getCommonActivityConfig(module)
    if self:_getActivityData(GameConst.activity_common) then
        local typeArr = self:_getActivityData(GameConst.activity_common)["sub_activity"]
        if typeArr then
            for i, _ in ipairs(typeArr) do
                if typeArr[i]["id"] == module then
                    return typeArr[i]["config"]
                end
            end
        end
    end
    return nil
end

function ActivityM:getRewardPageExtra(id)
    if self:_getCommonActivityConfig(GameConst.activity_common_rew) then
        return self:_getCommonActivityConfig(GameConst.activity_common_rew)["lottery_extra"][id]
    end
    return nil
end

function ActivityM:actCurrency(coin_type)
    for i, v in ipairs(self.actCurrency_data) do
        if self.actCurrency_data[i].coin_type == coin_type then
            return self.actCurrency_data[i].value
        end
    end
    return 0
end

function ActivityM:getGoodsNum(id)
    if id == GameConst.currency_coin then
        return RoleInfoM.instance:getCoin()
    elseif id == GameConst.currency_diamond then
        return RoleInfoM.instance:getDiamond()
    else
        return ActivityM.instance:actCurrency(id)
    end
end

function ActivityM:activeImg()
    local active_img = {}
    if self.isShowShopRebate then
        table.insert(active_img, { img = { skin = self._activityExplainConfig[0] }, view = "shop" })
    end
    if self.isShowShareRebate then
        if WxC:isInMiniGame() then
            table.insert(active_img, { img = { skin = self._activityExplainConfig[1] }, view = "Share" })
        end
    end
    if self.isShowDayMatchRebate then
        table.insert(active_img, { img = { skin = self._activityExplainConfig[2] }, view = "Match" })

    end
    if self.isShowRewRebate then
        table.insert(active_img, { img = { skin = self._activityExplainConfig[3] }, view = "Lottery" })

    end
    if self.isShowRedTask then
        table.insert(active_img, { img = { skin = self._activityExplainConfig[5] }, view = "RedTask" })

    end
    if self.isShowMainRank then
        table.insert(active_img, { img = { skin = self._activityExplainConfig[6] }, view = "Rank" })

    end
    return active_img
end

function ActivityM:_getActivityData(activity_type)
    if self.activity_data == nil then
        return nil
    end
    for i, v in pairs(self.activity_data) do
        if self.activity_data[i]["type"] == activity_type then
            return self.activity_data[i]
        end
    end
    return nil
end

function ActivityM:getActivityData(activity_type)
    if GameConst.activity_bonus == activity_type then
        return self:_getActivityData(GameConst.activity_bonus)
    elseif GameConst.activity_bomb == activity_type then
        return self:_getActivityData(GameConst.activity_bomb)
    elseif GameConst.activity_worldcup == activity_type then
        return self:_getActivityData(GameConst.activity_worldcup)
    elseif GameConst.activity_common == activity_type then
        return self:_getActivityData(GameConst.activity_common)
    elseif GameConst.activity_rank == activity_type then
        return self:_getActivityData(GameConst.activity_rank)
    elseif GameConst.activity_red_pack == activity_type then
        return self:_getActivityData(GameConst.activity_red_pack)
    else
        return nil
    end
end

function ActivityM:worldCupActivityBatteryCanBuy()
    return ActivityM.instance:activityIsExtraTime(GameConst.activity_worldcup)
end

function ActivityM:getShopExtraArrByShopId(commodity_id, activity_type)
    local activityData = self:getActivityData(activity_type)
    if not activityData then
        return nil
    end

    if activityData then
        local shop_extra;
        if activity_type == GameConst.activity_common then
            shop_extra = self:_getCommonActivityConfig(1)["shop_buy_extra"]
        else
            shop_extra = activityData["config"]["shop_extra"]
        end

        if not shop_extra then
            return nil
        end

        local bomb_gift = shop_extra[tostring(commodity_id)]
        if bomb_gift then
            return bomb_gift
        else
            return nil
        end
    else
        return nil
    end
end

function ActivityM:getActivityExtraTime(activity_type)
    local activityData = self:getActivityData(activity_type)
    if activityData then
        local finish_time = activityData["extra_time"]
        return finish_time
    else
        return 0
    end
end

function ActivityM:getActivityEndTime(activity_type)
    local activityData = self:getActivityData(activity_type)
    if activityData then
        local finish_time = activityData["finish_time"]
        return finish_time
    else
        return 0
    end
end

function ActivityM:showActivityIcon(activity_type)
    local activityData = self:getActivityData(activity_type)
    if not activityData then
        return false
    end

    local activity_id = activityData.id
    local activity_status_data = self.activity_status[tostring(activity_id)]
    if activity_status_data then
        return activity_status_data[0] and not activity_status_data[2]
    else
        return false
    end
end

function ActivityM:getWinTeamId()
    local winTeamId = ActivityM.instance.worldcup_info['win_team_id']
    if winTeamId then
        return winTeamId
    end
    return 0
end

function ActivityM:worldCupRewardCanAccept()
    local winTeamId = self:getWinTeamId()
    return winTeamId > 0

end

function ActivityM:activityIsActive(activity_type)
    local activityData = self:getActivityData(activity_type)
    if not activityData then
        return false
    end
    local activity_id = activityData.id
    local activity_status_data = self.activity_status[tostring(activity_id)]
    if activity_status_data then
        return activity_status_data[0] and not activity_status_data[1]
    else
        return false
    end
end

function ActivityM:activityIsEnd(activity_type)
    local activityData = self:getActivityData(activity_type)
    if not activityData then
        return false
    end

    local activity_id = activityData.id
    local activity_status_data = self.activity_status[tostring(activity_id)]
    if activity_status_data then
        return activity_status_data[1]
    else
        return false
    end
end

function ActivityM:activityIsExtraTime(activity_type)
    local activityData = self:getActivityData(activity_type)
    if not activityData then
        return false
    end

    local activity_id = activityData.id
    local activity_status_data = self.activity_status[tostring(activity_id)]
    if activity_status_data then
        return activity_status_data[1] and not activity_status_data[2]
    else
        return false
    end
end

function ActivityM:activityIsDown(activity_type)
    local activityData = self:getActivityData(activity_type)
    if not activityData then
        return false
    end

    local activity_id = activityData.id
    local activity_status_data = self.activity_status[tostring(activity_id)]
    if activity_status_data then
        return activity_status_data[2]
    else
        return false
    end
end

---@param activity_type GameConst
function ActivityM:activityIsProceed(activity_type)
    local activityData = self:getActivityData(activity_type)
    if not activityData then
        return false
    end

    local activity_id = activityData.id
    local activity_status_data = self.activity_status[tostring(activity_id)]
    if activity_status_data then
        local result=activity_status_data[1] and not activity_status_data[3]
        return result
    else
        return false
    end
end
function ActivityM:commonActivityOnOff(module)
    local activityData = self:getActivityData(GameConst.activity_common)
    if activityData then
        local activity_id = activityData.id
        local sub_activity_status_data = self.sub_activity_status[tostring(activity_id)]
        if sub_activity_status_data then
            local isStart = sub_activity_status_data[module]
            if isStart then
                return true
            end
        end
    end
    return false
end

function ActivityM:getHitBalloonArr(grade)
    if grade == 1 then
        return self.hitBalloonArr_81
    elseif grade == 2 then
        return self.hitBalloonArr_82
    elseif grade == 3 then
        return self.hitBalloonArr_83
    else
        return nil
    end
end

function ActivityM:setHitBalloonArr(res)
    if res[GameConst.activity_currency_one].length > 0 then
        self.hitBalloonArr_81 = res[GameConst.activity_currency_one]
    else
        self.hitBalloonArr_81 = {}
    end
    if res[GameConst.activity_currency_two].length > 0 then
        self.hitBalloonArr_82 = res[GameConst.activity_currency_two]
    else
        self.hitBalloonArr_82 = {}
    end
    if res[GameConst.activity_currency_three].length > 0 then
        self.hitBalloonArr_83 = res[GameConst.activity_currency_three]
    else
        self.hitBalloonArr_83 = {}
    end
end

function ActivityM:getChooseFlyRankList(grade)
    if grade == 1 then
        return self._firstRankList
    elseif grade == 2 then
        return self._secondRankList
    elseif grade == 3 then
        return self._thirdRankList
    else
        return nil
    end
end

function ActivityM:unifiedBalloonRanking(rank)
    local str
    if rank == 0 then
        str = "暂未排名"
    elseif rank > 100 then
        str = "排名100之外"
    else
        str = "" .. rank
    end
    return str
end

---单个产出系统是否显示
---商场返利（充值）
function ActivityM:isShowShopRebate()
    return self:commonActivityOnOff(FightConst.activity_common_shop);
end


---公共活动中的 主界面排行榜是否开启发送兑换券
---@return boolean
function ActivityM:isShowMainRank()
    return self:commonActivityOnOff(GameConst.activity_common_main_rank);
end

---公共活动中的 喇叭活动是否在进行中
---@return boolean
function ActivityM:isShowRedTask()
    return self:commonActivityOnOff(GameConst.activity_common_red_task)
end


---喇叭大活动是否在进行中
---@return boolean
function ActivityM:redPackTicketContinueTime()
    return self:activityIsProceed(GameConst.activity_red_pack);
end

function ActivityM:getBalloonConsume(consumeType)
    return ActivityM.instance:_getCommonActivityConfig(GameConst.activity_common_rankactivity)["consume"][tostring(consumeType)]
end

function ActivityM:setCommonImage()
    if self:_getActivityData(GameConst.activity_common) then
        if self:_getActivityData(GameConst.activity_common)["config"] and self:_getActivityData(GameConst.activity_common)["config"]["upload_img"] then
            local typeArr = self:_getActivityData(GameConst.activity_common)["config"]["upload_img"]
            self._activityMoneyConfig = {
                [81] = typeArr["volume_img_1"],
                [82] = typeArr["volume_img_2"],
                [83] = typeArr["volume_img_3"]
            }
            self._activityPictureConfig = {
                typeArr["items_img_1"],
                typeArr["items_img_2"],
                typeArr["items_img_3"],
                typeArr["items_img_4"],
                typeArr["items_img_5"],
                typeArr["items_img_6"]
            }
            self._activityExplainConfig = {
                typeArr["propaganda_img_1"],
                typeArr["propaganda_img_2"],
                typeArr["propaganda_img_3"],
                typeArr["propaganda_img_4"],
                typeArr["propaganda_img_5"],
                typeArr["propaganda_img_6"],
                typeArr["propaganda_img_7"]
            }
            cfg_goods.instance("81").icon = self._activityMoneyConfig[81]
            cfg_goods.instance("82").icon = self._activityMoneyConfig[82]
            cfg_goods.instance("83").icon = self._activityMoneyConfig[83]
        else
            self._activityMoneyConfig = {}
            self._activityPictureConfig = {}
            self._activityExplainConfig = {}
        end
    else
        self._activityMoneyConfig = {}
        self._activityPictureConfig = {}
        self._activityExplainConfig = {}
    end
end
        