---@class UIRedPage :UIDialogBase
local UIRedPage = class("UIRedPage", UIDialogBase)

---init @override 派生类可重写，成员变量或者其他内容的初始化
---@protected
---@return void
function UIRedPage:init()
    self.packageName = "Red"
    self.resName = "RedPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.showEffectType = UIEffectType.SMALL_TO_BIG
    self.hideEffectType = UIEffectType.BIG_TO_SMALL

    self.bgSpine = nil
    self.progressArr = { 0.09, 0.26, 0.6, 1 }
end

---initComponent @override 派生类可重写，只会在新建界面的时候调用一次。缓存的界面不会调用。可以用来初始化控件等
---@protected
---@return void
function UIRedPage:initComponent()

    self.contentView = self.view:GetChild("contentView")

    self.quitBtn = self.contentView:GetChild("quitBtn")
    self.bg = self.contentView:GetChild("bg")
    self.bar = self.contentView:GetChild("bar")
    self.getBtn = self.contentView:GetChild("get_btn")
    self.barPrice = self.contentView:GetChild("bar_price")
    self.oneBox = self.contentView:GetChild("oneBox")
    self.twoBox = self.contentView:GetChild("twoBox")
    self.threeBox = self.contentView:GetChild("threeBox")
    self.fourBox = self.contentView:GetChild("fourBox")

    self.tips1 = self.contentView:GetChild("tips1")

    self.bgSpine = SpineManager.create("ui/PageEffects/HongBaoHaoLi", Vector3.New(50, -17, 1), 1, self.bg)
    self.bgSpine:play("animation", true)
    self.quitBtn:onClick(self.onQuitBtn, self)
end

---StartGames @override 派生类可重写
---@public
---@param param table 打开界面时传递的参数
---@return void
function UIRedPage:StartGames(param)
    NetSender.RedPackageTaskInfo({})
    self:initBox()
end

function UIRedPage:renderBox(box, rewardId)
    local config = cfg_task_red_reward.instance(rewardId)
    local coinLabel = box:GetChild("coin")
    local moneyLabel = box:GetChild("money")
    local giveawayBox = box:GetChild("giveawayBox")
    giveawayBox.visible = false
    coinLabel.text = tostring(config.taskNum)
    moneyLabel.text = tostring(config.reward_money_3)

    if ActivityM.instance:isShowRedTask() == true then
        if ActivityM.instance.rewardTimes[rewardId] <= 0 then
            giveawayBox.visible = true
            local giveawayLabel = box:GetChild("giveawayLabel")
            local giveawayImg = box:GetChild("giveawayImg")
            local redExtraArr = ActivityM.instance:_getCommonActivityConfig(GameConst.activity_common_red_task)["red_extra"]
            giveawayImg.icon = cfg_goods.instance(tonumber(redExtraArr[1][1])).icon;
            giveawayLabel.text = tostring(redExtraArr[rewardId][1])
        end
    end
end

function UIRedPage:initBox()
    self.boxArr = { self.oneBox, self.twoBox, self.threeBox, self.fourBox }
    for i = 1, #self.boxArr do
        local objBox = self.boxArr[i]
        self:renderBox(objBox, i)
    end
    local differenceValue = ActivityM.instance.taskRequire - ActivityM.instance.gainCoin
    if (differenceValue >= 0) then
        if (ActivityM.instance.lowRequireCoin > 0) then
            self.tips1num1 = tostring(ActivityM.instance.lowMoney[1])
            self.tips1num2 = tostring(ActivityM.instance.lowMoney[2])
            self.tips1num3 = tostring(ActivityM.instance.lowMoney[3])
            self.tips1num4 = tostring(differenceValue)
            self.tips1num5 = tostring(ActivityM.instance.taskMoney[3])
            self.tips1.text = "当前可领取[color=#FEFB00]" .. self.tips1num1 .. "[/color]或[color=#FEFB00]" .. self.tips1num2 .. "[/color]"
                    .. "或[color=#FEFB00]" .. self.tips1num3 .. "[/color]喇叭，再获取[color=#FEFB00]" .. self.tips1num4 .. "[/color]金币，将有可能获得[color=#FEFB00]" .. self.tips1num5 .. "[/color]喇叭。"

        else
            self.tips2num1 = tostring(ActivityM.instance.taskRequire)
            self.tips2num2 = tostring(ActivityM.instance.taskMoney[3])
            self.tips1.text = "累计获得[color=#FEFB00]" .. self.tips2num1 .. "[/color]金币，将有可能获得[color=#FEFB00]" .. self.tips2num2 .. "[/color]喇叭。"
        end
        self.bar.value = self:getProgressValue()
        self.barPrice.text = tostring(ActivityM.instance.gainCoin)
    else
        self.bar.value = 1
        self.barPrice.text = tostring(ActivityM.instance.taskRequire)
        self.tips3num1 = tostring(ActivityM.instance.taskMoney[3])
        self.tips1.text = "已经累计到最高金币，将有可能获得[color=#FEFB00]" .. self.tips3num1 .. "[/color]喇叭。"
    end
    --self.getBtn.onClick:Clear()
    if ((self.bar.value >= self.progressArr[1]) or ActivityM.instance.redState == 2) then
        self.getBtn.grayed = false
        self.getBtn:onClick(self.onGet, self)
    else
        self.getBtn.grayed = true
    end
end

function UIRedPage:getProgressValue()
    local lastPro = 0;
    local totalPro = self.progressArr[ActivityM.instance.maxTaskId]
    local percent = (ActivityM.instance.gainCoin - ActivityM.instance.lowRequireCoin) / (ActivityM.instance.taskRequire - ActivityM.instance.lowRequireCoin)
    if (ActivityM.instance.maxTaskId > 1) then
        lastPro = self.progressArr[ActivityM.instance.maxTaskId - 1]
    else
        lastPro = 0
    end
    percent = percent * (totalPro - lastPro) + lastPro;
    return percent;
end

function UIRedPage:onGet()
    NetSender.RedPackageTaskReward( {})
end

function UIRedPage:onQuitBtn()
    UIManager:ClosePanel("RedPage")
end

---Register @override 注册监听
---@public
---@return void
function UIRedPage:Register()
    self:AddRegister(GameEvent.SynRedData, self, self.initBox)
    self:AddRegister(GameEvent.SynTaskCoinData, self, self.initBox)
end

return UIRedPage