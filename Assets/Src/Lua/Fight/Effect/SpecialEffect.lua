SpecialEffect = class("SpecialEffect")

function SpecialEffect:ctor()
end

function SpecialEffect.playBurstYulei()
    local burstYulei = GGraph.New()
    FishLayer.instance.effectLayer:AddChild(burstYulei)
    local prefabUrl = "Effects/Burst_Yulei"
    local burstCoinAni = GameTools.ResourcesLoad(prefabUrl)
    local wrapper = GoWrapper.New(burstCoinAni)
    burstYulei:SetNativeObject(wrapper)

    return burstYulei
end

function SpecialEffect.playBurstCoin()
    local burstCoin = GGraph.New()
    FishLayer.instance.effectLayer:AddChild(burstCoin)
    local prefabUrl = "Effects/EffectXuanfengyu/Burst_Coin"
    local burstCoinAni = GameTools.ResourcesLoad(prefabUrl)
    local wrapper = GoWrapper.New(burstCoinAni)
    burstCoin:SetNativeObject(wrapper)

    return burstCoin
end

function SpecialEffect.playWhirlwind()
    local whirlwind = GGraph.New()
    FishLayer.instance.fishLayer:AddChild(whirlwind)
    local prefabUrl = "Effects/EffectXuanfengyu/Assimilate_Xuanfengyu"
    local whirlwindAni = GameTools.ResourcesLoad(prefabUrl)
    local wrapper = GoWrapper.New(whirlwindAni)
    whirlwind:SetNativeObject(wrapper)

    return whirlwind
end

function SpecialEffect.playAppear()
    local appear = GGraph.New()
    FishLayer.instance.fishLayer:AddChild(appear)
    local prefabUrl = "Effects/EffectXuanfengyu/Appear"
    local appearAni = GameTools.ResourcesLoad(prefabUrl)
    local wrapper = GoWrapper.New(appearAni)
    appear:SetNativeObject(wrapper)

    return appear
end

function SpecialEffect:playBossDeathAni(fish, bingoType)
    local Wrapper = GComponent.New()
    if bingoType == BingoType.EYuBoss then
        local tab = {}
        local screenPos1 = Game.instance.camera:WorldToScreenPoint(fish.fish3dAni.transform:Find("BodyEffect_Eyu/Dummy001").position)
        local screenPos2 = Game.instance.camera:WorldToScreenPoint(fish.fish3dAni.transform:Find("BodyEffect_Eyu/Dummy001/bone00").position)
        local screenPos3 = Game.instance.camera:WorldToScreenPoint(fish.fish3dAni.transform:Find("BodyEffect_Eyu/Dummy001/bone00/bone01").position)
        local screenPos4 = Game.instance.camera:WorldToScreenPoint(fish.fish3dAni.transform:Find("BodyEffect_Eyu/Dummy001/bone00/bone01/bone02").position)
        local screenPos5 = Game.instance.camera:WorldToScreenPoint(fish.fish3dAni.transform:Find("BodyEffect_Eyu/Dummy001/bone00/bone01/bone02/bone03").position)
        tab = { screenPos1, screenPos2, screenPos3, screenPos4, screenPos5 }
        for i = 1, 5 do
            tab[i].y = UnityEngine.Screen.height - tab[i].y
            local pos = GRoot.inst:GlobalToLocal(Vector2.New(tab[i].x, tab[i].y))
            local BurstCoin = EffectManager.playBurstCoin(Vector2.New(pos.x, pos.y))
            Wrapper:AddChild(BurstCoin)
        end
    end

    if bingoType == BingoType.AnKangYuBoss then
        local tab = {}
        local screenPos1 = fish.wrapper.parent:GetRenderCamera():WorldToScreenPoint(fish.fish3dAni.transform:Find("anyejushou/Dummy001/Bone001/Bone003").position)
        local screenPos2 = fish.wrapper.parent:GetRenderCamera():WorldToScreenPoint(fish.fish3dAni.transform:Find("anyejushou/Dummy001/Bone001/Bone005").position)
        local screenPos3 = fish.wrapper.parent:GetRenderCamera():WorldToScreenPoint(fish.fish3dAni.transform:Find("anyejushou/Dummy001/Bone001/Bone051").position)
        tab = { screenPos1, screenPos2, screenPos3 }
        for i = 1, 3 do
            tab[i].y = UnityEngine.Screen.height - tab[i].y
            local pos = GRoot.inst:GlobalToLocal(Vector2.New(tab[i].x, tab[i].y))
            local BurstCoin = EffectManager.playBurstCoin(Vector2.New(pos.x, pos.y))
            Wrapper:AddChild(BurstCoin)
        end
    end

    if bingoType == BingoType.ZhangYuBoss then
        local BurstCoin = EffectManager.playBurstCoin(Vector2.New(fish:screenPoint().x, fish:screenPoint().y))
        Wrapper:AddChild(BurstCoin)
    end

    GameTimer.once(800, self, function()
        local Appear = EffectManager.playAppear(Vector2.New(fish:screenPoint().x, fish:screenPoint().y))
        Wrapper:AddChild(Appear)
    end)

    FishLayer.instance.fishLayer:AddChild(Wrapper)

    GameTimer.once(6000, self, function()
        Wrapper:RemoveFromParent()
        Wrapper:Dispose()
    end)
end
