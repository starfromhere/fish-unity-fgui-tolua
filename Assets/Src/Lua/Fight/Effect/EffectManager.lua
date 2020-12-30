EffectManager = class("EffectManager")


--发财了
function EffectManager.showFCLAndZFL(aniName, coinGet,endPos)
    if aniName == "H5_zhuanpan" or aniName == "animation" then
        return
    end
    local prefabUrl = "Effects/H5_Facaile"
    local positon = Vector3.New(0, 0, 1000)
    ---@type GComponent
    local item = UIPackage.CreateObject("Fish", "CatchShowItem")
    ---@type GGraph
    local holder = item:GetChild("holder")
    local numText = item:GetChild("numText")
    local textAni = item:GetTransition("textAni")
    local endAni = item:GetTransition("endAni")
    local facaiAni = SpineManager.create(prefabUrl, positon, 1, holder)
    item.position = Vector3.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2, 1000)
    FishLayer.instance.effectLayer:AddChild(item)
    numText.text = coinGet
    textAni:Play()
    facaiAni:play(aniName, false, function()
        GameTimer.once(500, self, function()
            item:TweenMove(endPos, 0.5)
            endAni:Play(function()
                facaiAni:destroy()
                numText:RemoveFromParent()
                numText:Dispose()
                item:Dispose()
            end)
        end)
    end)
end

--全屏金币
function EffectManager.playFullScreenCoinEffect(pos)
    local item = UIPackage.CreateObject("Fish", "FullScreenCoinItem")
    item.width = GameScreen.instance.adaptWidth
    item.height = GameScreen.instance.adaptHeight
    item.pivot = Vector2.New(0.5, 0.5)
    item.pivotAsAnchor = true
    item.position = pos or Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)

    ---@type GGraph
    local holder = item:GetChild("Holder")
    holder.position = pos or Vector2.New(GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptHeight / 2)
    local prefabUrl = "Effects/JinBi"
    local position = Vector3.New(0, 0, 1000)
    local ani = SpineManager.create(prefabUrl, position, 1, holder)
    FishLayer.instance.effectLayer:AddChild(item)
    -- UIFishPage.instance.douDongAni:Play()
    GameTools.fullScreenShake()
    ani:play("mode1", false, function()
        ani:destroy()
        item:Dispose()
    end)
end

--锁定闪电
function EffectManager.playLaser(pos, parent)
    local laserRoot = GGraph.New()
    parent:AddChild(laserRoot)
    laserRoot:SetPosition(pos.x, pos.y, 0)
    ---@type GameObject
    local laser = GameTools.ResourcesLoad("Effects/Laser/lightning_s")
    ---@type GoWrapper
    local laserWrapper = GoWrapper.New(laser)
    laserRoot:SetNativeObject(laserWrapper)
    return laserWrapper, laser;
end

--连环炸弹光圈
function EffectManager.playLightSpine(x, y, spRoot, seatId)
    local prefabUrl = "Effects/EffectLianHuanZhaDan/select_lianhuanzhadan"
    local spineItem = GameTools.ResourcesLoad(prefabUrl)

    local material = spineItem.transform:GetChild(0).transform:Find("circle1").gameObject:GetComponent("Renderer").material
    local materialUrl = "Assets/Res/3d/lianhuanzhadan_burst/Materials/ring_0" .. seatId .. ".mat"
    local newMaterial = Resource:loadAssert(materialUrl, ResourceType.mat)

    material.mainTexture = newMaterial:GetTexture(1)

    material = spineItem.transform:GetChild(0).transform:Find("circle2").gameObject:GetComponent("Renderer").material
    materialUrl = "Assets/Res/3d/lianhuanzhadan_burst/Materials/fangshe_0" .. seatId .. ".mat"
    newMaterial = Resource:loadAssert(materialUrl, ResourceType.mat)
    material.mainTexture = newMaterial:GetTexture(1)

    local wrapper = GoWrapper.New(spineItem)
    wrapper:CacheRenderers()
    local graph = GGraph.New()
    graph:SetNativeObject(wrapper)
    graph.x = x
    graph.y = y
    wrapper.visible = true
    spRoot:AddChild(graph)
    return wrapper
end

--连环炸弹
function EffectManager.playBoomSpine(x, y, spRoot)
    local prefabUrl = "Effects/EffectLianHuanZhaDan/Burst_lianhuanzhadan"
    local spineItem = GameTools.ResourcesLoad(prefabUrl)
    local wrapper = GoWrapper.New(spineItem)
    local graph = GGraph.New()
    graph:SetNativeObject(wrapper)
    graph = wrapper.gOwner
    graph.x = x
    graph.y = y
    spRoot:AddChild(graph)
    -- TODO 暂时通过改变visible让粒子重头开始播放
    wrapper.visible = false
    wrapper.visible = true
    return wrapper
end

--boss死亡月牙光效果
function EffectManager.playAppear(pos)
    local Appear = SpecialEffect.playAppear()
    Appear.position = pos
    return Appear
end

--boss死亡金币效果
function EffectManager.playBurstCoin(pos)
    local brustCoin = SpecialEffect.playBurstCoin()
    brustCoin.position = pos
    return brustCoin
end

--播放炸弹效果
function EffectManager:playBoomEffect(x, y)
    local yuleiEffect = SpecialEffect.playBurstYulei()
    yuleiEffect.position = Vector2.New(x, y)
    GameTimer.once(2000, self, function()
        yuleiEffect:RemoveFromParent()
        yuleiEffect:Dispose()
    end)
end


---@param fish Fish2D
---@param getCoinInfo ShowGetCoinInfo
---@param seat_id number
---@param delayShow number
---@param refPos Vector2
---@param coinNum number
---@param agent number
---@param boomShow boolean
---@param 飘金币的效果,实际不加金币
function EffectManager.showNormalFishCoinGetEffect(fish, getCoinInfo, seat_id, delayShow, refPos, coinNum, agent, boomShow, isDelay, boosType, aniType, isAddCoin)
    delayShow = 0
    -- 兼容原来的接口，默认给true
    if isAddCoin == nil then
        isAddCoin = true
    end
    if fish.fishCfg.catch_show == "" then
        fish.fishCfg.catch_show = -1
    end
    if (fish.fishCfg.catch_show <= 0 or fish.fsm:isInState(StateFishDead) or boomShow) and (coinNum ~= 0) then
        if not isDelay then
            local fontClip = Pool.createByClass(FontClipEffect)
            fontClip:create(coinNum, refPos, delayShow, fish, boosType, seat_id, agent, getCoinInfo, isAddCoin)
            fontClip:numFlyPlay(aniType)
        end
    end
end 