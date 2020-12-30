---@class UIRankPage :UIDialogBase
local UIRankPage = class("UIRankPage", UIDialogBase)
local ListManager = require("Manager.ListManager")

function UIRankPage:init()
    self.packageName = "Rank"
    self.resName = "RankPage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil

    self.select_type = 0--0-财富 1-实力
    self.list1Manager = nil

    ---@type number
    self.my_gold_rank = nil
    ---@type table
    self.my_gold_reward = { 1, 0 }
    ---@type number
    self.my_strength_rank = nil
    ---@type table
    self.my_strength_reward = { 1, 0 }
    ---@type table
    self.gold_rank_list = {}
    ---@type table
    self.strength_rank_list = {}
    self.strengthRankDes = "根据当日捕鱼消耗进行排名，排行榜每10分钟更新一次；[color=#ff0000]奖励只保留一天[/color]，请及时领取"
    self.coinRankDes = "根据携带金币数量进行排名，排行榜每10分钟更新一次；[color=#ff0000]奖励只保留一天[/color]，请及时领取"

    self.last_time = 0
    self.match_data = {}
    self.clickRewardBtn = { 0, 0 }
    ---@type table
    self._giveAwayArr = nil
end

function UIRankPage:initComponent()
    self.contentView = self.view:GetChild("contentView")

    self.list = self.contentView:GetChild("list1")

    self.firstBox = self.contentView:GetChild("firstBox")
    self.secondBox = self.contentView:GetChild("secondBox")
    self.thirdBox = self.contentView:GetChild("thirdBox")
    self.desHTML = self.contentView:GetChild("desHTML")
    self.quitBtn = self.contentView:GetChild("quitBtn")
    self.getRewardBtn = self.contentView:GetChild("getRewardBtn")
    --@type GButton
    self.goldBtn = self.contentView:GetChild("goldBtn")
    self.strengthBtn = self.contentView:GetChild("strengthBtn")
    self.wait = self.contentView:GetChild("wait")
    self.waitAni = self.view:GetTransition("waitAni")
    self.waitAni:Play()
    self.goldBox = self.contentView:GetChild("goldBox")
    self.gold_introduce = self.contentView:GetChild("gold_introduce")
    self.goldLabel = self.contentView:GetChild("goldLabel")
    self.goldImg = self.contentView:GetChild("goldImg")
    self.rankBox = self.contentView:GetChild("rankBox")
    self.rankIntroduce = self.contentView:GetChild("rankIntroduce")
    self.rankNum = self.contentView:GetChild("rankNum")

    self.getRewardBtn:onClick(self.onGetRewardBtn, self)
    self.quitBtn:onClick(self.onQuitClick, self)
    self.list1Manager = ListManager.creat(self.list, self.gold_rank_list, self.updateItem, self)
    self.goldBtn:onClick(self.onGoldBtn, self)
    self.strengthBtn:onClick(self.onStrengthBtn, self)
end

function UIRankPage:StartGames(param)
    self:hideBox()
    self.wait.visible = true
    self._giveAwayArr = {}
    if (ActivityM.instance:isShowMainRank()) then
        self._giveAwayArr = ActivityM.instance:_getCommonActivityConfig(FightConst.activity_common_main_rank)["h5"];
    end
    if (LoginM.instance.pageId == GameConst.FISH_PAGE) then
        if (LevelM.instance:coinRankLv() > 0) then
            if (LevelM.instance:strengthRankLv() > 0) then
                self:onStrengthBtn()
            else
                self:onGoldBtn();
            end
        else
            self:onStrengthBtn()
        end
    else
        self:onGoldBtn();
    end
end

function UIRankPage:updateItem(i, cell, data)
    local ele_player_name = cell:GetChild("player_name")
    local ele_rank = cell:GetChild("rank");
    local ele_bg = cell:GetChild("bg")
    local ele_image = cell:GetChild("playimg")
    local goldBox = cell:GetChild("goldBox")
    local item_num = cell:GetChild("item_num")
    local ele_name_bg = cell:GetChild("name_bg")
    local item_img = cell:GetChild("item_img")
    local doubleImg = cell:GetChild("doubleImg")
    local giveawayBox = cell:GetChild("giveawayBox")
    giveawayBox.visible = false;
    if (ActivityM.instance:isShowMainRank()) then
        local giveawayImg = cell:GetChild("giveawayImg")
        local giveawayLabel = cell:GetChild("giveawayLabel")
        if (self.select_type == 0) then
            giveawayImg.icon = cfg_goods.instance(tonumber(self._giveAwayArr["gold"][2 + i][1])).icon;
            giveawayLabel.text = tostring(self._giveAwayArr["gold"][2 + i][1]);
        else
            giveawayImg.icon = cfg_goods.instance(tonumber(_giveAwayArr["strength"][2 + i][1])).icon;
            giveawayLabel.text = tostring(self._giveAwayArr["strength"][2 + i][2]);
        end
        giveawayBox.visible = true;
    end

    goldBox.visible = false;
    doubleImg.visible = false;
    if (#data['reward'] > 0) then
        item_num.text = tostring(data['reward'][2])
        item_img.icon = cfg_goods.instance(tonumber(data['reward'][1])).waceIcon;
        goldBox.visible = true;
        if (LevelM.instance:getRankDoubleReward()) then
            doubleImg.visible = true;
        end
    end

    ele_player_name.text = data["nickname"];
    ---TODO if (GameTools:getStringTrueLength(data["nickname"]) > 14)
    if (#tostring(data["nickname"])) > 14 then
        ele_player_name.textFormat.size = 30;
    else
        ele_player_name.textFormat.size = 36;
    end
    ele_rank.visible = false
    GameTools.loadHeadImage(ele_image, data["avatar"])
    ele_rank.visible = true;

    ele_rank.text = tostring(i + 3)
end

function UIRankPage:hideBox(visible)
    if visible == nil then
        visible = false
    end
    self.firstBox.visible = visible
    self.secondBox.visible = visible
    self.thirdBox.visible = visible
    self.list.visible = visible
end

function UIRankPage:onStrengthBtn()
    self.select_type = 1
    self.desHTML.text = self.strengthRankDes;
    self:getRankList()
    --self.list:ScrollToView(1)
    self.goldBtn.selected = false
    self.strengthBtn.selected = true
end

function UIRankPage:onGoldBtn()
    self.select_type = 0
    self:getRankList()
    self.desHTML.text = self.coinRankDes;
    --self.list:ScrollToView(1)
    self.goldBtn.selected = true
    self.strengthBtn.selected = false
end

function UIRankPage:onQuitClick()
    UIManager:ClosePanel("RankPage")
    if (LoginM.instance.pageId == FightConst.FISH_PAGE) then
        local info = ConfirmTipInfo.new();
        if (LevelM.instance:todayCoinIsHaveReward() or LevelM.instance:todayStrIsHaveReward()) then
            info.content = "保持当前排名，明日登录即可领取排名奖励！"
        else
            info.content = "进入排行榜，明日登录即可领取排名奖励！"
        end
        if (RoleInfoM.instance:subsState(1) == false) then
            info.leftClick = function()
                GameEventDispatch.instance:Event(GameEvent.RankAniRefesh)
                self:comfirmHandler()
            end
            info.rightClick = function()
                self:comfirmHandler()
                GameEventDispatch.instance:Event(GameEvent.RankAniRefesh)
            end
        end
        info.autoCloseTime = 10;
        GameTip.showConfirmTip(info)
    end
end

function UIRankPage:comfirmHandler()
    --TODO 渔场内的金元宝
    if (RoleInfoM.instance:subscribeState(1) == 0) then
        --local info = QuitTipInfo.New()
        --info.state = GameConst.quit_state_mid_confirm_subscibe;
        --info.commonMsg = GameEvent.OpenSubscibe;
        --info.content = ""
        --info.middleTxt = "订阅"
        --info.isHaveTime = false;
        --GameEventDispatch.instance:Event(GameEvent.QuitTip, info);
    else
        GameEventDispatch.instance:Event(GameEvent.OpenSubscibe);
    end
end

function UIRankPage:getRankList(interval)

    if not interval then
        interval = true
    end

    local token = LoginInfoM:getUserToken();
    local cur_time = os.time()
    if interval then
        if ((cur_time - self.last_time) > 3) then
            self.last_time = cur_time
            self.wait.visible = true
            ApiManager.instance:Get_Rank_List(token, nil, function(result)
                LevelM.instance:setTodayStrIsHaveReward(result)
                self.match_data = result.data
                self:setDate();
            end)
        else
            self:setDate();
        end
    else
        self.last_time = cur_time
        self.wait.visible = true;
        ApiManager.instance:Get_Rank_List(token, nil, function(result)
            self.match_data = result.data
            self:setDate();
            self.wait.visible = false;
        end)
    end
end

function UIRankPage:setDate()
    self.my_gold_rank = self.match_data["gold_top_me"];
    self.my_strength_rank = self.match_data["strength_top_me"];
    self.gold_rank_list = self.match_data["gold_top"];
    self.strength_rank_list = self.match_data["strength_top"]
    if (self.gold_rank_list[self.my_gold_rank] and #(self.gold_rank_list[self.my_gold_rank].reward) > 0) then
        if (LevelM.instance:getRankDoubleReward()) then
            self.my_gold_reward = { self.gold_rank_list[self.my_gold_rank].reward[1],
                                    (tonumber(self.gold_rank_list[self.my_gold_rank].reward[2]) * 2) }
        else
            self.my_gold_reward = self.gold_rank_list[self.my_gold_rank].reward;
        end
    else
        self.my_gold_reward = { 1, 0 }
    end
    if (self.strength_rank_list[self.my_strength_rank] and #(self.strength_rank_list[self.my_strength_rank].reward) > 0) then
        if (LevelM.instance:getRankDoubleReward()) then
            self.my_strength_reward = { self.strength_rank_list[self.my_strength_rank].reward[1],
                                        (tonumber(self.strength_rank_list[self.my_strength_rank].reward[2]) * 2) };
        else
            self.my_strength_reward = self.strength_rank_list[self.my_strength_rank].reward
        end
    else
        self.my_strength_reward = { 1, 0 }
    end
    self:synRankReward();
end

function UIRankPage:synRankReward()
    self.rankBox.visible = false;
    self.goldBox.visible = false;
    self.getRewardBtn.visible = false;
    self.clickRewardBtn = { 0, 0 }
    local rankNum = -1;
    local rankReward = -1;
    if (0 == self.select_type) then
        local a = LevelM.instance:coinReward();
        if (#a > 0) then
            self.rankIntroduce.text = "昨日排名："
            self.gold_introduce.text = "昨日奖励："
            rankReward = LevelM.instance:coinReward()[2];
            rankNum = LevelM.instance:coinRankLv();
            if (rankReward > 0) then
                self.getRewardBtn.visible = true;
            end
        else
            self.rankIntroduce.text = "我的排名："
            self.gold_introduce.text = "我的奖励："
            rankReward = self.my_gold_reward[2];
            rankNum = self.my_gold_rank;
        end
        if (#self.gold_rank_list <= 0) then
            self:hideBox(false)
        else
            self.list1Manager:update(GameTools.tableSlice(self.gold_rank_list, 4))
            self.list.visible = true;
            local temp = #GameTools.tableSlice(self.gold_rank_list, 1, 4)
            self.firstBox.visible = temp >= 1;
            self.secondBox.visible = temp >= 2;
            self.thirdBox.visible = temp >= 3;
            if (self.firstBox.visible) then
                self.firstBox.data = self.gold_rank_list[1]
                self:initRankBox(self.firstBox, 0);
            end
            if (self.secondBox.visible) then
                self.secondBox.data = self.gold_rank_list[2]
                self:initRankBox(self.secondBox, 1);
            end
            if (self.thirdBox.visible) then
                self.thirdBox.data = self.gold_rank_list[3]
                self:initRankBox(self.thirdBox, 2)
            end
        end
    else
        local a = LevelM.instance:strengthReward()
        if (#a > 0) then
            self.rankIntroduce.text = "昨日排名："
            self.gold_introduce.text = "昨日奖励："
            rankReward = LevelM.instance:strengthReward()[2];
            rankNum = LevelM.instance:strengthRankLv();
            if (rankReward > 0) then
                self.getRewardBtn.visible = true;
            end
        else
            self.rankIntroduce.text = "我的排名："
            self.gold_introduce.text = "我的奖励："
            rankReward = self.my_strength_reward[2];
            rankNum = self.my_strength_rank;
        end
        if (#self.gold_rank_list <= 0) then
            self:hideBox(false)
        else
            self.list1Manager:update(GameTools.tableSlice(self.strength_rank_list, 4))
            self.list.visible = true;
            local temp = #GameTools.tableSlice(self.strength_rank_list, 1, 4)
            self.firstBox.visible = temp >= 1;
            self.secondBox.visible = temp >= 2;
            self.thirdBox.visible = temp >= 3;
            if (self.firstBox.visible) then
                self.firstBox.data = self.strength_rank_list[1]
                self:initRankBox(self.firstBox, 0);
            end
            if (self.secondBox.visible) then
                self.secondBox.data = self.strength_rank_list[2]
                self:initRankBox(self.secondBox, 1);
            end
            if (self.thirdBox.visible) then
                self.thirdBox.data = self.strength_rank_list[3]
                self:initRankBox(self.thirdBox, 2)
            end
        end
    end
    self.goldImg.icon = cfg_goods.instance(tonumber(self.my_gold_reward[1])).waceIcon;
    self.goldLabel.text = tostring(rankReward);
    if ((rankNum > 1000) or (rankNum <= 0)) then
        self.rankNum.text = "未上榜"
    else
        self.rankNum.text = tostring(rankNum)
    end
    self.rankBox.visible = true;
    self.goldBox.visible = true;
    self.wait.visible = false;
end

function UIRankPage:initRankBox(box, index)
    local config = box.data;
    local ele_img = box:GetChild("img")
    local ele_doubleImg = box:GetChild("doubleImg")
    local item_img = box:GetChild("item_img")
    local ele_nameLabel = box:GetChild("nameLabel")
    local ele_coinLable = box:GetChild("coinLable")
    local ele_giveawayBox = box:GetChild("giveawayBox")
    local ele_giveawayImg = box:GetChild("giveawayImg")
    local ele_giveawayLabel = box:GetChild("giveawayLabel")
    ele_doubleImg.visible = false;
    ele_giveawayBox.visible = false;
    if (LoginM.instance:getIsNovicePlayer() == 1 and config.is_hide == true) then
        ele_nameLabel.text = LoginM.instance:getReplaceRankName();
    else
        local nameTxt = GameTools.filterName(config["nickname"])
        if nameTxt then
            ele_nameLabel.text = nameTxt
        else
            ele_nameLabel.text = ""
        end
    end
    GameTools.loadHeadImage(ele_img, config["avatar"])
    ele_coinLable.visible = false;
    item_img.visible = false;
    if (#config['reward'] > 0) then
        ele_coinLable.text = tostring(config['reward'][2])
        item_img.icon = cfg_goods.instance(tonumber(config['reward'][1])).waceIcon;
        ele_coinLable.visible = true;
        item_img.visible = true;
        if (LevelM.instance:getRankDoubleReward()) then
            ele_doubleImg.visible = true;
        end
    end
    if (ActivityM.instance:isShowMainRank()) then
        if (self.select_type == 0) then
            ele_giveawayImg.icon = cfg_goods.instance(self._giveAwayArr["gold"][index][1]).icon;
            ele_giveawayLabel.text = tostring(self._giveAwayArr["gold"][index][2]);
        else
            ele_giveawayImg.icon = cfg_goods.instance(_giveAwayArr["strength"][index][1]).icon;
            ele_giveawayLabel.text = tostring(_giveAwayArr["strength"][index][2]);
        end
        ele_giveawayBox.visible = true;
    end
end

function UIRankPage:onGetRewardBtn()
    if (self.clickRewardBtn[self.select_type + 1] <= 0) then
        self.clickRewardBtn[self.select_type + 1] = 1;
        NetSender.GetRankReward( { type = (self.select_type + 1) });
    else
        GameTip.showTip("正在领取奖励，请勿频繁点击")
    end
end

function UIRankPage:refreshRankList()
    self:getRankList(false)
end


--@override 注册事件监听
function UIRankPage:Register()
    self:AddRegister(tostring(42003), self, self.refreshRankList);
    self:AddRegister(GameEvent.SyncActivityStatus, self, self.setDate);
    self:AddRegister(GameEvent.SynRankReward, self, self.synRankReward);
end

return UIRankPage