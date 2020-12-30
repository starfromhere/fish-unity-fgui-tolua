---@class UILevelUpPage :UIDialogBase
local UILevelUpPage = class("UILevelUpPage",UIDialogBase)

function UILevelUpPage:init()
    self.packageName = "LevelUp"
    self.resName = "LevelUpPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
    self.rewardIds = {}
    self.rewardNums = {}
    self.listData = {}
end


function UILevelUpPage:StartGames(param)

    param = param or {}

    self:initComponent()

    if table.len(param) ~= 0 then
        self.rewardIds = param.ids
        self.rewardNums = param.nums
    end

    self:initView()
end

function UILevelUpPage:initComponent()
    self.contentView = self.view:GetChild("contentView")

    self.confirmBtn = self.contentView:GetChild("confirmBtn")
    self.list1 = self.contentView:GetChild("list1")
    self.spineNode = self.contentView:GetChild("spineNode")
    self.countClip = self.contentView:GetChild("countClip")
    self.confirmBtn:onClick(self.onGetRewardClick,self)

end


function UILevelUpPage:initView()
    self.listData = {}
    for i = 1, #self.rewardIds do
        table.insert(self.listData,{id = self.rewardIds[i],num = self.rewardNums[i]})
    end
    local spineNode = SpineManager.create("Effects/ShengJi", Vector3.New(0, 0, 0), 1.5, self.spineNode)
    spineNode:play("H5_shengji", false)
    self.countClip.text = RoleInfoM.instance:getLevel()
    self.listOneManage = ListManager.creat(self.list1,self.listData,self.updateList,self)
end

function UILevelUpPage:onGetRewardClick()
    UIManager:ClosePanel("LevelUp",nil, false)
    NetSender.LevelUpReward();
end

function UILevelUpPage:updateList(i,cell,data)
    local reward_type = cell:GetChild("icon")
    local reward_text = cell:GetChild("title")

    reward_type.icon = cfg_goods.instance(data.id).icon
    reward_text.text = "x"..data.num
end

return UILevelUpPage