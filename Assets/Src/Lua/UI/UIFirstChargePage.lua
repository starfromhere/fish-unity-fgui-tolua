---@class UIFirstChargePage :UIDialogBase
local UIFirstChargePage = class("UIFirstChargePage", UIDialogBase)

function UIFirstChargePage:init()
    self.packageName = "FirstCharge"
    self.resName = "FirstChargePage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
end

function UIFirstChargePage:Register()
    self:AddRegister(GameEvent.UpdateFirstCharge, self, self.initBtn);
end

function UIFirstChargePage:StartGames(param)

    self:initComponent()
    self:initReward()
    self:initBtn()
end

function UIFirstChargePage:initComponent()
    self.contentView = self.view:GetChild("contentView")

    self.contentView:GetChild("quitBtn"):onClick(self.onQuitClick, self)
    self.listRewardOne = self.contentView:GetChild("listRewardOne")
    self.listRewardTwo = self.contentView:GetChild("listRewardTwo")
    self.chargeBtn = self.contentView:GetChild("chargeBtn")
    self.batterySkin = self.contentView:GetChild("batterySkin")
end

function UIFirstChargePage:initBtn()
    self.chargeBtn.text = ""

    if RoleInfoM.instance:getFirstChargeRewardAccepted() == 1 then
        self.chargeBtn.text = "已领取"
        --self:onQuitClick()
    else
        if RoleInfoM.instance:getChargeTimes() > 0 then
            self.chargeBtn.text = "领取"
            self.chargeBtn:onClick(function ()
                NetSender.GetFirstChargeReward();
            end)
        else
            self.chargeBtn.text = "立即充值"
            self.chargeBtn:onClick(function ()
                UIManager:ClosePanel("FirstChargePage")
                GameEventDispatch.instance:Event(GameEvent.Shop,GameConst.shop_tab_coin)
            end)
        end
    end
end

function UIFirstChargePage:initReward()
    local cfg = cfg_first_charge.instance(1)
    local index = table.indexOf(cfg.reward_item_ids, 23)
    if index > -1 then
        table.splice(cfg.reward_item_ids, index, 1)
        table.splice(cfg.reward_item_nums, index, 1)
    end

    local rewardsOne = {}
    local rewardsTwo = {}

    for k, v in ipairs(cfg.reward_item_ids) do
        if k <= 2 then
            table.insert(rewardsOne, { reward_item_id = cfg.reward_item_ids[k],
                                       reward_item_num = cfg.reward_item_nums[k] })
        else
            table.insert(rewardsTwo, { reward_item_id = cfg.reward_item_ids[k],
                                       reward_item_num = cfg.reward_item_nums[k] })
        end
    end

    ---因炮台皮肤有改动  暂时写死为急速炮
    --local batteryId = cfg_first_charge.instance(1).reward_skin_id
    --self.batterySkin.icon = cfg_goods.instance(batteryId).icon

    self.listOneManage = ListManager.creat(self.listRewardOne,rewardsOne,self.updateList,self)
    self.listTwoManage = ListManager.creat(self.listRewardTwo,rewardsTwo,self.updateList,self)
end

function UIFirstChargePage:updateList(i,cell,data)
    local ele_reward_img = cell:GetChild("reward_type");
    local ele_reward_text = cell:GetChild("reward_text");

    --FightTools.getImageScale(ele_reward_img);
    ele_reward_img.icon = cfg_goods.instance(data.reward_item_id).icon;
    ele_reward_text.text = 'x '..data.reward_item_num;
end

function UIFirstChargePage:onQuitClick()
    UIManager:ClosePanel("FirstChargePage")
end

return UIFirstChargePage