---@class RoleInfoM
---@field public instance RoleInfoM
RoleInfoM = class("RoleInfoM")

function RoleInfoM:ctor()
    self.
    _name = nil
    self._level = 0
    self._vip = 0
    self._vip_exp = 0
    self._coin = 0
    self._diamond = 0
    self._exp = 0
    self._fcount = 0
    self._fcoin = 0
    self._battery = 0
    self._cskin = 0
    self._skins = nil
    self._timesSkins = {}
    self._goods = {}
    self.vip_buy = nil
    self.purchased_items = nil
    self.task_new = {}
    self.task_daily = { f = {}, good = {} }
    self.task_daily_ids = nil
    self.create_time = 0
    self.day_index = 0
    self.charge_times = 0
    self.charge_total = 0
    self.first_charge_reward_accepted = 0
    self.firstSubscription = false
    self.login_days = 0
    self._sign_in_day = 0
    self._sign_award_get = 0
    self._skill_res_tip = 0
    self._award_score = 0
    self._award_value = 0
    self.red_points = 0
    self.avatar = nil
    self._cost_coin = 0
    self._exchange = 0
    self._bcoin = 0
    self._timeStamp = 0
    self.activity_ticket = 0
    self._lastSkinID = 0

    --@TODO 银行相关
    self.is_set_bank_password = 0
    self.is_bind_tel = 0
    self.tel = nil
    self.bind_ticket = nil
    self.is_bind = nil
    self.jjhNumber = nil
    self.jjhId = nil
    self.is_test_user = nil--是否为app测试玩家
    self.bank_gold = 0

    self.mini_balance = 0
    self._contest_coin = 0
    self._contest_score = 0
    self.worldcup_battery_accepted = 0
    self.worldcup_coin = 0
    self.guide_status = {}
    self._SyncSwish = 1
    self.short_pf = nil
    self.curDay = 0
    self.total = 0
    self.receive = {}
    self.pay_accept_ids = {}
    self.level_accept_ids = {}
    self.pay_expire = 0
    self.grade_expire = 0
    self.coin_rate = nil
    self.chance_rate = nil
    self.coin_rate_buy = nil
    self.chance_rate_buy = nil

    self.expired_time = nil
    self.subscribe_tpl = {}
    self.time_skin_data = {}
    self.month_card = {}

    --@TODO 新手福利相关
    self._taskActStatus = {};--新手福利奖励领取状态
    self._lotteryEng = {};--新手福利抽奖数据
    self._refreshTaskArr = {};--新手任务
    self._lotteryAwardData = {};--新手福利抽奖奖励数组
    self._lotteryReturnData = {};--新手福利抽奖返回数据
end

function RoleInfoM:canDoubelCoin()
    return self.coin_rate_buy == 1 or self._battery >= cfg_global.instance(1).double_coin_battery
end

function RoleInfoM:canDoubelChance()
    return self.chance_rate_buy == 1 or self._battery >= cfg_global.instance(1).double_chance_battery
end

function RoleInfoM:isConsumeEnough(conId, conNum)
    if conId == GameConst.currency_coin then
        return self._coin >= conNum
    end

    if conId == GameConst.currency_diamond then
        return self._diamond >= conNum
    end

    for i = 1, i <= #self._goods do
        if self._goods[i].i == conId then
            if self._goods[i].n >= conNum then
                return true
            end
            return false
        end
        i = i + 1
    end
    return false
end

function RoleInfoM:subscribeState(type)

    for i = 1, #self.subscribe_tp do
        if self.subscribe_tpl[i].id and self.subscribe_tpl[i].id == type then
            return self.subscribe_tpl[i].is_remember
        end
        i = i + 1
    end
    return 0
end

function RoleInfoM:subsState(type)

    for i = 1, #self.subscribe_tpl do
        if self.subscribe_tpl[i].id and self.subscribe_tpl[i].id == type then
            return self.subscribe_tpl[i].status == "accept"
        end
        i = i + 1
    end
    return false
end

function RoleInfoM:calcRed()
    local A = 0
    local B = 0
    local C = 0
    local arr_red
    local config_rech = ConfigManager.items("cfg_rech_award")
    local config_up = ConfigManager.items("cfg_upgradeRed")
    local arr_re = RoleInfoM.instance.receive
    local arr_pay = RoleInfoM.instance.pay_accept_ids
    local arr_lv = RoleInfoM.instance.level_accept_ids

    local indexi
    for i = 1, #config_rech do
        if self.total < config_rech[i].rechSum then
            break
        end
        i = i + 1
        indexi = i
    end

    local indexj
    for j = 1, #config_up do
        if self._level < config_up[j].level then
            break
        end
        j = j + 1
        indexj = j
    end

    if arr_re.length < self.curDay then
        A = 1
    else
        A = 0
    end

    if arr_pay.length < indexi then
        B = 1
    else
        B = 0
    end

    if arr_lv.length < indexj then
        C = 1
    else
        C = 0
    end

    if RoleInfoM.instance.short_pf ~= 2 then
        arr_red = { A, B, C }
    else
        arr_red = { A, B }
    end
    return arr_red
end

function RoleInfoM:getTimeStamp()
    return self._timeStamp

end
function RoleInfoM:setTimeStamp(stamp)
    self._timeStamp = stamp

end
function RoleInfoM:getExchange()
    if type(self._exchange) == "table" then
        return self._exchange[1] / 100
    else
        return self._exchange / 100
    end
end

function RoleInfoM:setExchange(exchange)
    self._exchange = exchange

end
function RoleInfoM:getCostCoin()
    return self._cost_coin

end
function RoleInfoM:setCostCoin(value)
    self._cost_coin = value

end

function RoleInfoM:isSkinExit(skinId)
    return table.indexOf(self._skins, skinId) > -1
end
function RoleInfoM:setContestCoin(value)
    self._contest_coin = value
end

function RoleInfoM:getContestCoin()
    return self._contest_coin

end
function RoleInfoM:setContestScore(value)
    self._contest_score = value

end
function RoleInfoM:getContestScore()
    return self._contest_score

end
function RoleInfoM:setAwardScore(score)
    self._award_score = score

end
function RoleInfoM:getAwardScore()
    return self._award_score

end
function RoleInfoM:getAwardValue()
    return self._award_value
end

function RoleInfoM:setAwardValue(value)
    self._award_value = value

end
function RoleInfoM:getRedPoints()
    return self.red_points

end
function RoleInfoM:setRedPoints(value)
    self.red_points = value

end
function RoleInfoM:getLoginDays()
    return self.login_days

end
function RoleInfoM:setLoginDays(value)
    self.login_days = value

end
function RoleInfoM:getVipBuy()
    return self.vip_buy

end
function RoleInfoM:setVipBuy(value)
    self.vip_buy = value

end
function RoleInfoM:getMonthCard()
    return self.month_card

end
function RoleInfoM:setMonthCard(value)
    self.month_card = value

end
function RoleInfoM:setChargeTotal(value)
    self.charge_total = value

end
function RoleInfoM:getChargeTotal()
    return self.charge_total

end
function RoleInfoM:setChargeTimes(value)
    self.charge_times = value

end
function RoleInfoM:getChargeTimes()
    return self.charge_times

end
function RoleInfoM:setFirstChargeRewardAccepted(value)
    self.first_charge_reward_accepted = value

end
function RoleInfoM:getFirstChargeRewardAccepted()
    return self.first_charge_reward_accepted

end
function RoleInfoM:setFirstSubscription(value)
    self.firstSubscription = value

end
function RoleInfoM:getFirstSubscription()
    return self.firstSubscription

end
function RoleInfoM:setDayIndex(value)
    self.day_index = value

end
function RoleInfoM:getDayIndex()
    return self.day_index

end
function RoleInfoM:getTaskNew()
    return self.task_new

end
function RoleInfoM:setTaskNew(value)
    self.task_new = value

end
function RoleInfoM:updateTaskNew(value)
    for i, key in ipairs(value) do
        self.task_new[key] = value[key]
    end
end

function RoleInfoM:getTaskDaily()
    return self.task_daily

end
function RoleInfoM:setTaskDaily(value)
    self.task_daily = value

end
function RoleInfoM:updateTaskDaily(value)
    for i, key in ipairs(value) do
        if key == "f" then
            for k, v in ipairs(value.f) do
                self.task_daily.f[k] = value.f[k]
            end
        else
            if key == "goods" then
                for k, v in ipairs(value.goods) do
                    self.task_daily.goods[k] = value.goods[v]
                end
            else
                self.task_daily[key] = value[key]
            end
        end
    end
end
function RoleInfoM:getTaskDailyIds()
    if table.isArrayTable(self.task_daily_ids) then
        return self.task_daily_ids
    else
        return {}
    end

end
function RoleInfoM:setTaskDailyIds(value)
    self.task_daily_ids = value

end
function RoleInfoM:getPurchasedItems()
    return self.purchased_items

end
function RoleInfoM:setPurchasedItems(value)
    self.purchased_items = value

end
function RoleInfoM:setProfileInfo(profileData)
    self._name = profileData.name
    self._level = profileData.level
    self._vip = profileData.vip
    self._vip_exp = profileData.vip_exp
    self._coin = profileData.coin
    self._exp = profileData.exp
    self._fcount = profileData.fish_coin.count
    self._fcoin = profileData.fish_coin.value
    self._cskin = profileData.cskin
    self._battery = profileData.battery
    self._skins = profileData.skins
    self._diamond = profileData.diamond
    self._goods = profileData.goods
    self._award_score = profileData.award_score
    self.purchased_items = profileData.purchased_items
    self.vip_buy = profileData.vip_buy
    self.task_new = profileData.task_new
    self.task_daily = profileData.task_daily
    self.create_time = profileData.create_time
    self.day_index = profileData.day_index
    self.task_daily_ids = profileData.task_daily_ids
    self.charge_total = profileData.charge_total
    self.charge_times = profileData.charge_times
    self.first_charge_reward_accepted = profileData.first_charge_reward_accepted
    self.red_points = profileData.red_points
    self.month_card = profileData.month_card
    self.login_days = profileData.login_days
    self._skill_res_tip = profileData.skill_res_tip
    self.avatar = profileData.avatar
    self._exchange = profileData.exchange
    self._bcoin = profileData.bcoin
    self.activity_ticket = profileData.at_coin
    self.is_set_bank_password = profileData.is_set_bank_password
    self.bank_gold = profileData.bank_gold
    self.worldcup_battery_accepted = profileData.worldcup_battery_accepted
    self.worldcup_coin = profileData.worldcup_coin
    self.is_bind_tel = profileData.is_bind_tel
    self.tel = profileData.tel
    self.guide_status = profileData.guide_status
end
function RoleInfoM:setAvatar(avatar)
    self.avatar = avatar
    GameEventDispatch.instance:Event(GameEvent.UpdateProfile)
end
function RoleInfoM:getAvatar()
    return self.avatar
end
function RoleInfoM:setSkillResTip(value)
    self._skill_res_tip = value
end
function RoleInfoM:isSkillResTip()
    return self._skill_res_tip == 1
end
function RoleInfoM:setCreateTime(value)
    self.create_time = value
end
function RoleInfoM:getCreateTime()
    return self.create_time
end
function RoleInfoM:setName(name)
    self._name = name
    GameEventDispatch.instance:Event(GameEvent.UpdateProfile)
end
function RoleInfoM:getName()
    return self._name
end
function RoleInfoM:setLevel(curLevel)
    self._level = curLevel
end
function RoleInfoM:getLevel()
    return self._level
end
function RoleInfoM:setVipExp(value)
    self._vip_exp = value
end
function RoleInfoM:getVipExp()
    return self._vip_exp
end
function RoleInfoM:setVip(value)
    self._vip = value
end
function RoleInfoM:getVip()
    return self._vip
end
function RoleInfoM:getCoin()
    return self._coin
end
function RoleInfoM:setCoin(num)
    self._coin = num
end
function RoleInfoM:getBankCoin()
    return self.bank_gold
end
function RoleInfoM:getBindCoin()
    return self._bcoin
end
function RoleInfoM:setBindCoin(num)
    self._bcoin = num
end
function RoleInfoM:getDiamond()
    return self._diamond
end
function RoleInfoM:setDiamond(num)
    self._diamond = num
end
function RoleInfoM:getExp()
    return self._exp
end
function RoleInfoM:setExp(value)
    self._exp = value
end
function RoleInfoM:getFcount()
    return self._fcount
end
function RoleInfoM:setFcount(count)
    self._fcount = count
end
function RoleInfoM:getFcoin()
    return self._fcoin
end
function RoleInfoM:setFcoin(value)
    self._fcoin = value
end

function RoleInfoM:getBattery()
    return self._battery
end

function RoleInfoM:setBattery(value)
    Log.debug("battery data: ", value)
    self._battery = value
end
function RoleInfoM:getCurSkin()
    return self._cskin
end
function RoleInfoM:setCurSkin(skin)
    self._cskin = skin
end
function RoleInfoM:getSkins()
    return self._skins

end
function RoleInfoM:setSkins(value)
    self._skins = value
end

function RoleInfoM:isCurSkin(value)
    return self._cskin == value and true or false
end

function RoleInfoM:hasSkin(value)
    --以后皮肤免费用
    return true;
    --for i, v in pairs(self._skins) do
    --    if v == value then
    --        return true
    --    else
    --        local cfgSkin = cfg_battery_skin.instance(value)
    --        if cfgSkin and v == cfgSkin.toskin then
    --            return true
    --        end
    --    end
    --end
    --return false;
end

function RoleInfoM:init_time_skins(data)
    self.time_skin_data = {}
    self._timesSkins = {}
    if data and data ~= {} then
        for i = 1, #data,3 do
            local key = data[i]
            local remain_day = data[i + 1]
            if tonumber(remain_day) > 0 then
                table.insert(self._timesSkins,data[i])
            end
            self.time_skin_data[key] = {remain = data[i + 1] }
            i = i + 3
        end
    end
end

function RoleInfoM:getSkinRemainTime(skin_id)

    if table.indexOf(RoleInfoM.instance:getSkins(), skin_id) > -1 then
        return -1
    else
        local skin_data = self.time_skin_data[skin_id]
        if skin_data then
            local remain = skin_data['remain']
            if remain > 0 then
                return remain
            else
                return -1
            end
        else
            return -1
        end
    end
end

function RoleInfoM:getAllSkins()
    if #self._timesSkins <= 0 then
        return self._skins
    end

    local allskins = {}
    local skinId = 0
    for i = 1, #self._timesSkins do
        skinId = self._timesSkins[i]
        if not self:checkHaveSkin(skinId) then
            table.insert(allskins, skinId)
        end
    end
    allskins = table.concatTable(allskins, self._skins)
    return allskins
end

function RoleInfoM:findTypeId(_id)
    local popArr = ConfigManager.filter("cfg_goods")
    local skinId = 0
    for i = 1, #popArr do
        if popArr[i]['id'] == _id then
            skinId = popArr[i]['typeID']
            return skinId
        end
    end
    return nil
end

function RoleInfoM:checkHaveSkin(_id)
    local _playerArr = self._skins
    for i = 1, #_playerArr do
        if _playerArr[i] == _id then
            return true
        end
    end
    return false
end

function RoleInfoM:getGoods()
    return self._goods
end
function RoleInfoM:setGoods(value)
    self._goods = value
end
function RoleInfoM:getGoodsItemNum(goodsId)
    local goodsItem
    for i = 1, #self._goods do
        goodsItem = self._goods[i]
        if goodsItem.i == goodsId then
            return goodsItem.n
        end
    end
    return 0
end
function RoleInfoM:updateGoodsItem(goodsId, num)
    local goodsItem
        for i = 1, #self._goods do
            goodsItem = self._goods[i]
            if goodsItem.i == goodsId then
                goodsItem.n = num
                return
            end
        end
        goodsItem = {}
        goodsItem.i = goodsId
        goodsItem.n = num
        self._goods[#self._goods] = goodsItem

end

function RoleInfoM:updateSignInData(day, award_get)
    self._sign_in_day = day
    self._sign_award_get = award_get
end

function RoleInfoM:getSignInStatus(day)
    if day > self._sign_in_day then
        return GameConst.sign_in_not_reach
    end
    if day <= self._sign_award_get then
        return GameConst.sign_in_getted
    end
    return GameConst.sign_in_getting
end

function RoleInfoM:taskActStatus(value)
    if nil == value then
        return self._taskActStatus
    else
        self._taskActStatus = value;
    end
end

function RoleInfoM:lotteryReturnData(value)
    if nil == value then
        return self._lotteryReturnData
    else
        self._lotteryReturnData = value
    end
end

function RoleInfoM:lotteryEng(value)
    if nil == value then
        return self._lotteryEng
    else
        self._lotteryEng = value
    end
end

function RoleInfoM:refreshTaskArr(value)
    if nil == value then
        return self._refreshTaskArr
    else
        self._refreshTaskArr = value
    end
end

function RoleInfoM:lotteryAwardData(value)
    if nil == value then
        return self._lotteryAwardData
    else
        self._lotteryAwardData = value
    end
end

function RoleInfoM:haveValidMonthCard()

    if table.len(self.month_card) > 0 then
        for i, v in pairs(self.month_card) do
            if not v.is_expired then
                return true
            end
        end
    end

    return false
end

function RoleInfoM:getLastSkinID()
    return self._lastSkinID

end

function RoleInfoM:setLastSkinID(val)
    self._lastSkinID = val
end
        