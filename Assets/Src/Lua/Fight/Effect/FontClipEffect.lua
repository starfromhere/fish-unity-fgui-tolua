FontClipEffect = class("FontClipEffect")

FontClipEffect.awardNumActionScale = { 1.05, 1.12, 1.15, 1.21, 1.25, 1.31, 1.37, 1.43, 1.49, 1.56, 1.49, 1.35, 1.30,
                                        1.27, 1.23, 1.16, 1.11, 1.06, 1.02, 0.90, 0.80, 0.90, 1.0, 1.0, 1.0, 1.0, 1.0,
                                        1.0, 1.0, 1.0, }
--- boss觉醒
FontClipEffect.boss_awake = {}
--- 炸弹鱼爆炸击杀鱼
FontClipEffect.fish_boom = {}
--- 钻头炮爆炸击杀鱼
FontClipEffect.cannon_boom = {}
--- 鳄鱼觉醒
FontClipEffect.eyu_awake = {}
--- 鮟鱇鱼觉醒
FontClipEffect.anakangyu_awake = {}

FontClipEffect._fontClipArr = {}

function FontClipEffect:ctor(seat, pos, index)
    ---@type GComponent
    self.FontCom = nil
    ---@type GTextField
    self.numFont = nil
    self._isValid = false
    self.originX = nil
    self.originY = nil
    self.numActionIndex = 1
    self._delay = nil
    self._delayIndex = 0
    self._fish = nil
    self._type = nil
    self._seatId = nil
    self._scaleArr = nil
    self._coin = nil
    self._playCoinAni = true
    self.isAddCoin = true -- 是否加金币，有时候会只做表现，不加金币的表现,兼容原来的接口，默认给true
    if FontClipEffect._fontClipArr == nil then
        FontClipEffect._fontClipArr = {}
    end
end

---@param value number
---@param pos Vector2
---@param own boolean
---@param parent GObject
---@param delay number
function FontClipEffect:create(value, pos, delay, fish, type, seatId, agent, getCoinInfo, isAddCoin)
    if (not self.FontCom) then
        self.FontCom = UIPackage.CreateObject("CommonComponent", "FontEffect")
        self.numFont = self.FontCom:GetChild("n0")
    end
    GameTools.setTxtBySeatId(self.numFont, value, seatId)
    self._fish = fish
    self._seatId = seatId
    self._coin = value
    self._delay = delay
    self._agent = agent
    self._getCoinInfo = getCoinInfo
    self._delayIndex = 0
    --self.numFont.text =GameTools.getFloat(value);
    self.originX = pos.x;
    self.originY = pos.y;
    local seat = SeatRouter.instance:getSeatById(self._seatId)
    -- 不能加金币时，强制置isAddCoin成false
    if seat and seat.isUnableAddCoin then
        self.isAddCoin = false
    elseif isAddCoin ~= nil then
        self.isAddCoin = isAddCoin
    end
    
    self._scaleArr = self:refreshArr(type)
    table.insert(FontClipEffect._fontClipArr, self)
end

function FontClipEffect:refreshArr(type)
    if type == FightConst.fish_death_type_boss_awake and table.len(FontClipEffect.boss_awake) > 0 then
        return FontClipEffect.boss_awake
    elseif type == FightConst.fish_death_type_anakangyu_awake and table.len(FontClipEffect.anakangyu_awake) > 0 then
        return FontClipEffect.anakangyu_awake
    elseif true == FightConst.fish_death_type_boom_fish_boom and table.len(FontClipEffect.fish_boom) > 0 then
        return FontClipEffect.fish_boom
    elseif true == FightConst.fish_death_type_drill_cannon_boom and table.len(FontClipEffect.cannon_boom) > 0 then
        return FontClipEffect.cannon_boom
    elseif true == FightConst.fish_death_type_eyu_awake and table.len(FontClipEffect.eyu_awake) > 0 then
        return FontClipEffect.eyu_awake
    else
        return FontClipEffect.awardNumActionScale
    end
end

---@param value number
---@param pos Vector2
---@param own boolean
---@param parent GObject
---@param delay number
function FontClipEffect:numFlyPlay(aniType)

    self.numFont.text = tostring(math.floor(self._coin));
    if (self.originX < 40) then
        self.originX = 40;
    end
    if (self.originX > GRoot.inst.width - 40) then
        self.originX = GRoot.inst.width - 40;
    end
    if (self.originY < 50) then
        self.originY = 50;
    end
    if (self.originY > GRoot.inst.height - 10) then
        self.originY = GRoot.inst.height - 10;
    end

    self._playCoinAni = aniType or FightConst.playNumAndCoin
    self.numActionIndex = 1;
    self.FontCom.x = self.originX
    self.FontCom.y = self.originY
    self.FontCom:SetPivot(0.5, 0.5)
    if self._playCoinAni ~= FightConst.playCoin then
        self.FontCom.visible = self._delay <= 0;
        self._isValid = true;
        self:updateNumberPos();
        FishLayer.instance.effectLayer:AddChild(self.FontCom);
    end
end

function FontClipEffect:updateNumberPos()
    local posX
    local posY
    if self._fish then
        posX = self._fish:screenPoint().x
        posY = self._fish:screenPoint().y
    end
    if self.FontCom then
        self.FontCom.x = posX -- self.originX
        self.FontCom.y = posY -- (self.originY + FontClipEffect.awardNumActionY[self.numActionIndex])
        self.FontCom:SetScale(self._scaleArr[self.numActionIndex], FontClipEffect.awardNumActionScale[self.numActionIndex]);
        --self.FontCom.alpha = FontClipEffect.awardNumActiconAlpha[self.numActionIndex];
    end
end

function FontClipEffect:update(delta)
    if (self._delay > 0) then
        self._delay = self._delay - delta;
        if (self._delay <= 0) then
            self.FontCom.visible = true;
        end
        return ;
    end
    self._delayIndex = self._delayIndex + 1;
    if (self._delayIndex >= 3) then
        self.numActionIndex = self.numActionIndex + 1;
        self._delayIndex = 0;
    end
    self:updateNumberPos();
end

function FontClipEffect:destroy()
    self._isValid = false;
    self.FontCom:RemoveFromParent()
    -- self.FontCom:Dispose()
    Pool.recoverByClass(self)
end

function FontClipEffect:coinFlyPlay()
    local getCoinInfo = ShowGetCoinInfo.New()
    local randArray = {}
    local coinFly = self._fish.fishCfg.coin_fly
    local count = math.floor(#coinFly / 3)--12/3=4
    for j = 1, 8 do
        randArray[j] = math.random()
    end
    self.numActionIndex = 1;
    getCoinInfo.useTime = 0
    getCoinInfo.goodId = FightConst.currency_coin
    getCoinInfo.delay = self._delay
    getCoinInfo.rnd = randArray
    getCoinInfo.pos_x = 0
    getCoinInfo.pos_y = 0
    getCoinInfo.delay = 0
    local seat = SeatRouter.instance:getSeatById(self._seatId)
    for j = 1, count do

        getCoinInfo.pos_x = self._fish:screenPoint().x + coinFly[j * 3 - 1]
        getCoinInfo.pos_y = self._fish:screenPoint().y + coinFly[j * 3 - 1]
        getCoinInfo.delay = self._delay + coinFly[j * 3]
        seat:showGetGoodsEffect(getCoinInfo)
    end
    self:destroy()
    if not self.isAddCoin then
        return
    end
    local agentGetInfo = AgentGetInfo.New()
    agentGetInfo.t = FightConst.currency_coin
    agentGetInfo.v = self._coin
    agentGetInfo.leftTime = getCoinInfo.useTime
    agentGetInfo.ag = self._agent
    GameEventDispatch.instance:event(GameEvent.AddAgentGetInfo, agentGetInfo)
end

function FontClipEffect:fishInfo()
    return self._fish
end

function FontClipEffect:isValid(value)
    if value ~= nil then
        self._isValid = value
        return
    end
    if ((self.numActionIndex < #self._scaleArr) and self._isValid) then
        return true;
    else
        return false
    end
end

function FontClipEffect:updateFontClipEffect(delta, removeAll)
    if removeAll == nil then
        removeAll = false
    end
    if (not FontClipEffect._fontClipArr) then
        return ;
    end
    for i = 1, #FontClipEffect._fontClipArr do
        local obj = FontClipEffect._fontClipArr[i]
        if obj == nil then
            return
        end
        if (removeAll) then
            obj:isValid(false)
        end
        if (not obj:isValid()) then
            obj:coinFlyPlay()
            table.remove(FontClipEffect._fontClipArr, i)
            i = i - 1
        else
            obj:update(delta);
        end
    end
end

