---@class UIPrizePage :UIDialogBase
local UIPrizePage = class("UIPrizePage", UIDialogBase)

function UIPrizePage:init()
    self.packageName = "Prize"
    self.resName = "PrizePage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self._imgUrl = nil
    self.goodsId = nil
    self._count = nil
    self.listManage = nil
end

function UIPrizePage:StartGames(param)
    self:initComponent()
    self:initView()
end

function UIPrizePage:initComponent()
    self.contentView = self.view:GetChild("contentView")

    self.prizeBox = self.contentView:GetChild("prizeBox")
    self.activityBox = self.contentView:GetChild("activityBox")
    self.prizeIcon = self.contentView:GetChild("prizeIcon")
    self.coinCount = self.contentView:GetChild("coinCount")
    self.receiveBtn = self.contentView:GetChild("receiveBtn")

    self.receiveBtn:onClick(self.clickReceive, self)
end

function UIPrizePage:initView()

    self.activityBox.visible = false
    self.prizeBox.visible = false
    if ActivityM.instance:isShowRewRebate() then
        self.activityBox.visible = true
        self.listData = RuleM.instance:activityID()
        self.listManage = ListManager.creat(self.activityBox, self.listData, self.updateList, self)
    else
        self.prizeBox.visible = true
        self._imgUrl = RuleM.instance:imageUrl();
        self.goodsId = RuleM.instance:goodsId();
        self._count = RuleM.instance:coinCount();
    end

    self.prizeIcon.icon = self._imgUrl
    self.coinCount.text = self._count
end

function UIPrizePage:updateList(i, cell, data)
    local img = cell:GetChild("icon")
    local coinCount = cell:GetChild("coinCount")

    img.icon = cfg_goods.instance(data).icon
    coinCount.text = RuleM.instance:activityNum()[index]
end

function UIPrizePage:clickReceive()
    if ActivityM.instance:isShowSinceRebate() then
        GameEventDispatch.instance:Event(GameEvent.RewardTip, { RuleM.instance:activityID(), RuleM.instance:activityNum() });
    else
        GameEventDispatch.instance:Event(GameEvent.RewardTip, { { self.goodsId }, { self._count } });
    end
    UIManager:ClosePanel("PrizePage",nil, false)
end

function UIPrizePage:UnRegister()
    RuleM.instance:coinCount(0);
    GameEventDispatch.instance:event(GameEvent.UpdateProfile);
    GameEventDispatch.instance:event(GameEvent.FightCoinUpdate);
end

return UIPrizePage