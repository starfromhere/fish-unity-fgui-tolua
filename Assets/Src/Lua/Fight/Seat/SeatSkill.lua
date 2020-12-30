---@param info SkillInfo
function Seat:updateSkillCdLeftTime(skillData)
    if self.skillInfoMap then
        for i, v in pairs(self.skillInfoMap) do
            if v.id == skillData.id then
                v.cd = skillData.cd
                break
            end
        end
    end

    table.insert(self.skillInfoMap, skillData)
end

function Seat:resetSkillCd()
    for i, v in ipairs(self.skillInfoMap) do
        v.cd = 0
    end
end

---@param delta number
function Seat:updateSkill(delta)
    if #self.skillInfoMap <= 0 then
        return
    end
    for i, v in ipairs(self.skillInfoMap) do
        if v.cd > 0 then
            v.cd = v.cd - delta
        end
    end
end

---@param skillIndex number
function Seat:getSkillId(skillIndex)
    if FightM.instance.sceneId > 0 then
        local skills = ConfigManager.getConfValue("cfg_scene", FightM.instance.sceneId, "skills")
        if skills then
            return skills[skillIndex]
        end
    end
    return 0
end

---@param skillId number
function Seat:getSkillCdLeftTime(skillId)
    for i, v in pairs(self.skillInfoMap) do
        if v.id == skillId then
            return v.cd
        end
    end
    return 0
end

function Seat:updateSkillCdLeftTime(skillData)
    if self.skillInfoMap then
        for i, v in pairs(self.skillInfoMap) do
            if v.id == skillData.id then
                v.cd = skillData.cd
                break
            end
        end
    end

    table.insert(self.skillInfoMap, skillData)
end

function Seat:resetSkillCd()
    for i, v in ipairs(self.skillInfoMap) do
        v.cd = 0
    end
end

---@param skillId number
function Seat:useSkill(skillId,cancelBtn)
    local cdLeftTime = self:getSkillCdLeftTime(skillId);
    if cdLeftTime > 0 then
        GameTip.showTip("技能冷却中")
        return
    end
    local cfgSkill = cfg_skill.instance(skillId)
    local skillType = cfgSkill.skill_type
    local goodIsEnough = SkillM.instance:skillCount(skillId) > 0

    Log.warning("Seat:useSkill", Fishery.instance.fsm:isInState(StateFisheryBoom), "skillId: ", skillId, "skillType: ", skillType)

    if GameConst.SKILL_ID_BOOM == skillType then
        if not goodIsEnough then
            GameTip.showTipById(2)
        else
            ---@type UIFishPage
            if not Fishery.instance.fsm:isInState(StateFisheryBoom) then
                cancelBtn.visible = true
                Fishery.instance:changeToBoom()
                self:changeToBoom(skillId)
            end
        end
    else
        if self.fsm:isInState(StateSeatBoom) or self.fsm:isInState(StateSeatRange) or self.fsm:isInState(StateSeatWait) then
            return
        end

        if SkillM.instance:isConsumeEnough(skillId) then
            CmdGateOut:useSkill(skillId)
        else
            if RoleInfoM.instance:isSkillResTip() then
                Seat.TipToShop()
            else
                local tmpInfo = ConfirmTipInfo.new();
                local diamondNum = SkillM.instance:skillDiamondCount(skillId);
                tmpInfo.content = "道具不足，是否花费" .. diamondNum .. "钻石释放该技能";
                tmpInfo.autoCloseTime = 10;
                tmpInfo.rightClick = function()
                    GameEventDispatch.instance:event(GameEvent.UseGoodsConfirmAndJumpToShop, { skillId, 1 })
                    local t = Timer.New(function()
                        Seat.TipToShop()
                    end, 0.1, 1)
                    t:Start()
                end
                GameTip.showConfirmTip(tmpInfo)
            end
        end
    end
end

function Seat.TipToShop()
    local info = ConfirmTipInfo.new();
    info.content = "钻石不足是否前去充值";
    info.autoCloseTime = 10;
    info.rightClick = function()
        GameEventDispatch.instance:event(GameEvent.Shop, GameConst.shop_tab_diamond)
    end
    GameTip.showConfirmTip(info)
end

function Seat:onUseBoom(x, y, skillId, fishUid, coin,seatId,agent)
    local fish = Fishery.instance:findFishByUniId(fishUid)
    Fishery.instance:cancelBoom()
    self:playBoom(x, y, skillId, function()
        fish:changeToDead()
        EffectManager:playBoomEffect(fish.fishWrapper.x, fish.fishWrapper.y)


        local pos = fish:getLockPoint()
        local seatInfo = SeatRouter.instance:getSeatInfoByAgent(agent)
        local getCoinInfo = ShowGetCoinInfo.New()
        local delayShow = 1
        local coinNum = coin
        EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seatInfo.seat_id, delayShow, pos, coinNum, agent, nil, nil, nil, nil, true);
    end)
    --if fish then
    --    local refPos = Vector2.New();
    --    refPos:Set(fish:screenPoint().x, fish:screenPoint().y)
    --    Fishery.instance:showNormalFishCoinGetEffect(fish, ShowGetCoinInfo.New(),seatId, 1,
    --            refPos,coin, agent, true);
    --end
    
end

function Seat:onClickAuto()
    if not self.autoCancelImg then
        self.autoCancelImg = UIFishPage.instance.CancelAutoBtn
    end
    if not self.autoAniBox then
        self.autoAniBox = UIFishPage.instance.autoAniBox
    end
    self.mouseX = GameScreen.instance.adaptWidth / 2
    self.mouseY = GameScreen.instance.adaptHeight / 2

    self.isOpenAuto = not self.isOpenAuto
    self.autoCancelImg.visible = self.isOpenAuto
    self.autoAniBox.visible = self.isOpenAuto
end

function Seat:closeAuto()
    self.isOpenAuto = false
    if not self.autoCancelImg then
        self.autoCancelImg = UIFishPage.instance.CancelAutoBtn
    end
    if not self.autoAniBox then
        self.autoAniBox = UIFishPage.instance.autoAniBox
    end
    if self:isMySeat() then
        self.autoCancelImg.visible = self.isOpenAuto
        self.autoAniBox.visible = self.isOpenAuto
    end

end
