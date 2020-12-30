---@class UIMatchSettlePage :UIDialogBase
local UIMatchSettlePage = class("UIMatchSettlePage", UIDialogBase)

function UIMatchSettlePage:init()
    self.packageName = "MatchSettle"
    self.resName = "MatchSettlePage"
    self.uiType = UIType.UI_TYPE_NORMAL
    self.view = nil  -- 界面对象引用
    self.param = ""
end

function UIMatchSettlePage:initComponent(param)
    ---@type GGraph
    self.contentView = self.view:GetChild("contentView")

    self.Holder = self.contentView:GetChild("Holder")
    self.EndingIcon = self.contentView:GetChild("EndingIcon")
    self.ShowController = self.contentView:GetController("ShowController")

    self.ChallengePart = self.contentView:GetChild("ChallengePart")
    self.WinText = self.contentView:GetChild("WinText")
    self.RoundText = self.contentView:GetChild("RoundText")
    self.RewardList = self.contentView:GetChild("RewardList")
    self.ChallengeBtn = self.contentView:GetChild("Btn")

    self.DailyPart = self.contentView:GetChild("DailyPart")
    self.RankText = self.contentView:GetChild("RankText")
    self.MaxScoreText = self.contentView:GetChild("MaxScoreText")
    self.CoinGroup = self.contentView:GetChild("CoinGroup")
    self.RetryCoin = self.contentView:GetChild("RetryCoin")
    self.ConfirmBtn = self.contentView:GetChild("ConfirmBtn")
    self.RetryBtn = self.contentView:GetChild("RetryBtn")
    self.ScoreText = self.contentView:GetChild("ScoreText")

    self.MatchGroup = self.contentView:GetChild("MatchGroup")
    self.MatchFail = self.contentView:GetChild("MatchFail")
    self.MatchRankText = self.contentView:GetChild("MatchRankText")
    self.MatchMaxScoreText = self.contentView:GetChild("MatchMaxScoreText")
    self.MatchRewardList = self.contentView:GetChild("MatchRewardList")
    self.AgainBtn = self.contentView:GetChild("AgainBtn")
    self.CancelMatchBtn = self.contentView:GetChild("CancelMatchBtn")
    self.ResultTimeLabel = self.contentView:GetChild("ResultTimeLabel")
    self.MatchCostIcon = self.contentView:GetChild("MatchCostIcon")
    self.MatchCostCoin = self.contentView:GetChild("MatchCostCoin")
    self.ResultTimeGroup = self.contentView:GetChild("ResultTimeGroup")

    self.ConfirmBtn:onClick(self.onClickConfirm, self)
    self.CancelMatchBtn:onClick(self.onCancelMatchBtn, self)
    self.AgainBtn:onClick(self.onAgainBtn, self)
    self.ChallengeBtn:onClick(self.onChallengeClick, self)

    self.maxWin = 0
    self.matchData = {}
    self.challengeRewardListArr = {}
    self.matchRewardListArr = {}
end

function UIMatchSettlePage:StartGames(param)
    self.matchData = param
    self.maxWin = param.maxWin

    local seat = SeatRouter.instance.mySeat
    if seat then
        seat:closeAuto()
    end

    if param["type"] == "daily" then
        self:createEndingSpine(true)
        self.ShowController.selectedPage = "daily"
        self.RankText.text = "排名    [color=#fff053]" .. param["rank"] .. "/" .. param["total_num"] .. "[/color]"
        self.ScoreText.text = param["score"]
        self.MaxScoreText.text = "本场比赛最高得分：" .. param["max_score"]
        self.RetryCoin.text = self.matchData["consume_gold"]
    elseif param["type"] == "challenge" then
        if param["isWin"] then
            self.RoundText.text = "当前轮次：    [color=#fff053]" .. param["winCount"] .. "/" .. self.maxWin .. "[/color]"
        else
            self.RoundText.text = "当前轮次：    [color=#fff053]" .. param["winCount"] + 1 .. "/" .. self.maxWin .. "[/color]"
        end
        self.ShowController.selectedPage = "challenge"
        local winCount = self.matchData["winCount"]
        if param["isWin"] then
            self:createEndingSpine(true)
            self.EndingIcon.url = "ui://MatchSettle/shengli"
            if winCount < self.maxWin then
                self.RewardList.visible = false
                self.WinText.text = "点击确定继续挑战"
            else
                self.RewardList.visible = true
                local rewardsArr = self.matchData["award"]
                local rewardsItem = rewardsArr[winCount - 1]
                local rewards = {}
                for i, v in pairs(rewardsItem), 2 do
                    rewards[table.len(rewards) + 1] = { reward_item_id = rewardsItem[i], reward_item_num = rewardsItem[i + 1] }
                end
                self.WinText.text = "恭喜获得    [color=#fff053]挑战赛冠军[/color]"
                self.challengeRewardListArr = rewards
                self:updateItemReward()
            end
        else
            self:createEndingSpine(false)
            self.EndingIcon.url = "ui://MatchSettle/shibai"
            self.WinText.text = "本场比赛结束点击确定领取奖励"
            local rewardsArr = self.matchData["award"]
            if winCount == 0 then
                self.RewardList.visible = false
            else
                self.RewardList.visible = true
                local rewardsItem = {}
                rewardsItem = rewardsArr[winCount]
                local rewards = {}
                for i = 1, table.len(rewardsItem), 2 do
                    rewards[table.len(rewards) + 1] = { reward_item_id = rewardsItem[i], reward_item_num = rewardsItem[i + 1] }
                end
                self.challengeRewardListArr = rewards
                self:updateItemReward()
            end
        end
    elseif param["type"] == "match" then
        self.ShowController.selectedPage = "match"
        self:matchingSynResultMsg()
    end

    if not self.matchData.free_times then
        self.matchData.free_times = -1
    end
    if not self.matchData.consume_gold then
        self.matchData.consume_gold = -1
    end
    if self.matchData.free_times <= 0 and RoleInfoM.instance:getCoin() < self.matchData.consume_gold then
        self.RetryBtn.grayed = true
        self.RetryBtn:onClick(function()
            GameTip.showTip("金币不足")
        end)
    else
        self.RetryBtn.grayed = false
        self.RetryBtn:onClick(self.onClickRetry, self)
    end
end

function UIMatchSettlePage:matchingSynResultMsg()
    self.ShowController.selectedPage = "match"
    local msg = MatchM.instance.resultMsg
    if msg.rank == 1 then
        local rew = {}
        for i = 1, table.len(msg.reward_item_ids) do
            rew[table.len(rew) + 1] = { reward_num = "x" .. ActivityM.instance:exchangeConversion(msg.reward_item_ids[i], msg.reward_item_nums[i]),
                                        reward_id = cfg_goods.instance(msg.reward_item_ids[i]).icon }
        end

        self.matchRewardListArr = rew
        self.MatchRewardList.visible = true
        self:updateItemMatchReward()
        self.EndingIcon.url = "ui://MatchSettle/shengli"
        self.MatchFail.visible = false
        self:createEndingSpine(true)
    else
        self:createEndingSpine(false)
        self.EndingIcon.url = "ui://MatchSettle/shibai"
        self.MatchRewardList.visible = false
        self.MatchFail.visible = true
        self.MatchRankText.text = "排名    [color=#fff053]" .. msg.rank .. "/" .. msg.player_nums .. "[/color]"
        self.MatchMaxScoreText.text = "本场比赛最高得分：" .. msg.score
    end

    if msg.is_free then
        self.MatchCostIcon.url = cfg_goods.instance(msg.consume_ids[1]).icon
        self.MatchCostCoin.text = "免费"
    else
        self.MatchCostIcon.url = cfg_goods.instance(msg.consume_ids[1]).icon
        self.MatchCostCoin.text = msg.consume_nums[1]
    end
end

function UIMatchSettlePage:createEndingSpine(isWin)
    local prefabUrl = ""
    if isWin then
        prefabUrl = "Effects/MatchWin"
    else
        prefabUrl = "Effects/MatchFail"
    end
    local positon = Vector3.New(0, 0, 1000)
    self.endingAni = SpineManager.create(prefabUrl, positon, 1, self.Holder)
    --endingAni:play("animation", false, function()
    --    endingAni:destroy()
    --end)
    self.endingAni:play("animation", true)
end

function UIMatchSettlePage:updateItemMatchReward()
    self.MatchRewardList:RemoveChildrenToPool()
    for i, v in ipairs(self.matchRewardListArr) do
        local item = self.MatchRewardList:AddItemFromPool()
        local RewardIcon = item:GetChild("RewardIcon")
        local RewardText = item:GetChild("RewardText")

        RewardIcon.url = v.reward_id
        RewardText.text = v.reward_num
    end
end

function UIMatchSettlePage:updateItemReward()
    self.RewardList:RemoveChildrenToPool()
    for i, v in ipairs(self.challengeRewardListArr) do
        local item = self.RewardList:AddItemFromPool()
        local RewardIcon = item:GetChild("RewardIcon")
        local RewardText = item:GetChild("RewardText")

        RewardIcon.url = cfg_goods.instance(v.reward_item_id).icon
        RewardText.text = "x " .. ActivityM.instance:exchangeConversion(v.reward_item_id, v.reward_item_num)
    end
end

function UIMatchSettlePage:onClickConfirm()
    NetSender.ExitRoom();
    self:closePanel()
end

function UIMatchSettlePage:areaShareSuccess()
    NetSender.ExitRoom()
    NetSender.EnterMatchRoom( { id = self.matchData.contest_id, replay = true })
    self:closePanel()
end

function UIMatchSettlePage:onChallengeClick()
    if self.matchData["isWin"] then
        if self.matchData["winCount"] == self.maxWin then
            NetSender.ChallengeMatchReward( { id = self.matchData.contest_id })
        else
            NetSender.ExitRoom()
            if self.matchData["failCount"] == 1 then
                NetSender.EnterMatchRoom({ id = self.matchData.contest_id, replay = true })
            else
                NetSender.EnterMatchRoom( { id = self.matchData.contest_id, replay = false })
            end

            self:closePanel()
        end
    else
        NetSender.ChallengeMatchReward( { id = self.matchData.contest_id })
        NetSender:ExitRoom()
        self:closePanel()
    end
end

function UIMatchSettlePage:match_sign(contest_id, scene_id)
    LoginM.instance:setContestId(contest_id, scene_id)
end

---@param e EventContext
function UIMatchSettlePage:onClickRetry()
    local info = ConfirmTipInfo.New()
    info.content = "确认报名？"
    info.rightClick = function()
        self:ClickRetryCallBack()
    end
    info.autoCloseTime = 10
    GameTip.showConfirmTip(info)
end

function UIMatchSettlePage:ClickRetryCallBack()
    NetSender.ExitRoom()
    if "daily" == self.matchData.type then
        self:match_sign(self.matchData.contest_id, 5)
        self:OnEnterScene(5)
    end
    self:closePanel()
end

function UIMatchSettlePage:OnEnterScene(id)
    if LoginM.instance.contestId > 0 then
        if LoginM.instance.sceneId == GameConst.contest_match_scene_id and LoginM.instance.roomId > 0 then
            NetSender.EnterMatchRoom( { roomNumber = LoginM.instance.roomId })
        else
            NetSender.EnterMatchRoom( { id = LoginM.instance.contestId })
        end
    else
        NetSender.EnterRoom({ scene_id = id })
    end
end

function UIMatchSettlePage:onCancelMatchBtn(e)
    if LoginM.instance.pageId == GameConst.MAIN_PAGE then
        self:closePanel()
    else
        e:StopPropagation()
        self:tip()
    end
end

function UIMatchSettlePage:tip()
    local info = ConfirmTipInfo.new()
    info.content = "是否退出房间？"
    info.rightClick = function()
        self:closePanel()
        GameEventDispatch.instance:event(GameEvent.ReturnConfirm)
    end
    info.autoCloseTime = 10
    GameTip.showConfirmTip(info)
end

function UIMatchSettlePage:onAgainBtn()
    if LoginM.instance.pageId == GameConst.MAIN_PAGE then
        local info = ConfirmTipInfo.new()
        info.content = "确认报名？"
        info.rightClick = function()
            self:closePanel()
            MatchM.instance:initMatchingGameData()
            if MatchM.instance.resultMsg.type == "match" then
                self:match_sign(MatchM.instance.resultMsg.contest_id, 5)
            end
        end
        info.autoCloseTime = 10
        GameTip.showConfirmTip(info)
    else
        if FightM.instance:isMatchingGame() and MatchM.instance.isMatchStart == 1 then
            NetSender.ContinueMatchRoom()
            self:closePanel()
        end
    end
end

function UIMatchSettlePage:endChallengeAcceptReward()
    NetSender.ExitRoom()
    self:closePanel()
end

function UIMatchSettlePage:updateMatchingGamePanel()
    if self.MatchGroup.visible then
        if MatchM.instance.countDownTime > 0 then
            if MatchM.instance.tManSeat == -1 then
                self.ResultTimeGroup.visible = true
                MatchM.instance:matchCountDown(MatchM.instance.countDownTime, self.ResultTimeLabel)
            end
            Laya.timer:loop(1000, self, self.loopStart)
        else
            self.ResultTimeGroup.visible = false
        end
    end
end

function UIMatchSettlePage:loopStart()
    if self.MatchGroup.visible and MatchM.instance.countDownTime > 0 then
        MatchM.instance:matchContestTimeSub()
        MatchM.instance:matchCountDown(MatchM.instance.countDownTime, self.ResultTimeLabel)
    else
        if MatchM.instance.tManSeat == 1 then
            self.MatchGroup.visible = false
        end
    end
end

function UIMatchSettlePage:Register()
    self:AddRegister(GameEvent.EndAcceptChallengeMatchReward, self, self.endChallengeAcceptReward)
end

function UIMatchSettlePage:closePanel()
    if self.endingAni then
        self.endingAni:destroy()
    end
    UIManager:ClosePanel("MatchSettlePage", nil, true)
end

return UIMatchSettlePage