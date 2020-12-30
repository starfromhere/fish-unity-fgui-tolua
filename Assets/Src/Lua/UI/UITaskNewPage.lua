---@class UITaskNewPage :UIDialogBase
local UITaskNewPage = class("UITaskNewPage", UIDialogBase)

function UITaskNewPage:init()
    self.packageName = "TaskNew"
    self.resName = "TaskNewPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.list1Data = nil;
    self.showOffTime = 0;
    self.showOffTargets = {};
    self.lotteryArr = {};
    self.intervalTime = Time.deltaTime * 4;
    self.curIndex = 0;
    self.pwdTotalTime = 0;
    self.curFrame = 0;
    self.curTime = 0;
    self.lotteryIndex = 0;
    self.lotteryEndPos = 0;
    self.lotteryCountDownTime = 0;
    self.energyCountDownTime = 0;
    self.list_day_data = nil;
    self.specialIds = { 400, 401, 402, 403 };

    self.list1Manage = nil
    self.listDayManage = nil

    self._deltaTime = 100
    self._curIndex = 50
    self.refreshDate = nil
end

--@override 注册事件监听
function UITaskNewPage:Register()
    self:AddRegister(GameEvent.TaskActivity, self, self.refresh_day_list);
    self:AddRegister(GameEvent.LotteryEng, self, self.lotteryEng);
    self:AddRegister(GameEvent.ReturnLottery, self, self.lotteryShow);
    self:AddRegister(GameEvent.RefreshTask, self, self.updateTask);
    self:AddRegister(GameEvent.RefreshLotteryArr, self, self.updateLotteryItem);
    self:AddRegister(GameEvent.RefreshTaskNew, self, self.refresh_day_list);
    self:AddRegister(GameEvent.FinishTaskNew, self, self.refresh_day_list);
end

function UITaskNewPage:StartGames(param)

    self:syncTask();
    self:initComponent();
    self:initView()
end

function UITaskNewPage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.list1 = self.contentView:GetChild("list1")
    self.list_day = self.contentView:GetChild("list_day")
    self.quitBtn = self.contentView:GetChild("quitBtn")

    self.countDown = self.contentView:GetChild("countDown")
    self.main_p = self.contentView:GetChild("main_p")
    self.taskBtn = self.contentView:GetChild("taskBtn")
    self.lotteryBtn = self.contentView:GetChild("lotteryBtn")
    self.taskBox = self.contentView:GetChild("taskBox")

    --抽奖
    self.lotteryBox = self.contentView:GetChild("lotteryBox")
    self.lotteryPro = self.contentView:GetChild("lotteryPro")
    self.lottery_num = self.contentView:GetChild("lottery_num")
    self.coinNum = self.contentView:GetChild("coinNum")
    self.ticketNum = self.contentView:GetChild("ticketNum")
    self.coinBtn = self.contentView:GetChild("coinBtn")
    self.ticketBtn = self.contentView:GetChild("ticketBtn")
    self.coinImg = self.contentView:GetChild("coinImg")
    self.ticketImg = self.contentView:GetChild("ticketImg")
    self.lotteryCountDown = self.contentView:GetChild("lotteryCountDown")
    self.energyCountDown = self.contentView:GetChild("energyCountDown")

    self.quitBtn:onClick(self.onQuitClick, self)
    self.taskBtn:onClick(self.clickTaskBtn, self)
    self.lotteryBtn:onClick(self.clickLotteryBtn, self)
end

function UITaskNewPage:initView()

    self:refresh_day_list()
    self:SortOutItems()
    self:clickTaskBtn()
    if RoleInfoM.instance:lotteryEng().clean then
        self.energyCountDownTime = RoleInfoM.instance:lotteryEng().clean
    else
        self.energyCountDownTime = 0
    end

    if RoleInfoM.instance:lotteryEng().countdown then
        self.lotteryCountDownTime = RoleInfoM.instance:lotteryEng().countdown;
    else
        self.lotteryCountDownTime = 0
    end

    --self:initEnergyTimeCountDown()
    self.refreshDate = GameTimer.loop(1000, self, self.initEnergyTimeCountDown)
end

function UITaskNewPage:refresh_day_list()
    local x = RoleInfoM.instance:taskActStatus()
    local list = {};
    local statusArr = RoleInfoM.instance:taskActStatus().reward_status;
    local min_index = 0;
    local max_index = 0;
    for i = 1, 7 do
        local itemData = cfg_task_vitality.instance(i);
        local canAccept = statusArr[i];
        if min_index == 0 and canAccept == 1 then
            min_index = i
        end

        if canAccept > 0 then
            max_index = i
        end

        local gitNum = itemData.need_vitality;
        local gitImg = cfg_goods.instance(itemData.reward_item_ids[1]).icon;

        table.insert(list, {
            canAccept = canAccept,
            gitNum = gitNum,
            gitImg = gitImg,
            index = i,
            iconType = itemData.reward_item_nums
        })
    end

    local min = self.get_min_list_index(min_index, max_index)
    for i = 2, min do
        table.remove(list, 1)
    end

    while (table.len(list) > 5) do
        table.remove(list)
    end

    local index = 0
    local remainder = 0
    for i = 1, #list do
        if x.v > list[i].gitNum then
            index = i
        end
    end
    if index ~= 0  then
        remainder = (x.v - list[index].gitNum) * 100 / (list[index+1].gitNum - list[index].gitNum)
    else
        remainder = (x.v - 0) * 100 / (list[index+1].gitNum - 0)
    end

    self.list_day_data = list
    self.main_p.value = index * 20 + remainder * 0.2;
    self.listDayManage = ListManager.creat(self.list_day, self.list_day_data, self.listDayUpdate, self)
end

function UITaskNewPage.get_min_list_index(min_index, max_index)
    local a1 = 0
    if min_index > 0 then
        a1 = 1
    end
    local t1 = math.max(max_index - 1, a1)
    local min = math.min(t1, 3)
    if min_index > 0 then
        min = math.min(min, min_index)
    else
        min = math.min(min, 7)
    end
    return min
end

function UITaskNewPage:SortOutItems()
    self.lotteryArr = {}
    for i = 1, 14 do
        local item = self.contentView:GetChild("item" .. i)
        table.insert(self.lotteryArr, item)
        item:GetChild("bg_light").visible = false;
        item:GetChild("bg_mask").visible = false;
    end
end

function UITaskNewPage:clickTaskBtn()
    self.taskBtn.selected = true;
    self.taskBox.visible = true;
    self.lotteryBox.visible = false;
    self:updateTask()
    self:initCountDown()
    GameTimer.loop(1000, self, self.initCountDown)
end

function UITaskNewPage:clickLotteryBtn()
    self.taskBox.visible = false;
    self.lotteryBox.visible = true;

    self:updateLotteryItem();
    self:lotteryEng();
    self.coinBtn:onClick(self.marquee, self, true)
    self.ticketBtn:onClick(self.marquee, self, false)
end


function UITaskNewPage:initEnergyTimeCountDown()

    local cleanTime = self.energyCountDownTime - os.time()
    if self.energyCountDownTime > 0 then
        self.energyCountDown.text = "能量清零倒计时："..self:getDetailedTime(cleanTime, false);
    else
        self.energyCountDownTime = 0;
        self.energyCountDown.text = "能量清零倒计时：00:00:00";
    end


    local freeTime = self.lotteryCountDownTime - os.time()
    if freeTime > 0 then
        self.lotteryCountDown.text = "免费抽奖倒计时："..self:getDetailedTime(freeTime, true);
    else
        self.lotteryCountDownTime = 0;
        self.lotteryCountDown.text = "免费抽奖倒计时：00:00:00";
        RoleInfoM.instance._lotteryEng.free = 1
        self:lotteryEng()
    end
end

function UITaskNewPage:getDetailedTime(time, isLoop)
    local secondTime
    if time ~= nil then
        secondTime = math.floor(time)-- 秒
    end

    local minuteTime = 0-- 分
    local hourTime = 0-- 小时
    local dayTime = 0--天
    if secondTime > 60 then
        minuteTime = math.floor(secondTime / 60)
        secondTime = math.floor(secondTime % 60)
        if minuteTime > 60 then
            hourTime = math.floor(minuteTime / 60)
            minuteTime = math.floor(minuteTime % 60)
        end

        if hourTime > 24 then
            dayTime = math.floor(hourTime / 24)
            hourTime = math.floor(hourTime % 24)
        end
    end

    if isLoop then
        local result = ""
        if secondTime >= 10 then
            result = math.floor(secondTime)
        elseif secondTime > 0 and secondTime < 10 then
            result = "0" .. math.floor(secondTime)
        elseif secondTime <= 0 then
            result = "00"
        end

        if minuteTime >= 10 then
            result = math.floor(minuteTime) .. ":" .. result
        elseif minuteTime > 0 and minuteTime < 10 then
            result = "0" .. math.floor(minuteTime) .. ":" .. result
        elseif minuteTime <= 0 then
            result = "00:" .. result
        end

        if hourTime >= 10 then
            result = math.floor(hourTime) .. ":" .. result
        elseif hourTime > 0 and hourTime < 10 then
            result = "0" .. math.floor(hourTime) .. ":" .. result
        elseif hourTime <= 0 then
            result = "00:" .. result
        end
        return result

    else
        local result = math.floor(secondTime) .. "秒"
        if minuteTime > 0 then
            result = math.floor(minuteTime) .. "分" .. result
        end
        if hourTime > 0 then
            result = math.floor(hourTime) .. "小时" .. result
        end
        if dayTime > 0 then
            result = math.floor(dayTime) .. "天" .. result
        end

        return result
    end
end

function UITaskNewPage:marquee(context)
    local type = 0
    if context == true and RoleInfoM.instance:lotteryEng().free ~= 1 then
        type = 1
    else
        type = 2
    end
    NetSender.Lottery( { type = type })
end

function UITaskNewPage:lotteryShow()
    self.lotteryIndex = RoleInfoM.instance:lotteryReturnData().index
    self.lotteryEndPos = table.len(self.lotteryArr) * 2 + self.lotteryIndex
    self:clearAni()
    self:aniLoop()
end

function UITaskNewPage:aniLoop()
    self:allBtnCanClick(false)
    self._deltaTime = 50
    self._curIndex = 1
    self:loopShow()
    --self.lotteryLoop = GameTimer.frameLoop(1, self, self.loopShow)
end

function UITaskNewPage:loopShow()
    local index = self._curIndex%14 == 0 and 14 or self._curIndex%14
    if self._curIndex > 1 then
        if index - 1 == 0 then
            self.contentView:GetChild("item14"):GetChild("bg_light").visible = false
        else
            self.contentView:GetChild("item"..(index -1)):GetChild("bg_light").visible = false
        end
    end
    self.contentView:GetChild("item"..index):GetChild("bg_light").visible = true

    if self._curIndex == self.lotteryEndPos then
        GameTimer.once(500,self,function ()
            self:clearAni();
            self:showAward();
        end)
        return
    end

    self._curIndex = self._curIndex + 1
    self._deltaTime = self._deltaTime+10
    GameTimer.once(self._deltaTime,self,self.loopShow)
end

function UITaskNewPage:clearAni()
    self.pwdTotalTime = 0;
    self.curFrame = 0;
    self.curIndex = 0;
    self.curTime = 0;
    self.intervalTime = Time.deltaTime * 4;
    for k, v in pairs(self.lotteryArr) do
        v:GetChild("bg_light").visible = false
        v:GetChild("bg").icon = "ui://taskNew/bg_list"
    end
    self:allBtnCanClick(true)
end

function UITaskNewPage:allBtnCanClick(canClick)
    self.taskBtn.touchable = canClick;
    self.lotteryBtn.touchable = canClick;
    self.coinBtn.touchable = canClick;
    self.ticketBtn.touchable = canClick;
    self.quitBtn.touchable = canClick;
end

function UITaskNewPage:showAward()
    local ids = RoleInfoM.instance:lotteryReturnData().ids
    local nums = RoleInfoM.instance:lotteryReturnData().nums

    GameEventDispatch.instance:Event(GameEvent.RewardTip, { ids, nums })
end

function UITaskNewPage:updateLotteryItem()
    local dataArr = RoleInfoM.instance:lotteryAwardData();
    for k, v in pairs(dataArr) do

        local item = self.lotteryArr[v.index]
        local icon = item:GetChild("icon")
        local awardNum = item:GetChild("awardNum")
        icon.icon = cfg_goods.instance(tonumber(v.ids[1])).icon
        local x = tonumber(v.ids[1])
        --技能图片适配
        if  20 < x and x < 25  then
            icon.scaleX = 0.8
            icon.scaleY = 0.8
        end
        --炮图片适配
        if  300 < x and x < 308  then
            icon.scaleX = 0.3
            icon.scaleY = 0.3
        end
        awardNum.text = ActivityM.instance:exchangeConversion(v.ids[1],v.nums[1])
    end
end

function UITaskNewPage:lotteryEng()
    local percent = RoleInfoM.instance:lotteryEng().rate;
    self.lotteryPro.value = percent * 100;
    self.lottery_num.text = string.format("%.2f", (percent * 100)) .. "%";
    local isFree = RoleInfoM.instance:lotteryEng().free == 1;
    local data = ConfigManager.getConfValue("cfg_global", 1, "raffle_config");
    self.coinBtn.icon = cfg_goods.instance(data.cost1.ids[1]).icon;
    self.ticketBtn.icon = cfg_goods.instance(data.cost2.ids[1]).icon;
    if isFree then
        self.coinBtn.text = "免费";
        self.ticketBtn.text = "免费";
    else
        self.lotteryCountDown.visible = true;
        if RoleInfoM.instance:lotteryEng().countdown then
            self.lotteryCountDownTime = RoleInfoM.instance:lotteryEng().countdown;
        else
            self.lotteryCountDownTime = 0
        end
        self.coinBtn.text = "x " .. data.cost1.nums[1];
        self.ticketBtn.text = "x " .. data.cost2.nums[1];
    end
end

function UITaskNewPage:updateTask()
    local taskArr = RoleInfoM.instance:refreshTaskArr();
    local x = {} ---可领取
    local y = {} ---前往
    local z = {} ---已领取
    for k, v in ipairs(taskArr) do
        if v.s == 1 then
            table.insert(x,v)
        end
        if v.s == 0 then
            table.insert(y,v)
        end
        if v.s == 2 then
            table.insert(z,v)
        end
    end

    for k, v in ipairs(y) do
        table.insert(x,v)
    end

    for k, v in ipairs(z) do
        table.insert(x,v)
    end
    taskArr = x

    self.list1Manage = ListManager.creat(self.list1, taskArr, self.listUpdate, self)
end

function UITaskNewPage:initListData()

end

function UITaskNewPage:listDayUpdate(i, cell, data)
    local ele_gift = cell:GetChild("img_gift");
    local ele_rotation = cell:GetTransition("rotation")
    local ele_img_status = cell:GetChild("img_status");
    --local ele_list_reward = cell:GetChild("list_reward")
    local ele_num = cell:GetChild("txt_day") ;

    ele_gift.icon = "ui://TaskNew/icon_lb1"
    if data.iconType[1] == 2 then
        ele_gift.icon = "ui://TaskNew/icon_lb2"
    elseif data.iconType[1] == 3 then
        ele_gift.icon = "ui://TaskNew/icon_lb3"
    end
    ele_img_status.visible = false;
    ele_num.text = data.gitNum

    if data.canAccept == 2 then
        ele_img_status.visible = true;
        ele_img_status.icon = "ui://TaskNew/img_yilingqu"
        ele_rotation:Stop()
    elseif data.canAccept == 1 then
        ele_rotation:Play()
        self.showOffTargets[data.index] = ele_gift
        ele_gift:onClick(function()
            self.acceptNewDayReward(data.index)
        end)
    else
        ele_rotation:Stop()
        ele_img_status.visible = false
    end
end

function UITaskNewPage:listUpdate(i, cell, data)

    local configData = cfg_task.instance(data.id)
    local ele_p1 = cell:GetChild("p1");
    local ele_p1_txt = cell:GetChild("p1_txt");
    local ele_icon = cell:GetChild("icon");
    local ele_taskName = cell:GetChild("task_name");
    local ele_btn = cell:GetChild("receiveBtn");
    local ele_actIcon = cell:GetChild("actIcon");
    local ele_activityNum = cell:GetChild("activityNum");
    local ele_rewardList = cell:GetChild("reward_type");

    local rewards = {}
    for i = 1, #configData.reward_item_ids do
        table.insert(rewards, { reward_item_id = configData.reward_item_ids[i], reward_item_num = configData.reward_item_nums[i] })
    end
    local iconNum = rewards[1].reward_item_id
    if table.len(rewards) == 1 or iconNum == 91 then
        ele_actIcon.visible = true
        ele_activityNum.visible = true
        ele_rewardList.visible = false
        local a = cfg_goods.instance(rewards[1].reward_item_id).icon;
        ele_actIcon.icon = cfg_goods.instance(rewards[1].reward_item_id).icon
        ele_activityNum.text = 'x' .. ActivityM.instance:exchangeConversion(rewards[1].reward_item_id, rewards[1].reward_item_num);
    else
        ele_actIcon.visible = false
        ele_activityNum.visible = false
        ele_rewardList.visible = true
        ListManager.creat(ele_rewardList, rewards, self.listRewardUpdate, self)
    end

    ele_taskName.text = configData.task_name_down
    ele_icon.url = configData.img_url_down
    local status = data.s
    ele_p1_txt.text = data.l.."/"..data.r
    if status == 0 then
        ele_p1.value = data.p * 100;
        ele_btn.text = "前往"
        ele_btn.icon = "ui://CommonComponent/btn_big_yellow"
        ele_btn:onClick(function()
            self:keepGoGame(data)
        end)
    elseif status == 1 then
        ele_p1.value = 1 * 100
        ele_btn.text = "领取"
        ele_btn.icon = "ui://CommonComponent/btn_big_green"
        ele_btn:onClick(function()
            self.onFinishTask(data.id)
        end)
    elseif status == 2 then
        ele_btn.text = "已领取"
        ele_btn.icon = "ui://CommonComponent/btn_big_gray"
        ele_p1.value = 1 * 100
        ele_btn:onClick(nil)
    end
end

function UITaskNewPage:keepGoGame(data)
    self:onQuitClick()
    if table.indexOf(self.specialIds,data.id) > -1 then
        if data.id == 402 then
            local info = CertificationInfo.new()
            info.openFrom = GameConst.from_bank
            CertificationM.instance:setInfo(info)
            CertificationM.instance:OpenCertification()
        elseif data.id == 401 then
            local info = CertificationInfo.new()
            info.openFrom = GameConst.from_main
            CertificationM.instance:setInfo(info)
            CertificationM.instance:OpenCertification()
        end
        return
    end

    local scene_id = cfg_task.instance(data.id).scene_id
    if scene_id == 0 then
        local a = {}
        local batteryLevel = RoleInfoM.instance:getBattery();
        if (batteryLevel < cfg_scene.instance(2).unlock) then
            a["scene_id"] = 1;
            NetSender.EnterRoom(a)
            return ;
        else
            a["scene_id"] = 2
            local intoSceneId = 2;
            local preCoinLimit = 0;
            local nextCoinLimit = 0;
            local tmpCoin = (RoleInfoM.instance:getCoin() - RuleM.instance:coinCount() + RoleInfoM.instance:getBindCoin())
            if (tmpCoin < 0) then
                tmpCoin = 0;
            end
            for i = 2, 4 do
                if (i ~= 4) then
                    preCoinLimit = cfg_scene.instance(i).unlock * 500;
                    nextCoinLimit = cfg_scene.instance(i + 1).unlock * 500;
                    if (tmpCoin >= preCoinLimit and tmpCoin < nextCoinLimit) then
                        intoSceneId = i;
                        break ;
                    end
                else
                    preCoinLimit = cfg_scene.instance(i).unlock * 500;
                    if (tmpCoin >= preCoinLimit) then
                        intoSceneId = i
                        break
                    end
                end
            end
            for i = intoSceneId, 3, -1 do
                if (batteryLevel >= cfg_scene.instance(i).unlock) then
                    a["scene_id"] = i
                    break ;
                end
            end
            NetSender.EnterRoom(a)
            return ;
        end
    else
        local cfg = cfg_scene.instance(scene_id)
        local batteryLevel = RoleInfoM.instance:getBattery()

        if batteryLevel > cfg.unlock then
            if scene_id > 0 and scene_id ~= Fishery.instance.sceneId then
                NetSender.ExitRoom()
                GameTimer.once(1000,self,function ()
                    local a = {}
                    a.scene_id = scene_id;
                    NetSender.EnterRoom(a)
                end)
            end
        else
            GameTip.showTipById(cfg.msg_tip_id)
        end
    end
end

function UITaskNewPage.acceptNewDayReward(day_index)
    NetSender.GetTaskReward( {id= day_index});
end

function UITaskNewPage.onFinishTask(task_id)
    local a = {};
    a.id = task_id;
    NetSender.GetTaskFinishedReward( a);
end

function UITaskNewPage:initCountDown()
    local hours = math.floor(23 - os.date("%H"))
    local minutes = math.floor(59 - os.date("%M"))
    local seconds = math.floor(59 - os.date("%S"))
    if minutes < 10 then
        minutes = "0" .. minutes
    end
    if seconds < 10 then
        seconds = "0" .. seconds
    end
    self.countDown.text = hours .. ":" .. minutes .. ":" .. seconds
end

function UITaskNewPage:listRewardUpdate(i, cell, data)
    local ele_reward_img = cell:GetChild("reward_type");
    local ele_reward_text = cell:GetChild("reward_text");

    ele_reward_img.icon = cfg_goods.instance(data.reward_item_id).icon
    ele_reward_text.text = 'x' .. data.reward_item_num;
end

function UITaskNewPage:syncTask()
    local a = {}
    a.is_daily = true;
    --服务端功能没有了
    --WebSocketManager.instance:Send(19002, a);
end

function UITaskNewPage:refreshList()
    self:initListData()
    self.list1Manage.update()
end

function UITaskNewPage:onQuitClick()
    self.refreshDate:clear()
    UIManager:ClosePanel("TaskNewPage")
end

return UITaskNewPage