---@class UIMatchPage :UIDialogBase
local UIMatchPage = class("UIMatchPage", UIDialogBase)

function UIMatchPage:init()
    self.packageName = "Match"
    self.resName = "MatchPage"
    self.uiType = UIType.UI_TYPE_NORMAL
    self.view = nil  -- 界面对象引用
    self.param = ""
end

function UIMatchPage:initComponent(param)
    --- 接口缓存毫秒数
    self.CacheTime = 5000
    self.contentView = self.view:GetChild("contentView")
    self.AwardList = self.contentView:GetChild("AwardList")
    self.DailyBtn = self.contentView:GetChild("DailyBtn")
    self.ChallengeBtn = self.contentView:GetChild("ChallengeBtn")
    self.MatchBtn = self.contentView:GetChild("MatchBtn")
    self.AwardBtn = self.contentView:GetChild("AwardBtn")
    self.RoomNumText = self.contentView:GetChild("RoomNumText")
    self.JoinBtn = self.contentView:GetChild("JoinBtn")
    self.CloseBtn = self.contentView:GetChild("CloseBtn")
    self.BtnController = self.contentView:GetController("BtnController")

    self.RoomNumText = self.contentView:GetChild("RoomNumText")
    self.JoinBtn = self.contentView:GetChild("JoinBtn")

    self.RankGroup = self.contentView:GetChild("RankPageItem")
    self.RankMask = self.RankGroup:GetChild("RankMask")
    self.MatchTitleText = self.RankGroup:GetChild("MatchTitleText")
    self.RankController = self.RankGroup:GetController("RankController")
    self.DailyGroup = self.RankGroup:GetChild("DailyGroup")
    self.DailyList = self.RankGroup:GetChild("DailyList")
    self.MyRankText = self.RankGroup:GetChild("MyRankText")
    self.ChallengeGroup = self.RankGroup:GetChild("ChallengeGroup")
    self.ChallengeList = self.RankGroup:GetChild("ChallengeList")
    self.MatchGroup = self.RankGroup:GetChild("MatchGroup")
    self.MatchList = self.RankGroup:GetChild("MatchList")
    self.RankRuleBtn = self.RankGroup:GetChild("RuleBtn")
    self.RankJoinBtn = self.RankGroup:GetChild("JoinBtn")
    self.CloseRankGroupBtn = self.RankGroup:GetChild("CloseRankGroupBtn")

    self.RuleGroup = self.contentView:GetChild("RulePageItem")
    self.RuleMask = self.RuleGroup:GetChild("RuleMask")
    self.RuleMatchType = self.RuleGroup:GetChild("RuleMatchType")
    self.RuleMatchTime = self.RuleGroup:GetChild("RuleMatchTime")
    self.RuleMatchLong = self.RuleGroup:GetChild("RuleMatchLong")
    self.RuleMatchBattery = self.RuleGroup:GetChild("RuleMatchBattery")
    self.RuleMatchDesc = self.RuleGroup:GetChild("RuleMatchDesc")
    self.CloseRuleBtn = self.RuleGroup:GetChild("CloseRuleBtn")

    self.BtnController.onChanged:Set(self.onBtnControllerChanged, self)
    self.JoinBtn:onClick(self.onJoinBtn, self)
    self.CloseBtn:onClick(self.closePanel, self)

    self.RankRuleBtn:onClick(function()
        self.RuleGroup.visible = true
    end)

    self.CloseRankGroupBtn:onClick(function()
        self.RankGroup.visible = false
    end)
    self.CloseRuleBtn:onClick(function()
        self.RuleGroup.visible = false
    end)
end

function UIMatchPage:StartGames(param)
    self.BtnController.selectedPage = "daily"
    self:addActivityPointShow()
    self.RankGroup.visible = false
    self.RuleGroup.visible = false
    self.RoomNumText.text = ""
    self:onBtnControllerChanged()
end

function UIMatchPage:onJoinBtn()
    local value = self.RoomNumText.text
    if is_empty(value) then
        GameTip.showTip("请输入正确的房间号")
    else
        LoginM.instance.roomId = value
        NetSender.FindMatchRoom({ roomNumber = LoginM.instance.roomId })
    end
end

function UIMatchPage:initListItem()
    self.AwardList:RemoveChildrenToPool()
    for i = 1, table.len(self.matchListArr) do
        local item = self.AwardList:AddItemFromPool()
        ---@type GLoader
        local HeadIcon = item:GetChild("HeadIcon")
        local MatchNameText = item:GetChild("MatchNameText")
        local TimeText = item:GetChild("TimeText")
        ---@type GButton
        local BtnWen = item:GetChild("BtnWen")
        ---@type GList
        local AwardItemList = item:GetChild("AwardItemList")
        local Button = item:GetChild("Button")

        self:upDateSignBtn(Button, self.matchListArr[i])

        TimeText.text = os.date("%H:%M", self.matchListArr[i].start_time) .. "~"
                .. os.date("%H:%M", self.matchListArr[i].end_time)

        if self.matchListArr[i].is_win then
            TimeText.visible = false
            MatchNameText.text = self.matchListArr[i].contest_name
            local rewardsArr = self.matchListArr[i].reward_set[1]
            local rewards = {}
            for j = 1, table.len(rewardsArr), 2 do
                rewards[table.len(rewards) + 1] = { reward_item_id = rewardsArr[j],
                                                    reward_item_num = rewardsArr[j + 1] }
            end
            self:initAwardItem(AwardItemList, rewards)
            HeadIcon.url = cfg_goods.instance(rewardsArr[1]).icon

            item.onClick:Set(function()
                self:onDailyMatchClick(self.matchListArr[i])
            end, self)
        else
            TimeText.visible = true
            if self.matchListArr[i].type == "daily" then
                item.onClick:Set(function()
                    self:onDailyMatchClick(self.matchListArr[i])
                end, self)
            elseif self.matchListArr[i].type == "challenge" then
                item.onClick:Set(function()
                    self:onChallengeMatchClick(self.matchListArr[i])
                end, self)
            elseif self.matchListArr[i].type == "match" then
                item.onClick:Set(function()
                    self:onMatchMatchClick(self.matchListArr[i])
                end, self)
            end

            MatchNameText.text = self.matchListArr[i].name
            local rewardsArr = self.matchListArr[i].reward_set
            local showRewards = {}
            if self.matchListArr[i].type == "match" then
                showRewards = rewardsArr["4"][1]
            elseif self.matchListArr[i].type == "challenge" then
                showRewards = rewardsArr[table.len(rewardsArr)]
            else
                showRewards = rewardsArr[1]
            end
            HeadIcon.url = cfg_goods.instance(showRewards[1]).icon
            local rewards = {}
            for k = 1, table.len(showRewards), 2 do
                rewards[table.len(rewards) + 1] = {
                    reward_item_id = showRewards[k],
                    reward_item_num = showRewards[k + 1]
                }
            end

            self:initAwardItem(AwardItemList, rewards)
        end

        -- TODO 不知道是什么
        --GameTools.getImageScale(match_head_icon_img)
    end
end

function UIMatchPage:onDailyMatchClick(data)
    self.selectMatchData = data
    self.RankGroup.visible = true
    self.RankController.selectedPage = "daily"

    self.MatchTitleText.text = self.selectMatchData["name"]
    self:getMatchRank()
    self:initRule()
    self:upDateSignBtn(self.RankJoinBtn, self.selectMatchData)
end

function UIMatchPage:onChallengeMatchClick(data)
    self.selectMatchData = data
    self.RankGroup.visible = true
    self.RankController.selectedPage = "challenge"

    self.MatchTitleText.text = self.selectMatchData["name"]
    self.challengeRankList = {}
    --self.challengeRankList = self.selectMatchData["reward_set"]
    local arr = table.copy(self.selectMatchData["reward_set"])
    self.challengeRankList = table.reverseTable(arr)
    self:updateChallengeRankItem()
    self:initRule()
    self:upDateSignBtn(self.RankJoinBtn, self.selectMatchData)
end

function UIMatchPage:onMatchMatchClick(data)
    self.selectMatchData = data
    self.RankGroup.visible = true
    self.RankController.selectedPage = "challenge"

    self.MatchTitleText.text = self.selectMatchData["name"]
    self.challengeRankList = {}
    self.challengeRankList[table.len(self.challengeRankList) + 1] = self.selectMatchData["reward_set"]["2"]
    self.challengeRankList[table.len(self.challengeRankList) + 1] = self.selectMatchData["reward_set"]["3"]
    self.challengeRankList[table.len(self.challengeRankList) + 1] = self.selectMatchData["reward_set"]["4"]
    self:updateChallengeRankItem()
    self:initRule()
    self:upDateSignBtn(self.RankJoinBtn, self.selectMatchData)
end

function UIMatchPage:initRule()
    if self.BtnController.selectedPage == "daily" then
        self.RuleMatchType.text = "日常赛"
    elseif self.BtnController.selectedPage == "challenge" then
        self.RuleMatchType.text = "挑战赛"
    elseif self.BtnController.selectedPage == "match" then
        self.RuleMatchType.text = "匹配赛"
    end

    local startTime = os.date("%H:%M", self.selectMatchData["start_time"])
    local endTime = os.date("%H:%M", self.selectMatchData["end_time"])
    self.RuleMatchTime.text = startTime .. "~" .. endTime
    self.RuleMatchLong.text = self.selectMatchData.continue_time .. "秒"
    local cfg = cfg_scene.instance(self.selectMatchData.scene_id)
    self.RuleMatchBattery.text = cfg_battery.instance(cfg.unlock).comsume .. "倍炮解锁"
    self.RuleMatchDesc.text = cfg.description
end

function UIMatchPage:initAwardItem(itemList, listArr)
    itemList:RemoveChildrenToPool()
    for i = 1, table.len(listArr) do
        local item = itemList:AddItemFromPool()
        ---@type GLoader
        local AwardLoader = item:GetChild("AwardLoader")
        local AwardText = item:GetChild("AwardText")

        AwardLoader.url = cfg_goods.instance(listArr[i].reward_item_id).icon
        AwardText.text = "x " .. ActivityM.instance:exchangeConversion(listArr[i].reward_item_id, listArr[i].reward_item_num);
    end
end

function UIMatchPage:upDateSignBtn(item, data)
    ---@type GButton
    local Btn = item:GetChild("Button")
    local BtnIcon = item:GetChild("BtnIcon")
    local BtnText = item:GetChild("BtnText")
    local BtnNumText = item:GetChild("BtnNumText")

    BtnText.grayed = false
    Btn.grayed = false
    BtnIcon.visible = false
    BtnNumText.visible = false
    if is_empty(data["consume_goods_id"]) then
        data["consume_goods_id"] = 1
    end

    BtnIcon.url = cfg_goods.instance(data["consume_goods_id"]).waceIcon

    local cfg = cfg_scene.instance(data.scene_id)
    --Btn:SetSize()
    Btn.onTouchBegin:Set(
            function(e)
                e:StopPropagation()
                item:SetScale(0.8,0.8)
            end)
    if data.is_win then
        BtnText.visible = true
        BtnText.text = "领取"
        Btn:onClick(
                function(e)
                    e:StopPropagation()
                    local info = { contest_id = data.contest_id }
                    NetSender.DailyMatchReward(info)

                    --GameTip.showTip("敬请期待")
                end)
    else
        if data.execute_status == "not_start" then
            BtnText.text = "免费报名"
            BtnText.grayed = true
            Btn.grayed = true
            Btn:onClick(function(e)
                e:StopPropagation()
                GameTip.showTip("比赛未开始")
            end)
        elseif data.execute_status == "end" then
            BtnNumText.visible = false
            BtnText.text = "已过期"
            BtnText.visible = true
            BtnText.grayed = true
            Btn.grayed = true
            Btn:onClick(function(e)
                e:StopPropagation()
                GameTip.showTip("比赛已结束")
            end)
        elseif data.execute_status == "start" then
            if data.free_times > 0 then
                BtnText.text = "免费报名"
                BtnNumText.visible = false
                BtnText.visible = true
            else
                BtnText.visible = false
                BtnNumText.visible = true
                BtnIcon.visible = true
                BtnNumText.text = data.consume_gold
            end

            if RoleInfoM.instance:getBattery() >= cfg.unlock then
                if not RoleInfoM.instance:isConsumeEnough(data.consume_goods_id, data.consume_gold)
                        and data.free_times <= 0 then
                    BtnText.grayed = true
                    BtnIcon.grayed = true
                    BtnNumText.grayed = true
                    Btn.grayed = true
                    Btn:onClick(function(e)
                        e:StopPropagation()
                        if data.consume_goods_id == GameConst.currency_coin then
                            GameTip.showTip("金币不足")
                        elseif data.consume_goods_id == GameConst.currency_diamond then
                            GameTip.showTip("钻石不足")
                        else
                            GameTip.showTip("鱼雷不足")
                        end
                    end)
                else
                    local content = "确认报名？"
                    if data.free_times > 0 then
                        content = "确认报名\n（本场比赛可免费进行）"
                    else
                        if data.consume_goods_id == GameConst.currency_coin then
                            content = "确认报名\n（本场比赛需花费" .. data.consume_gold .. "金币）"
                        elseif data.consume_goods_id == GameConst.currency_diamond then
                            content = "确认报名\n（本场比赛需花费" .. data.consume_gold .. "钻石）"
                        else
                            content = "确认报名\n（本场比赛需花费" .. data.consume_gold .. "枚普通鱼雷）"
                        end
                    end

                    Btn:onClick(function(e)
                        e:StopPropagation()
                        local info = ConfirmTipInfo.new()
                        info.content = content
                        info.rightClick = function()
                            self:matchSign(data)
                        end
                        info.autoCloseTime = 10
                        GameTip.showConfirmTip(info)
                    end)
                end
            else
                Btn.grayed = true
                BtnIcon.grayed = true
                BtnText.grayed = true
                BtnNumText.grayed = true
                Btn:onClick(function(e)
                    e:StopPropagation()
                    GameTip.showTip(cfg_battery.instance(cfg.unlock).comsume .. "倍炮解锁")
                end)

            end
        end

    end
    Btn.onTouchEnd:Set(
            function(e)
                e:StopPropagation()
                item:SetScale(1,1)
            end)
end

function UIMatchPage:matchSign(data)
    MatchM.instance:initMatchingGameData()
    LoginM.instance:setContestId(data.id, data.scene_id)
    self:OnEnterScene(data)
end

function UIMatchPage:OnEnterScene(data)
    if tonumber(LoginM.instance.contestId) > 0 then
        if tonumber(LoginM.instance.sceneId) == GameConst.contest_match_scene_id and tonumber(LoginM.instance.roomId) > 0 then
            NetSender.EnterMatchRoom( { roomNumber = LoginM.instance.roomId })
        else
            NetSender.EnterMatchRoom( { id = LoginM.instance.contestId })
        end
    else
        NetSender.EnterRoom({ scene_id = data.scene_id })
    end
end

function UIMatchPage:getMatchRank()
    local token = LoginInfoM:getUserToken()
    local MatchRankArr = {}
    local RewardsArr = self.selectMatchData.reward_set

    for i, v in ipairs(RewardsArr) do
        local rewards = {}
        for j = 1, table.len(v), 2 do
            rewards[table.len(rewards) + 1] = {
                reward_item_id = v[j], reward_item_num = v[j + 1]
            }
        end
        MatchRankArr[table.len(MatchRankArr) + 1] = {rewards = rewards, rank = i + 1 }
    end

    local matchId = nil
    if self.selectMatchData["is_win"] then
        matchId = self.selectMatchData.contest_id
    else
        matchId = self.selectMatchData.id
    end

    ApiManager.instance:GetContestDailyRankList(token, matchId, nil, function(result)
        if is_empty(result) then
            Log.debug("获取胜利比赛列表出错")
            Log.debug(encode(result))
        else
            local data = result.data
            Log.debug(encode(data["top"]))

            for i, v in ipairs(data["top"]) do
                MatchRankArr[i].avatar = v.avatar
                MatchRankArr[i].nickname = v.nickname
                MatchRankArr[i].integral = v.integral
            end

            self.dailyRankList = MatchRankArr
            if tonumber(data["max_place"]) > 0 then
                self.MyRankText.text = data["max_place"]
            else
                self.MyRankText.text = "未上榜"
            end
            self:updateDailyRankItem()
        end
    end)
end

function UIMatchPage:updateDailyRankItem()
    self.DailyList:RemoveChildrenToPool()
    for i, v in pairs(self.dailyRankList) do
        local item = self.DailyList:AddItemFromPool()
        local RankText = item:GetChild("RankText")
        local RankIcon = item:GetChild("RankIcon")
        local PlayerIcon = item:GetChild("PlayerIcon")
        local PlayerName = item:GetChild("PlayerName")
        local LevelText = item:GetChild("LevelText")
        local AwardList = item:GetChild("AwardList")
        local PointText = item:GetChild("PointText")

        RankText.visible = false
        RankIcon.visible = false

        if i < 4 then
            RankIcon.visible = true
            RankIcon.url = "ui://Match/rank" .. i
        else
            RankText.visible = true
            RankText.text = i
        end
        GameTools.loadHeadImage(PlayerIcon, v.avatar)
        if is_empty(v.nickname) then
            PlayerName.text = ""
        else
            PlayerName.text = v.nickname
        end

        if not is_empty(v.integral) and v.integral >= 0 then
            PointText.text = v.integral
        else
            PointText.text = ""
        end

        if is_empty(v.level) then
            LevelText.text = v.level
        else
            LevelText.text = ""
        end

        self:initAwardItem(AwardList, v.rewards)
    end
end

function UIMatchPage:updateChallengeRankItem()
    self.ChallengeList:RemoveChildrenToPool()

    for i, v in pairs(self.challengeRankList) do
        local item = self.ChallengeList:AddItemFromPool()
        local RankText = item:GetChild("RankText")
        local RewardList = item:GetChild("RewardList")

        local rewardsSet = {}
        if self.selectMatchData["type"] == "match" then
            RankText.text = i + 1 .. "人局"
            rewardsSet = v[1]
        else
            RankText.text = "第" .. self.selectMatchData["max_second"] + 1 - i .. "轮"
            rewardsSet = v
        end

        local rewards = {}
        for j = 1, table.len(rewardsSet), 2 do
            rewards[table.len(rewards) + 1] = { reward_item_id = rewardsSet[j], reward_item_num = rewardsSet[j + 1] }
        end
        self:initAwardItem(RewardList, rewards)
    end
end

function UIMatchPage:addActivityPointShow()
    local vertical_h = 10
    local horizontal_percent = 0.75

    if ActivityM.instance.isShowDayMatchRebate then
        RedPointC.instance:removeSpinePoint(self.DailyBtn)
        RedPointC.instance:addSpinePointToIcon(self.DailyBtn, horizontal_percent, vertical_h, false)
    else
        RedPointC.instance:removeSpinePoint(self.DailyBtn)
    end
end

function UIMatchPage:onBtnControllerChanged()
    self:getMatchList()
    self:getWinMatchData()
end

function UIMatchPage:getWinMatchData()
    local token = LoginInfoM:getUserToken()
    ApiManager.instance:GetNotReceiveReward(token, self, self.getWinMatchDataCallback)
end

function UIMatchPage:getMatchList()
    --TODO 时间间隔
    local token = LoginInfoM:getUserToken()
    ApiManager.instance:GetMatchList(token, self, self.getMatchListCallback)
end

function UIMatchPage:getWinMatchDataCallback(result)
    if is_empty(result) then
        Log.debug("获取胜利比赛列表出错")
        Log.debug(encode(result))
    else
        self.winMatchData = result.data
        self:setMatchListData()
    end
end

function UIMatchPage:getMatchListCallback(result)
    if is_empty(result) then
        Log.debug("获取胜利比赛列表出错")
        Log.debug(encode(result))
    else
        self.matchData = result.data
        self:setMatchListData()
    end
end

function UIMatchPage:setMatchListData()
    if not is_empty(self.matchData) then
        self.indexMatchList = self.matchData[self.BtnController.selectedPage]
    end
    if not is_empty(self.winMatchData) then
        self.indexWinMatchList = self.winMatchData[self.BtnController.selectedPage]
    end

    if is_empty(self.indexMatchList) then
        return
    end

    if not is_empty(self.indexWinMatchList) then
        for i = 1, table.len(self.indexWinMatchList) do
            self.indexWinMatchList[i].is_win = true
            self.indexWinMatchList[i].name = self.indexWinMatchList[i].contest_name
        end
    end

    if not is_empty(self.indexMatchList) then
        for i = 1, table.len(self.indexMatchList) do
            self.indexMatchList[i].is_win = false
        end

    end

    local notStartArr = {}
    local StartArr = {}
    local endArr = {}

    for i = 1, table.len(self.indexMatchList) do
        local status = self.indexMatchList[i].execute_status
        if status == "not_start" then
            notStartArr[table.len(notStartArr) + 1] = self.indexMatchList[i]
        elseif status == "start" then
            if self.indexMatchList[i].sub_type == 2 then
                table.insert(StartArr, 1, self.indexMatchList[i])
            else
                StartArr[table.len(StartArr) + 1] = self.indexMatchList[i]
            end
        elseif status == "end" then
            endArr[table.len(endArr) + 1] = self.indexMatchList[i]
        end
    end

    local list1 = table.concatTable(notStartArr, endArr)
    local list2 = table.concatTable(StartArr, list1)
    self.matchListArr = table.concatTable(self.indexWinMatchList, list2)

    self:initListItem()
end

function UIMatchPage:endDailyAcceptReward()
    self.BtnController.selectedPage = "daily"
    self:onBtnControllerChanged()
    self.RankGroup.visible = false
end

function UIMatchPage:synFindMatchGameData()
    if not RoleInfoM.instance:isConsumeEnough(MatchM.instance.findRoomData.costId, MatchM.instance.findRoomData.costNum)
            and not MatchM.instance.findRoomData.isFree then
        if MatchM.instance.findRoomData.costId == GameConst.currency_coin then
            GameTip:showTip("金币不足")
        elseif MatchM.instance.findRoomData.costId == GameConst.currency_diamond then
            GameTip:showTip("钻石不足")
        else
            GameTip.showTip("鱼雷不足")
        end
    else
        local content = "确认报名？"
        if MatchM.instance.findRoomData.isFree then
            content = "确认报名\n（本场比赛可免费进行）"
        else
            if MatchM.instance.findRoomData.costId == GameConst.currency_coin then
                content = "确认报名\n（本场比赛需花费" .. MatchM.instance.findRoomData.costNum .. "金币）"
            elseif MatchM.instance.findRoomData.costId == GameConst.currency_diamond then
                content = "确认报名\n（本场比赛需花费" .. MatchM.instance.findRoomData.costNum .. "钻石）"
            else
                content = "确认报名\n（本场比赛需花费" .. MatchM.instance.findRoomData.costNum .. "枚普通鱼雷）"
            end
        end

        local info = ConfirmTipInfo.new()
        info.content = content
        info.rightClick = function()
            self:joinRoomSuccess()
        end
        info.autoCloseTime = 10
        GameTip.showConfirmTip(info)
    end
end

function UIMatchPage:joinRoomSuccess()
    LoginM.instance:setContestId(LoginM.instance.roomId, GameConst.contest_match_scene_id)
    self:OnEnterScene()
end

function UIMatchPage:closePanel()
    UIManager:ClosePanel("MatchPage", nil, true)
end

function UIMatchPage:Register()
    self:AddRegister(GameEvent.EndAcceptDailyMatchReward, self, self.endDailyAcceptReward)
    self:AddRegister(GameEvent.SynFindMatchGameData, self, self.synFindMatchGameData)
end

return UIMatchPage