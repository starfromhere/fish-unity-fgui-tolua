---@class FishDeadEffect
---@field public instance FishDeadEffect
FishDeadEffect = class("FishDeadEffect")

function FishDeadEffect:ctor()

    ---@type ShowGetCoinInfo
    self.getCoinInfo = ShowGetCoinInfo.New()
    ---@type ProtoCatchFish
    self.protoCatchFish = ProtoCatchFish.New()
    ---@type ProtoCatchAward
    self.protoCatchAward = ProtoCatchAward.New()

    self.extraDrop = false

    self.playCoin = false

    self.coinGet = 0
    --self.catchInfo = nil
    --self.agentId = nil
    --self.seatInfo = nil
    --self.fish = nil
    --self.seat = nil
end

function FishDeadEffect:create(infoArr)
    self.coinGet = 0;
    ---@type ProtoCatchFish
    self.catchInfo = self.protoCatchFish
    self.catchInfo.p = infoArr;
    self.agentId = self.catchInfo:getAgent()
    self.seatInfo = SeatRouter.instance:getSeatInfoByAgent(self.agentId)
    self.seat = SeatRouter.instance:getSeatByAgent(self.agentId)
    self.fish = Fishery.instance:findFishByUniId(infoArr[1])
    self.seat = SeatRouter.instance:getSeatById(self.seatInfo.seat_id)
    self.showAwardInfo = self.catchInfo:getShowAwardInfo()
end

---@param infoArr ProtoCatchFish
function FishDeadEffect:syncCacheAward(tick)
    if not self.fish then
        return
    end
    --self:createFaCaileAndZhuanFanle("facaile01")
    --黑洞
    --           if (fish.getCatchType() == FightConst.scene_play_black_hole && !fishDieCall)
    --            {
    --                fish.setDieCatchInfo(cInfoArray[i], seatInfo);
    --               break;
    --           }

    --bossjuexing
    if self.catchInfo:getShowAwardInfo()["type"] == FightConst.fish_award_whirlwind then

        local seat = SeatRouter.instance:getSeatById(self.seatInfo.seat_id)
        local pos = self.fish:screenPoint()
        local aw = self.catchInfo:getShowAwardInfo()["killOtherFishs"].award or {}
        local award = self.protoCatchAward
        local coinGet = 0
        for _, v in ipairs(aw) do
            award.p = v
            if FightConst.currency_coin == award:getT() or FightConst.currency_contest_score == award:getT() then
                coinGet = award:getV()
                break
            end
        end
        local awTotal = self.catchInfo:getAward() or {}
        local awardTotal = self.protoCatchAward
        local coinGetTotal = 0
        for _, v in ipairs(awTotal) do
            awardTotal.p = v
            if FightConst.currency_coin == awardTotal:getT() or FightConst.currency_contest_score == awardTotal:getT() then
                coinGetTotal = awardTotal:getV()
                break
            end
        end

        WhirlwindShake:ShowWhirlwindGetCoin(pos)
        local count = seat.bingoController:getBingoTypeRandom(BingoType.WhirlwindFish)
        WhirlwindShake.create(count, seat, pos, { totalCoin = coinGetTotal, coinGet = coinGet, fishUids = self.catchInfo:getShowAwardInfo()["killOtherFishs"].ids or {}, getCoinInfo = self.getCoinInfo, catchInfo = self.catchInfo })
        return
    end

    if self.catchInfo:getShowAwardInfo()["sk"] and self.catchInfo:getShowAwardInfo()["sk"] == FightConst.skin_type_jiguangpao then
        local seat = SeatRouter.instance:getSeatById(self.seatInfo.seat_id)
        local pos = self.fish:screenPoint()
        local aw = self.catchInfo:getAward() or {}
        local award = self.protoCatchAward
        local coinGet = 0
        for _, v in ipairs(aw) do
            award.p = v
            if FightConst.currency_coin == award:getT() or FightConst.currency_contest_score == award:getT() then
                coinGet = award:getV()
                break
            end
        end
        if coinGet > 0 then
            ShadowShake.create(seat, pos, { coinGet = coinGet, fish = self.fish, getCoinInfo = self.getCoinInfo, catchInfo = self.catchInfo },1000)
        end
        return
    end

    if self.fish.fishCfg.ctype >= FightConst.fish_catch_type_boss_awake
            and self.fish.fishCfg.ctype <= FightConst.fish_catch_type_boss_max_awake then

        if self.fish.fishCfg.ctype == FightConst.fish_catch_type_leishenchui_awake then
            HammerAwakeC.instance:onHammerAwake(false, self.catchInfo:getFishUid(), self.showAwardInfo, self.agentId, tick)
            return
        end

        local aw = self.catchInfo:getAward() or {}
        local award = self.protoCatchAward
        for _, v in ipairs(aw) do
            award.p = v
            if FightConst.currency_coin == award:getT() or FightConst.currency_contest_score == award:getT() then
                self.coinGet = award:getV()
            end
        end
        local seat = SeatRouter.instance:getSeatById(self.seatInfo.seat_id)
        local pos = self.fish:screenPoint()
        print("---------------kaishi----------")
        GameTimer.once(2000, self, function()
            seat:showBossJueXing(pos.x, pos.y, self.showAwardInfo, self.fish.fishCfg.bingoType, self.coinGet, self.fish, self.getCoinInfo, self.catchInfo, self.agentId, tick)
        end)
        return
    end

    if self.fish.fishCfg.ctype == FightConst.fish_catch_type_boss then
        self.coinGet = self:showBagFishGoodsGetEffect(self.fish, self.getCoinInfo, self.catchInfo)
    elseif self.fish.fishCfg.ctype == FightConst.fish_catch_type_boom then
        -- 连环炸弹要等表现结束后才把金币加上去
    elseif self.fish.fishCfg.ctype == FightConst.fish_catch_type_award_change then

        local aw = self.catchInfo:getAward() or {}
        local award = self.protoCatchAward
        for _, v in ipairs(aw) do
            award.p = v
            if FightConst.currency_coin == award:getT() or FightConst.currency_contest_score == award:getT() then
                self.coinGet = award:getV()
            end
        end

        local remainPos = Vector2.New();
        remainPos:Set(SeatRouter.instance:getSeatById(self.seatInfo.seat_id).shootStartX, SeatRouter.instance:getSeatById(self.seatInfo.seat_id).shootStartY - 300)
        local effect = XZEffect.new()

        Fishery.instance.XZFishNowType = Fishery.instance.XZFishNowType == 1 and 2 or 1

        effect:showXZEffect(self.catchInfo, self.fish, self.coinGet, self.seatInfo, self.seat)
    else
        self.coinGet = self:showNormalFishGoodsGetEffect(self.fish, self.getCoinInfo, self.catchInfo);

        if FightConst.fish_catch_type_cornucopia == self.fish.fishCfg.ctype then
            -- 聚宝盆金币动画修改
            if seatInfo.seat_id == SeatRouter.instance.mySeatId and FightContext.instance.coinShootScene then
                local srcX = self.fish:screenPoint().x;
                local srcY = self.fish:screenPoint().y;
                local points = { srcX, srcX + 50, srcX - 100, srcY, srcY + 80, srcY - 120 };
                --FullScreenCoinEffect.create(false, points);
                EffectManager.playFullScreenCoinEffect()
            end
        end
    end

    --local isBoomFish = FishHelper.isBoomFish(fish.context.specFlag);
    --if not ENV.isShowDied() then
    --    --漫天撒金钱，发财了转盘等
    --    if (1 == catchInfo.getB() and fish.context.catch_show > 0 and coinGet > 0 and not (fish.isValid())) or (isBoomFish and not (fish.isValid())) then
    --        local catchShowType = fish.context.catch_show
    --        local aniName = fish.context.catchShowAniName
    --        local shakeArr = fish.context.shock
    --        local aniActionName = fish.context.actionName
    --        local catchShowPos = getCatchShowPos(SeatRouter.instance.getShowSeatId(seatInfo.seat_id), fish.context.fishId)
    --        local showAwardInfo = catchInfo.getShowAwardInfo()
    --        local rate
    --        local retType
    --        if showAwardInfo then
    --            rate = showAwardInfo["rate"]
    --            retType = showAwardInfo["index"]
    --        else
    --            rate = 0
    --            retType = 0
    --        end
    --        --发财了
    --        if seatInfo.seat_id == SeatRouter.instance.mySeatId and FightContext.instance.coinShootScene then
    --            FullScreenCoinEffect.create();
    --        end
    --        --                ShockEffect.instance.playShake(shakeArr);
    --        CatchShowEffect.create(catchShowType, coinGet, catchShowPos, FishLayer.instance.effectLayer, aniName, aniActionName, seatInfo, false, rate, retType);
    --    end
    --
    --    local soundPath
    --    --获得金币的声音
    --    if fish.context.playCatchSound then
    --        soundPath = ConfigManager.getConfValue("cfg_global", 1, "get_coin_sound").tostring()
    --        FightSoundManager.playSound(soundPath);
    --    end
    --    --获得额外奖励的声音
    --    if extraDrop then
    --        soundPath = ConfigManager.getConfValue("cfg_global", 1, "extra_drop_sound").tostring()
    --        FightSoundManager.playSound(soundPath);
    --    end
    --end

    --TODO 判断条件不完整
    --if (1 == catchInfo.getB() and fish.context.catch_show > 0 and coinGet > 0 and not (fish.isValid())) or (isBoomFish and not (fish.isValid())) then
    if not self.fish.fishCfg.catch_show then
        self.fish.fishCfg.catch_show = -1
    end

    if (1 == self.catchInfo:getB() and self.fish.fishCfg.catch_show and self.fish.fishCfg.catch_show > 0 and self.coinGet > 0) then
        if self.seatInfo.seat_id == SeatRouter.instance.mySeatId and FightContext.instance.coinShootScene then
            --FullScreenCoinEffect.create();
            EffectManager.playFullScreenCoinEffect()
        end
        local endVec = Vector2.New(self.seat.globalAvatarPosition.x, self.seat.globalAvatarPosition.y)
        EffectManager.showFCLAndZFL(self.fish.fishCfg.action_name, self.coinGet,endVec)
    end

    if self.coinGet and self.coinGet > 0 then
        if Fishery.instance.isMatchScene then
            self.seat:addContestScore(self.coinGet)
        end
    end
end

---@param fish Fish2D
---@param getCoinInfo ShowGetCoinInfo
---@param catchInfo ProtoCatchFish
---@return number
function FishDeadEffect:showNormalFishGoodsGetEffect(fish, getCoinInfo, catchInfo, isDelay, remainPos, aniType)
    local refPos = Vector2.New();
    local award = self.protoCatchAward
    local coinGet = 0;
    local delayShow = 0.2;
    local agentGetInfo;
    local isOwnGet;
    local aw;

    isDelay = isDelay or false
    if isDelay then
        refPos = remainPos
    else
        refPos:Set(fish:screenPoint().x, fish:screenPoint().y)
    end

    isOwnGet = false;
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(catchInfo:getAgent());
    if not seatInfo then
        seatInfo = catchInfo.seat_info;
    end
    if seatInfo and seatInfo.seat_id == SeatRouter.instance.mySeatId then
        isOwnGet = true;
    else
        isOwnGet = false
    end
    delayShow = 0;
    if catchInfo:getShowAwardInfo()["type"] == FightConst.fish_award_whirlwind then
        aw = catchInfo:getShowAwardInfo()["killOtherFishs"].award or {}
    else
        aw = catchInfo:getAward();
    end
    for i = 1, #aw do
        --				award = aw[i] as ProtoCatchAward;
        award.p = aw[i]
        if FightConst.currency_coin == award:getT() or FightConst.currency_contest_score == award:getT() then
            if seatInfo then
                coinGet = award:getV()
                EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seatInfo.seat_id, delayShow, refPos, award:getV(), catchInfo:getAgent(), nil, isDelay, nil, aniType);
                self.playCoin = true
            end
            --self:CoinFlyPlay(fish, refPos, getCoinInfo, seatInfo.seat_id, delayShow, award:getV(), catchInfo:getAgent(), isDelay)
        end
        if FightConst.currency_fish_coin == award:getT() then
            --鱼币获取提示:todo
            if isOwnGet then
                GameEventDispatch.instance:event(FightEvent.ShowFishCoin, award:getV())
            end
        end
        local showCount = 1;
        if FightConst.currency_diamond == award:getT() then
            --					|| FightConst.currency_exchange == award.getT())
            showCount = award:getV()
        end
        if seatInfo then
            if Fishery.instance:canTestZuantoupao() or FightConst.goods_type_zuantoupao == award:getT() or FightConst.goods_type_jiguangpao == award:getT() then
                -- 钻头炮掉落表现
                self.extraDrop = true;
                getCoinInfo.pos_x = refPos.x;
                getCoinInfo.pos_y = refPos.y;
                getCoinInfo.goodId = award:getT();
                -- getCoinInfo.goodId = FightConst.goods_type_jiguangpao -- award:getT();
                getCoinInfo.seat_id = seatInfo.seat_id
                self.lstTestZuantoupaoTime = TimeTools:getCurSec()
                local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
                seat:showGetSpecialPaoEffect(getCoinInfo)
            elseif FightConst.goods_type_torpedo_beg <= award:getT() and FightConst.goods_type_torpedo_end > award:getT() then
                -- 鱼雷鱼死亡获取鱼雷表现
                self.extraDrop = true;
                getCoinInfo.pos_x = GameScreen.instance.adaptWidth / 2;
                getCoinInfo.pos_y = GameScreen.instance.adaptHeight / 2;
                getCoinInfo.goodId = award:getT();
                -- GameEventDispatch.instance:event(FightEvent.ShowGetTorpedoEffect, getCoinInfo)
            elseif FightConst.currency_exp ~= award:getT() and FightConst.currency_fish_coin ~= award:getT() and
                    FightConst.currency_coin ~= award:getT() then
                GameTimer.once(1500, self, function()
                    self.extraDrop = true
                    getCoinInfo.useTime = 0
                    if isDelay then
                        getCoinInfo.pos_x = refPos.x
                        getCoinInfo.pos_y = refPos.y
                    else
                        getCoinInfo.pos_x = fish:screenPoint().x;
                        getCoinInfo.pos_y = fish:screenPoint().y;
                    end
                    getCoinInfo.goodId = award:getT();
                    for l = 1, showCount do
                        getCoinInfo.delay = delayShow;
                        local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
                        seat:showGetGoodsEffect(getCoinInfo)
                        agentGetInfo = AgentGetInfo.New()
                        agentGetInfo.t = award:getT()
                        agentGetInfo.v = award:getV() / showCount
                        agentGetInfo.leftTime = getCoinInfo.useTime
                        agentGetInfo.ag = catchInfo:getAgent()
                        GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
                        delayShow = delayShow + 0.2
                    end
                end)
            end
        end
    end
    return coinGet;
end

---@param fish Fish2D
---@param getCoinInfo ShowGetCoinInfo
---@param catchInfo ProtoCatchFish
---@return number
function FishDeadEffect:showBagFishGoodsGetEffect(fish, getCoinInfo, catchInfo)
    local refPos = Vector2.New()
    local award = self.protoCatchAward
    local coinGet = 0
    local delayShow = 0
    local agentGetInfo
    local isOwnGet = false
    local aw
    refPos:Set(fish:screenPoint().x, fish:screenPoint().y)
    --            fish.playMoneyBagBomb();//当鱼拥有钱袋，死亡时候钱袋爆炸
    isOwnGet = false
    local seatInfo = SeatRouter.instance:getSeatInfoByAgent(catchInfo:getAgent())
    if not seatInfo then
        seatInfo = catchInfo.seat_info
    end
    if seatInfo then
        isOwnGet = seatInfo.seat_id == SeatRouter.instance.mySeatId
    end
    --            delayShow = fish.getMoneyBagDelay();钱袋动画延迟播放速度
    aw = catchInfo:getAward()
    for k = 1, #aw do
        award.p = aw[k]
        if FightConst.currency_coin == award:getT() or FightConst.currency_contest_score == award:getT() then
            coinGet = award:getV()
            local fontClip = Pool.createByClass(FontClipEffect)
            fontClip:create(award:getV(), refPos, isOwnGet, FishLayer.instance.effectLayer, delayShow)
            fontClip:numFlyPlay()
        end
        if FightConst.currency_fish_coin == award:getT() then
            if isOwnGet then
                GameEventDispatch.instance:event("ShowFishCoin", award:getV())
            end
        end
        local showCount = 1
        if FightConst.currency_diamond == award:getT() then
            showCount = award:getV()
        end
        if seatInfo and FightConst.currency_exp ~= award:getT() then
            getCoinInfo.useTime = 0
            getCoinInfo.goodId = award:getT()
            getCoinInfo.delay = delayShow
            local seat = SeatRouter.instance:getSeatById(seatInfo.seat_id)
            for x = 1, #self.multiGetCoinArrayX do
                for y = 1, #self.multiGetCoinArrayY do
                    getCoinInfo.pos_x = refPos.x + self.multiGetCoinArrayX[x]
                    getCoinInfo.pos_y = refPos.y + self.multiGetCoinArrayY[y]
                    seat:showGetGoodsEffect(getCoinInfo)
                end
            end
            agentGetInfo = AgentGetInfo.New()
            agentGetInfo.t = award:getT()
            agentGetInfo.v = award:getV()
            agentGetInfo.leftTime = getCoinInfo.useTime
            agentGetInfo.ag = catchInfo:getAgent()
            GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
        end
    end
    return coinGet
end

function FishDeadEffect:getCoinNum(catchInfo)
    local award = self.protoCatchAward
    local aw = catchInfo:getAward();
    local coinGet
    for i = 1, #aw do
        award.p = aw[i]
        if FightConst.currency_coin == award:getT() or FightConst.currency_contest_score == award:getT() then
            coinGet = award:getV()
        end
    end
    return coinGet
end
