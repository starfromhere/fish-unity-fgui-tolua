---@class UIRulePage :UIDialogBase
local UIRulePage = class("UIRulePage",UIDialogBase)

function UIRulePage:init()
    self.packageName = "Rule"
    self.resName = "RulePage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
end


function UIRulePage:StartGames(param)


    self:initComponent()
    self:initView()
end

function UIRulePage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.activityBox = self.contentView:GetChild("activityBox")
    self.nomalBox = self.contentView:GetChild("nomalBox")
    self.matchRuleBox = self.contentView:GetChild("matchRuleBox")
    self.awardImg = self.contentView:GetChild("awardImg")
    self.award = self.contentView:GetChild("award")

    self.bgMask.onClick:Set(self.onQuitClick,self)
end

function UIRulePage:initView()
    self.activityBox.visible = false;
    self.nomalBox.visible = false;
    self.matchRuleBox.visible = false

    if not FightM.instance:isMatchingGame() then
        if ActivityM.instance:isShowSinceRebate() then
            self.activityBox.visible = true
            local awardArr = ActivityM.instance:_getCommonActivityConfig(FightConst.activity_common_since)["award"]
            self.awardImg.icon = cfg_goods.instance(awardArr[1]).icon;
            self.award.text = awardArr[2]
        else
            self.nomalBox.visible = true
        end
    else
        self.matchRuleBox.visible = true
    end
end

function UIRulePage:onQuitClick()
    UIManager:ClosePanel("RulePage")
end


return UIRulePage