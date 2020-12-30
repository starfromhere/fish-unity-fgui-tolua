---@class BingoSingle
BingoSingle = class("BingoSingle")
function BingoSingle:ctor()
    ---@type cfg_bingo
    self.profile = nil
    ---@type NumChgEffect
    self.numChgEffect = nil

    ---@type GComponent
    self.bingoTitleParent = nil
    ---@type GComponent
    self.bingoNumParent = nil
    ---@type GComponent
    self.bingoFinalParent = nil

    ---@type GComponent 基础组件
    self.baseCom = nil;
    ---@type Controller 基础组件显示控制器
    self.baseController = nil

    self.SumComArr = {}
    ---@type GComponent 累加分数组件
    self.SumCom = nil;
    ---@type Controller 累加分数显示控制器
    self.SumController = nil

    ---@type GComponent 结算组件
    self.finalScoreCom = nil;
    ---@type Controller 结算组件显示控制器
    self.finalController = nil
    self.moveUpLength = 50
    self.endPosition = nil
end

--创建bingoSingle
function BingoSingle.creatBingoSingle(type, relativeMirrorFlag, bingoTitleParent, bingoNumParent, bingoFinalParent)
    local temp = Pool.getItemByClass("BingoSingle" .. type, BingoSingle)
    temp:initComponent(type, relativeMirrorFlag, bingoTitleParent, bingoNumParent, bingoFinalParent)
    return temp
end

function BingoSingle:initComponent(type, relativeMirrorFlag, bingoTitleParent, bingoNumParent, bingoFinalParent)
    self.profile = cfg_bingo.instance(tonumber(type))
    self.bingoTitleParent = bingoTitleParent
    self.bingoNumParent = bingoNumParent
    self.bingoFinalParent = bingoFinalParent

    if self.baseCom == nil then
        self.baseCom = self:getComponent(self.profile.baseCom)
        self.baseController = self.baseCom:GetController(self.profile.baseController)
    end
    self.bingoTitleParent:AddChild(self.baseCom)
    self.baseCom.scaleY = 1
    if MirrorMapper.getMirrorYByFlag(relativeMirrorFlag) then
        self.baseCom.scaleY = -1
    end
    self.baseController.selectedIndex = self.profile.baseSelectPage
    if self.profile.isShowSum == 1 then
        if self.SumCom == nil then
            self.SumComArr = { right = self:getComponent(self.profile.sumCom),
                               left = self:getComponent(self.profile.sumCom .. "Left") }
        end
        if MirrorMapper.getMirrorXByFlag(relativeMirrorFlag) then
            self.SumCom = self.SumComArr['right']
        else
            self.SumCom = self.SumComArr['left']
        end
        self.SumController = self.SumCom:GetController(self.profile.sumController)
        self.bingoNumParent:AddChild(self.SumCom)
        self.SumController.selectedIndex = self.profile.sumSelectPage
        self.SumCom.visible = false
    end

    if self.finalScoreCom == nil then
        self.finalScoreCom = self:getComponent(self.profile.finalCom)
        self.finalController = self.finalScoreCom:GetController(self.profile.finalController)
    end
    self.bingoFinalParent:AddChild(self.finalScoreCom)
    self.finalController.selectedIndex = self.profile.finalSelectPage
    self.baseCom.visible = false
    self.finalScoreCom.visible = false
end

function BingoSingle:BingoFirstStep(batteryLevel, type, startX, startY, endX, endY)
    if self.profile.isMoveCom == 1 then
        local item = self:getComponent(self.profile.baseCom)
        item:GetController(self.profile.baseController).selectedIndex = self.profile.baseSelectPage
        if batteryLevel then
            item:GetChild("title").component:GetChild("RateTxt").text = batteryLevel
        end
        item:SetPivot(0.5, 0.5)
        item.pivotAsAnchor = true
        FishLayer.instance.effectLayer:AddChild(item)
        item.x = startX
        item.y = startY
        local dx = endX - startX
        local dy = endY - startY
        local distance = math.sqrt(dx * dx + dy * dy)
        -- TweenMove的时间单位是秒,所以速度要调成h5版的1000倍
        local speed = 500
        local endVec = Vector2.New(endX, endY)
        item:TweenMove(endVec, distance / speed):OnComplete(function()
            item:RemoveFromParent()
            item:Dispose()
            self:showBingoTitle(batteryLevel)
        end)
    else
        self:showBingoTitle(batteryLevel)
    end
end

function BingoSingle:BingoSecondStep(initVal, totalVal, totalTime, addVal)
    local effect = self.numChgEffect
    if not initVal then
        initVal = tonumber(self.SumCom:GetChild("numText").text)
    end
    if not effect then
        effect = NumChgEffect.create(self.SumCom:GetChild("numText"), initVal, totalVal, totalTime, addVal)
        self.numChgEffect = effect
    else
        effect:recover()
        effect:init(self.SumCom:GetChild("numText"), initVal, totalVal, totalTime, addVal)
    end
    effect:play()
end

function BingoSingle:BingoThirdStep(relativeMirrorFlag, seadId, score, funcSelf, func, isDelay)
    if not isDelay then
        isDelay = false
    end
    if isDelay then
        GameTimer.once(3000, self, function()
            self:aloneSetFinalScore(score, seadId)
            self:MoveStartBingoUp(relativeMirrorFlag, funcSelf, func)
        end)
    else
        self:aloneSetFinalScore(score, seadId)
        self:MoveStartBingoUp(relativeMirrorFlag, funcSelf, func)
    end
end

function BingoSingle:MoveStartBingoUp(relativeMirrorFlag, funcSelf, func)
    self.curMoveUpLength = self.moveUpLength
    local scoreAni = self.finalScoreCom:GetTransition("scoreYoyo")
    if MirrorMapper.getMirrorYByFlag(relativeMirrorFlag) then
        self.curMoveUpLength = -self.moveUpLength
    end
    self.endPosition = Vector2.New(self.baseCom.x, self.baseCom.y - self.curMoveUpLength)
    self.baseCom:TweenMove(self.endPosition, 0.5):OnComplete(
            function()
                self.finalScoreCom.visible = true
                SoundManager.PlayEffect("Music/bingoEnd.mp3")
                if func ~= nil then
                    scoreAni:Play(function()
                        func(funcSelf)
                    end)
                else
                    scoreAni:Play(function()
                    end)
                end
            end
    )
end

function BingoSingle:showBingoTitle(batteryLevel, isPlaying, score)
    if batteryLevel then
        self.baseCom:GetChild("title").component:GetChild("RateTxt").text = tostring(batteryLevel)
    end
    if not isPlaying then
        isPlaying = true
    end
    self.baseCom.visible = true
    if self.profile.isScale == 1 and isPlaying == true then
        self:setScaleAni(true)
    end
    if self.profile.isShowSum == 1 then
        if score then
            self:updateBingoSum(true, score)
        else
            self:updateBingoSum(true, 0)
        end
    end
end

function BingoSingle:aloneSetFinalScore(score, seadId, isSlowAdd)
    local textObj = (self.finalScoreCom:GetChild("n4").component):GetChild("CoinTxt")
    if self.profile.id == BingoType.WhirlwindFish then
        GameTools.setTxtBySeatId(textObj, score, seadId)
    else
        if isSlowAdd then
            local initVal = tonumber(textObj.text)
            local effect = NumChgEffect.create(textObj, initVal, score, 1500, 0)
            effect:play()
        else
            textObj.text = score
        end
    end
end

function BingoSingle:updateBingoSum(isShow, score)
    self.SumCom.visible = isShow
    self.SumCom:GetChild("numText").text = score
end

function BingoSingle:getComponent(comName)
    return UIPackage.CreateObject("Fish", tostring(comName))
end

function BingoSingle:BaseComVisible(value)
    if not value then
        return self.baseCom.visible
    end
    self.baseCom.visible = value
end

function BingoSingle:setSumComVisible(value)
    self.SumCom.visible = value
end

function BingoSingle:setFinalScoreComVisible(value)
    self.finalScoreCom.visible = value
end

---@param play boolean
function BingoSingle:setScaleAni(play)
    local catchAni = self.baseCom:GetTransition("CatchEffect")
    if play == true then
        catchAni:Play()
    else
        catchAni:Stop()
    end
end

function BingoSingle:getWhirlwindPosition()
    if self.baseController.selectedIndex == cfg_bingo.instance(BingoType.WhirlwindFish).baseSelectPage then
        return self.baseCom:GetChild("title").component:GetChild("aniBox"):LocalToRoot(Vector2.New(0, 0), GRoot.inst)
    end
end

function BingoSingle:disposeState()
    ---清理正在进行的计时器和动画
    self.baseCom.visible = false
    self.finalScoreCom.visible = false
    self.baseCom:RemoveFromParent()
    if self.SumCom then
        self.SumCom.visible = false
        self.SumCom:RemoveFromParent()
    end
    self.finalScoreCom:RemoveFromParent()
    if self.endPosition then
        self.baseCom.y = self.endPosition.y + self.curMoveUpLength
    end
    self.endPosition = nil
    Pool.recover("BingoSingle" .. self.profile.id, self)
end
