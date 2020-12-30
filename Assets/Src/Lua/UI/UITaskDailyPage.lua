---@class UITaskDailyPage :UIDialogBase
local UITaskDailyPage = class("UITaskDailyPage",UIDialogBase)

function UITaskDailyPage:init()
    self.packageName = "TaskDaily"
    self.resName = "TaskDailyPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.list1Data = nil;
end

--@override 注册事件监听
function UITaskDailyPage:Register()
    self:AddRegister(GameEvent.RefreshTaskDaily, self, self.refresh);
    --self:AddRegister(GameEvent.FinishTaskDaily, self, self.refresh);
end

function UITaskDailyPage:StartGames(param)

    self:syncTask();
    self:initComponent();
    self:initView()
end

function UITaskDailyPage:initComponent()
    self.list1 = self.view:GetChild("list1")
    self.quitBtn = self.view:GetChild("quitBtn")

    self.quitBtn:onClick(self.onQuitClick,self)
end

function UITaskDailyPage:initView()
    self:initListData()
    self.list1Manage = ListManager.creat(self.list1,self.list1Data,self.listUpdate,self)
end

function UITaskDailyPage:initListData()
    local task_daily_ids = RoleInfoM.instance:getTaskDailyIds();
    local taskData = RoleInfoM.instance:getTaskDaily();
    local cfgs =  ConfigManager.filter("cfg_task", function (item)
        return table.indexOf(task_daily_ids,item.id) > -1
    end)

    local  finish_arr = {};
    local  unFinish_arr = {};
    local  accept_arr = {}

    for k, v in ipairs(cfgs) do
        local percent = TaskC.instance:taskPercent(taskData, v);
        local is_finish = percent == 1;
        local is_accept = table.indexOf(taskData.rec_ids,v.id) > -1
        if is_accept then
            table.insert(accept_arr,v)
        elseif is_finish then
            table.insert(finish_arr,v)
        else
            table.insert(unFinish_arr,v)
        end
    end

    self.list1Data = table.concatTable(finish_arr,table.concatTable(unFinish_arr,accept_arr))
end

function UITaskDailyPage:listUpdate(i, cell, data)

    local taskData = RoleInfoM.instance:getTaskDaily()
    local battery = RoleInfoM.instance:getBattery()
    local level = RoleInfoM.instance:getLevel()
    local ele_p1 = cell:GetChild("p1");
    local ele_icon = cell:GetChild("icon");
    local ele_taskName = cell:GetChild("task_name");
    local ele_btn = cell:GetChild("receiveBtn");
    local ele_rewardList = cell:GetChild("reward_type");


    local rewards = {}
    for i = 1, #data.reward_item_ids do
        table.insert(rewards,{reward_item_id = data.reward_item_ids[i],reward_item_num = data.reward_item_nums[i]})
    end

    ListManager.creat(ele_rewardList,rewards,self.listRewardUpdate,self)

    ele_taskName.text = data.task_name_down
    ele_icon.icon = data.img_url_down

    local percent = TaskC.instance:taskPercent(taskData, data);
    local is_accept = table.indexOf(taskData.rec_ids,data.id) > -1
    local is_finish = percent == 1;
    ele_p1.value = percent;

    if is_accept then
        ele_btn.title = "已领取"
        ele_p1.value = 1
    elseif is_finish then

        ele_btn.title = "领取"
        ele_btn:onClick(function ()
            self.onFinishTask(data.id)
        end)
    else
        ele_btn.title = "立即前往"
        ele_btn:onClick(function ()
            self:onQuitClick()
            if data.scene_id > 0 and data.scene_id ~= FightM.instance.sceneId then
                local a = {}
                a["scene_id"] = config.id;
                NetSender.ExitRoom()
            end
        end)
    end
end

function UITaskDailyPage:listRewardUpdate(i,cell,data)
    local ele_reward_img = cell:GetChild("reward_type");
    local ele_reward_text = cell:GetChild("reward_text");

    ele_reward_img.icon = cfg_goods.instance(data.reward_item_id).icon
    ele_reward_text.text = 'x'..data.reward_item_num;
end

function UITaskDailyPage.onFinishTask(task_id)
    local a
    a.task_id = task_id;
    a.is_daily = true;
    --19000服务端已经没用了
    --WebSocketManager.instance:Send(19000, a);
end

function UITaskDailyPage:syncTask()
    local a = {}
    a.is_daily = true;
    --19002服务端已经没用了
    --WebSocketManager.instance:Send(19002, a);
end


function UITaskDailyPage:refreshList()
    self:initListData()
    self.list1Manage.update()
end

function UITaskDailyPage:onQuitClick()
    UIManager:ClosePanel("TaskDailyPage")
end


return UITaskDailyPage