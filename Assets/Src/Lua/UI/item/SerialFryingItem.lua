SerialFryingItem = class("SerialFryingItem")
function SerialFryingItem:ctor()
    self.count = 0 -- 第几次跳
    self.catchFishes = {} -- 碰撞捕获的鱼
    ---@type GComponent
    self.item = nil -- 动画的组件
    self.SPINE_PATH = "Effects/EffectLianHuanZhaDan/3zhuang" -- 骨骼动画的路径
    -- self.spineScale = 1
    -- self.spineItem = nil
    self.aniSp = nil
    self.wrapper = nil
    self.animator = nil
end

function SerialFryingItem:resetCatchFishes()
    self.catchFishes = nil
    self.catchFishes = {}
end

function SerialFryingItem:clearItem()
    -- if self.spineItem then
    --     self.spineItem:stop()
    --     self.spineItem:destroy()
    -- end
    if self.animator then
        -- self.animator:Stop()
    end
    if self.wrapper then
        -- self.wrapper:RemoveFromParent()
        -- self.wrapper:Dispose()
    end
    if self.item then
        self.item:RemoveFromParent()
        -- self.item:Dispose()
    end
end

function SerialFryingItem:reset()
    self.count = 0
    self:resetCatchFishes()
end

function SerialFryingItem:getItem()
    local item = self.item
    if not item then
        item = UIPackage.CreateObject("Fish", "SerialFryingItem")
        self.aniSp = item:GetChild("aniSp")
        -- local position = Vector3.New(0, 0, 0)
        -- self.spineItem = SpineManager.create(self.SPINE_PATH, position, self.spineScale, self.aniSp)
        -- self.spineItem:play("animation", true)
        local prefabUrl = 'Fish/zhadanxie_down'    
        local spineItem = GameTools.ResourcesLoad(prefabUrl)
        -- 手动调节大小和炸弹蟹一样
        spineItem.transform.localPosition = Vector3.New(80, 50, 0)
        spineItem.transform.localScale = Vector3.New(1.5, 1.5, 1.5)
        self.wrapper = GoWrapper.New(spineItem)
        self.aniSp:SetNativeObject(self.wrapper)
        self.item = item
    end
    return item
end

function SerialFryingItem:recover()
    self:reset()
    self:clearItem()
    Pool.recoverByClass(self)
end

function SerialFryingItem.create()
    local item = Pool.createByClass(SerialFryingItem)
    return item
end

function SerialFryingItem:init(count, isShow)
    self.count = count
    self:showCount(count)
    self:showAni(isShow)
    -- 中途退出的时候，item的visible会被设置成false,需要设置回来
    local item = self:getItem()
    if item then
        item.visible = true
    end
end

function SerialFryingItem:showCount(count)
    local item = self:getItem()
    local rateText = item:GetChild("countFt")
    --- 展示从1开始，内容使用从1开始
    rateText.text = count
end

function SerialFryingItem:setAniScale(scaleNum)
    local item = self:getItem()
    item.scaleX = scaleNum
    item.scaleY = scaleNum
end

function SerialFryingItem:setAniAngle(angle)
    local item = self:getItem()
    item.rotation = angle
end

function SerialFryingItem:showAni(isShow)
    local aniSp = self.aniSp
    aniSp.visible = isShow
end

function SerialFryingItem:updCatchFishes(fishes)
    local index = 0
    local catchFishes = self.catchFishes
    local len = 0
    if catchFishes then
        len = #fishes
    end
    if len < 1 then
        return
    end
    for _, fish in ipairs(fishes) do
        --- 只有能移除的才移除
        if (fish and fish.fishCfg and fish.fishCfg.canRemove == 1) then
            index = table.indexOf(catchFishes, fish.uniId)
            if (index < 0) then
                table.insert(catchFishes, fish.uniId)
            end
        end
    end
end

function SerialFryingItem:updPos(x, y)
    self:pos(x, y)
    local aniSp = self.aniSp
    local aniSpWidth = aniSp.width * aniSp.scaleX
    local aniSpHeight = aniSp.height * aniSp.scaleY
    local rotation = aniSp.rotation
    -- 根据适配计算碰撞矩形宽高
    FightTools.TEMP_POINT1.x = aniSpWidth
    FightTools.TEMP_POINT1.y = aniSpHeight
    GameScreen.instance:designToAdapt(FightTools.TEMP_POINT1, FightTools.TEMP_POINT1)
    aniSpWidth = FightTools.TEMP_POINT1.x
    aniSpHeight = FightTools.TEMP_POINT1.y

    local rect = CollisionRect.create(x, y, aniSpWidth, aniSpHeight, rotation)
    local fishes = Fishery.instance:rectCollision(rect)
    self:updCatchFishes(fishes)
end

function SerialFryingItem:pos(x, y)
    local item = self:getItem()
    item.x = x
    item.y = y
end

function SerialFryingItem:getRotateAni()
    local item = self:getItem()
    return item:GetTransition("rotateAni")
end

function SerialFryingItem:getScaleAni()
    local item = self:getItem()
    return item:GetTransition("scaleAni")
end

function SerialFryingItem:endCatchFish(agentId, isEnd)
    local c2s = C2s_12122.create()
    c2s:init(self.catchFishes, FightConst.fish_death_type_boom_fish_boom, isEnd, agentId)
    c2s:sendMsg()
    self:resetCatchFishes()
end