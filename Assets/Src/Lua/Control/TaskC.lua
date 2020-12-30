---@class TaskC
---@field public instance TaskC
TaskC = class("TaskC")
function TaskC:ctor()
    GameEventDispatch.instance:on(tostring(10004), self, self.init)
    GameEventDispatch.instance:on(tostring(19006), self, self.syncRedPoint)
    GameEventDispatch.instance:On(tostring(19001), self, self.finishTask)
    GameEventDispatch.instance:On(tostring(19003), self, self.sync)
    GameEventDispatch.instance:On(tostring(19005), self, self.finishTaskNewDay)
    GameEventDispatch.instance:On(tostring(19050), self, self.taskActivity)
    GameEventDispatch.instance:On(tostring(19060), self, self.lotteryEng)
    GameEventDispatch.instance:On(tostring(19062), self, self.returnLottery)
    GameEventDispatch.instance:On(tostring(19055), self, self.refreshTask)
    GameEventDispatch.instance:On(tostring(19054), self, self.receiveTaskReturn)
    GameEventDispatch.instance:On(tostring(19059), self, self.lotteryAwardArr)
    GameEventDispatch.instance:On(tostring(19056), self, self.refreshTaskData)
    GameEventDispatch.instance:On(tostring(19052), self, self.acceptActivityReturn)
    GameEventDispatch.instance:on(GameConst.ClearRedPoint, self, self.clearRedPoint)
end

function TaskC:clearRedPoint(point_value)
    local a = {}
    a.point_value = point_value
    NetSender.ClearRedPoint(a)
end
function TaskC:syncRedPoint(data)
    local red_points = data["red_points"]
    RoleInfoM.instance:setRedPoints(red_points)
    GameEventDispatch.instance:Event(GameEvent.ShowRedPoint)
end
function TaskC:finishTaskNewDay(data)
    if 0 == data["code"] then
        local day_index = data["day_index"]
        local cfg = cfg_task_new.instance(day_index)
        GameEventDispatch.instance:event(GameEvent.RewardTip, { cfg.reward_item_ids, cfg.reward_item_nums })
        self:sync(data)
    end
end
function TaskC:finishTask(data)
    local code = data["code"]
    if 0 == code then
        local task = cfg_task.instance(data["finish_task_id"] + "")
        if ActivityM.instance:activityIsActive('bonus') then
            GameEventDispatch.instance:event(GameEvent.RewardTip, { task.activity_item_ids, task.activity_item_nums })
        else
            GameEventDispatch.instance:event(GameEvent.RewardTip, { task.reward_item_ids, task.reward_item_nums })
        end
        self:sync(data)
    else
        if 1 == code then
            GameTip.showTip("无法领取任务奖励")
        elseif 2 == code then
            GameTip.showTip("重复领取任务奖励")
        elseif 3 == code then
            GameTip.showTip("无法领取任务奖励")
        else
            GameTools.dealCode(code)
        end
    end
end

function TaskC:sync(data)
    if data and data == {} then
        return

    end
    if data['task_new'] then
        RoleInfoM.instance:updateTaskNew(data['task_new'])
        GameEventDispatch.instance:event(GameEvent.RefreshTaskNew)

    end
    if data['task_daily'] then
        RoleInfoM.instance:updateTaskDaily(data['task_daily'])
        GameEventDispatch.instance:event(GameEvent.RefreshTaskDaily)

    end
    if data['day_index'] then
        if data['day_index'] > RoleInfoM.instance:getDayIndex() then
            RoleInfoM.instance:setDayIndex(data['day_index'])
            GameEventDispatch.instance:event(GameEvent.RefreshTaskNew)
        end
    end
    if data["task_daily_ids"] then
        RoleInfoM.instance:setTaskDailyIds(data['task_daily_ids'])
        GameEventDispatch.instance:event(GameEvent.RefreshTaskDailyTotal)
    end
end

function TaskC:taskActivity(data)
    RoleInfoM.instance:taskActStatus(data);
    GameEventDispatch.instance:event(GameEvent.TaskActivity);
end

function TaskC:lotteryEng(data)
    RoleInfoM.instance:lotteryEng(data);
    GameEventDispatch.instance:event(GameEvent.LotteryEng);
end

function TaskC:lotteryAwardArr(data)
    RoleInfoM.instance:lotteryAwardData(data.data);
    GameEventDispatch.instance:event(GameEvent.RefreshLotteryArr);
end

function TaskC:refreshTask(data)
    RoleInfoM.instance:refreshTaskArr(data.data);
    GameEventDispatch.instance:event(GameEvent.RefreshTask);
    GameEventDispatch.instance:event(GameEvent.ShowRedPoint);
end

function TaskC:taskActivity(data)
    RoleInfoM.instance:taskActStatus(data);
    GameEventDispatch.instance:event(GameEvent.TaskActivity);
end

function TaskC:refreshTaskData(data)
    local taskData = RoleInfoM.instance:refreshTaskArr();
    local newData = data.data
    local isHave = false;
    for i, v in pairs(newData) do
        isHave = false;
        for i = 1, #taskData do
            if v.id == taskData[i].id then
                taskData[i] = v;
                isHave = true;
                break
            end
        end
        if not isHave then
            table.insert(taskData, v)
        end
    end
    --local a = self.sortOut(taskData)
    RoleInfoM.instance:refreshTaskArr(taskData)
    GameEventDispatch.instance:event(GameEvent.RefreshTask);
    GameEventDispatch.instance:event(GameEvent.ShowRedPoint);
end

function TaskC.sortOut(taskData)
    table.sort(taskData, function(a, b)
        if a.s ~= 2 then
            --if a.s>b.s then
            --    return true
            --end
            --return false
            return b.s - a.s
        else
            --if a.s<b.s then
            --    return true
            --end
            --return false
            return a.s - b.s
        end
    end)

    return taskData
end

function TaskC:returnLottery(data)
    if data.code == 0 then
        RoleInfoM.instance:lotteryReturnData(data);
        GameEventDispatch.instance:event(GameEvent.ReturnLottery);
    elseif data.code == 1 then
        GameTip.showTip("消耗道具不足")
    elseif data.code == 2 then
        GameTip.showTip("抽奖券不足")
    else
        GameTools.dealCode(data.code)
    end
end

function TaskC:receiveTaskReturn(data)
    if data.code == 0 then
        GameTip.showTip("领取成功")
    elseif data.code == 1 then
        GameTip.showTip("条件不足")
    elseif data.code == 2 then
        GameTip.showTip("任务无效")
    else
        GameTools.dealCode(data.code)
    end
end

function TaskC:acceptActivityReturn(data)
    if data.code == 0 then
        GameTip.showTip("领取成功")
    elseif data.code == 1 then
        GameTip.showTip("条件不足")
    elseif data.code == 2 then
        GameTip.showTip("领取失败")
    else
        GameTools.dealCode(data.code)
    end
end
--function TaskC:new_task_override(day_index)
--    local taskDatas = RoleInfoM.instance:getTaskNew()
--    local taskData = taskDatas[day_index - 1]
--    local task_ids = cfg_task_new.instance(tostring(day_index)).task_ids
--    local cfgs = ConfigManager.filter("cfg_task", function(item)
--        return task_ids:indexOf(item.id) > -1
--    end)
--    local is_all_accepted = taskData.rec_ids.length - 1 == task_ids.length
--    local have_can_accept = false
--    local is_all_finished = true
--    for i, value in TODO do
--        local cfg = cfgs[i]
--        local is_accept = taskData.rec_ids:indexOf(cfg.id) > -1
--        local percent = control.TaskC.instance:taskPercent(taskData, cfg)
--        local is_finish = percent == 1
--        if not is_finish then
--            is_all_finished = false
--
--        end
--        if is_finish and not is_accept then
--            have_can_accept = true
--
--        end
--
--    end
--    return { is_all_accepted = is_all_accepted, is_all_finished = is_all_finished, have_can_accept = have_can_accept }
--
--end
function TaskC:getCurTaskValue(taskData, taskConfig)
    local value = 0

    if taskConfig.task_type == 1 then
        if taskConfig.task_value_f == 0 then
            value = taskData.f["total"]
        else
            value = taskData.f[taskConfig.task_value_f] or 0
        end
    elseif taskConfig.task_type == 2 then
        value = taskData.l;
    elseif taskConfig.task_type == 3 then
        value = taskData.lg;
    elseif taskConfig.task_type == 4 then
        local useNum = taskData.goods[taskConfig.task_value_f];
        if not useNum then
            value = 0
        else
            value = useNum
        end
    elseif taskConfig.task_type == 5 then
        value = taskData.b;
    elseif taskConfig.task_type == 6 then
        value = taskData.lv;
    elseif taskConfig.task_type == 7 then
        value = taskData.g;
    elseif taskConfig.task_type == 8 then
        value = taskData.rec_ids.length - 1
    end
    return value

end

function TaskC:taskPercent(taskData, taskConfig)
    local percent = 0
    if taskConfig.task_type == 1 then
        local value = 0
        if taskConfig.task_value_f == 0 then
            value = taskData.f["total"]
        else
            value = taskData.f[taskConfig.task_value_f] or 0
        end
        percent = value / taskConfig.task_value_n > 1 and 1 or value / taskConfig.task_value_n;

    elseif taskConfig.task_type == 2 then
        percent = taskData.l / taskConfig.task_value_n > 1 and 1 or taskData.l / taskConfig.task_value_n;

    elseif taskConfig.task_type == 3 then
        percent = taskData.lg / taskConfig.task_value_n > 1 and 1 or taskData.lg / taskConfig.task_value_n;

    elseif taskConfig.task_type == 4 then
        local useNum = taskData.goods[taskConfig.task_value_f];
        if not useNum then
            percent = 0
        else
            percent = useNum / taskConfig.task_value_n > 1 and 1 or useNum / taskConfig.task_value_n;
        end
    elseif taskConfig.task_type == 5 then
        percent = taskData.b / taskConfig.task_value_n > 1 and 1 or taskData.b / taskConfig.task_value_n;
    elseif taskConfig.task_type == 6 then
        percent = taskData.lv / taskConfig.task_value_n > 1 and 1 or taskData.lv / taskConfig.task_value_n;
    elseif taskConfig.task_type == 7 then
        percent = taskData.g / taskConfig.task_value_n > 1 and 1 or taskData.g / taskConfig.task_value_n;
    elseif taskConfig.task_type == 8 then
        percent = (table.len(taskData.rec_ids) - 1) / taskConfig.task_value_n > 1 and 1 or (table.len(taskData.rec_ids) - 1) / taskConfig.task_value_n;
    end
    return percent

end  