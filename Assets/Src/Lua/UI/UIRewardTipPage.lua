---@class UIRewardTipPage :UIDialogBase
local UIRewardTipPage = class("UIRewardTipPage", UIDialogBase)
RewardBox = require("UI.RewardBox")
function UIRewardTipPage:init()
    self.packageName = "RewardTip"
    self.resName = "RewardTipPage"
    self.uiType = UIType.UI_TYPE_DLG
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil

    self._imageArr = {}
    self._pointArr = {}
    self._countArr = {}
    self._soundPath = nil

    self._boxArr = {}
    self._boxArrPool = {}
end

function UIRewardTipPage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.confirmBtn = self.contentView:GetChild("confirmBtn")
    self.awardList = self.contentView:GetChild("awardList")
    self._soundPath = cfg_global.instance(1).get_sound
    self.confirmBtn.onClick:Set(self.stop, self)
end

function UIRewardTipPage:StartGames(param)
    self._imageArr = RTipM:getImageArr();
    self._pointArr = RTipM:getPointList();
    self._countArr = RTipM:getCountArr();
    self:initAwardItem()
    --if param ~= nil then
    --    if param.delay ~= nil then
    --        self:start(param.delay)
    --    else
    self:start()
    --end
    --end
    self:playSound()
end

function UIRewardTipPage:initAwardItem()
    self.awardList:RemoveChildrenToPool()
    for i = 1, #self._imageArr do
        local item = self.awardList:AddItemFromPool()
        local icon = item:GetChild("awardIcon")
        local awardText = item:GetChild("awardText")
        ---@type GGraph
        local holder = item:GetChild("holder")
        local guang = SpineManager.create("Effects/H5_linjiang", Vector3.New(0, 0, 1000), 1, holder)
        guang:play("H5_linjiangxunhuan", true)
        icon.icon = tostring(self._imageArr[i])
        awardText.text = "x "..self._countArr[i]
    end
end

function UIRewardTipPage:playSound()
    SoundManager.PlayEffect("Music/reward.mp3")
end

function UIRewardTipPage:stop()
    --for i = 1, #self.boxArr do
    --    (self.boxArr[i]):stop()
    --    table.insert(self._boxArrPool, self.boxArr[i])
    --end
    --self.boxArr = {}

    self:closePanel()
end

function UIRewardTipPage:updateData()
    --self.boxArr = {}
    --for i = 1, #self._imageArr do
    --    local rewardBox
    --    if #self._boxArrPool > 0 then
    --        rewardBox = table.remove(self._boxArrPool, 1)
    --    else
    --        rewardBox = RewardBox.New()
    --    end
    --    rewardBox:creat(self._imageArr[i], self._pointArr[i], self.view, self._countArr[i])
    --    table.insert(self.boxArr, rewardBox)
    --end
end

function UIRewardTipPage:start(delay)
    if delay == nil then
        delay = 0
    end
    --for i = 1, #self.boxArr do
    --    (self.boxArr[i]):start((i - 1) * delay);
    --end
end

--@override 注册监听
function UIRewardTipPage:Register()
    self:AddRegister(GameEvent.CloseRewadTip, self, self.closePanel);
end

function UIRewardTipPage:closePanel()
    UIManager:ClosePanel("RewardTipPage")
end

return UIRewardTipPage