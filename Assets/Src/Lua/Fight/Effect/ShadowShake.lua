ShadowShake = class("ShadowShake")

function ShadowShake:ctor(seat, pos, data, delay)
    GameTimer.once(delay,self,function ()
        self.seat = seat
        self.data = data
        self.item = UIPackage.CreateObject("FishDeathAni", "ShadowShake")
        self:initDeathFish()
        -- self.item:GetChild("death")
        -- self.item:GetChild("death").url = "ui://FishFrames/"..data.fish.fishCfg.aniName_down
        -- self.item:GetChild("death").component:GetChild("collider").visible = false
        local rateTxt = self.item:GetChild("rate")
        GameTools.setTxtBySeatId(rateTxt, data.coinGet, seat.seatId)
        local beginr = math.random(0, 360)
        local endr = math.random(0, 360) + 180
        self.ani = self.item:GetTransition("deathani")
        self.ani:SetValue("start", beginr)
        self.ani:SetValue("end", endr)
        FishLayer.instance.effectLayer:AddChild(self.item)
        self.item.position = pos
        self.ani:Play(function()
            self:PlayCoin()
        end)
    end)
end

function ShadowShake:initDeathFish(fishName)
    local FishGraph = self.item:GetChild("death")

    local prefabUrl = "Fish/" .. self.data.fish.fishCfg.aniName_down
    local fish3dAni = GameTools.ResourcesLoad(prefabUrl)
    -- fish3dAni.transform.localPosition = Vector3.New(0, 0, fish3dAni.transform.localPosition.z + 1300)
    local wrapper = GoWrapper.New(fish3dAni)
    FishGraph:SetNativeObject(wrapper)
    return FishGraph
end

function ShadowShake.create(seat, pos, data, delay)
    delay = delay or 0
    local ret = ShadowShake.New(seat, pos, data, delay)
    return ret
end

function ShadowShake:PlayCoin()
    self.item:RemoveFromParent()
    self.item:Dispose()
    FishDeadEffect.instance:showNormalFishGoodsGetEffect(self.data.fish, self.data.getCoinInfo, self.data.catchInfo, nil, nil, FightConst.playCoin)
end