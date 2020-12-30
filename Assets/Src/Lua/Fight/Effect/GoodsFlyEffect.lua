---@class GoodsFlyEffect
GoodsFlyEffect = class("GoodsFlyEffect")

---@param goodsId number
---@param startX number
---@param startY number
---@param endX number
---@param endY number
---@param delay number
---@param parent GameObject
---@param isOwn boolean
---@param rnd table
---@return nil
function GoodsFlyEffect:ctor(goodsId, startX, startY, endX, endY, delay, rnd)
    self.delay = nil;
    self.startX = nil;
    self.startY = nil;
    self.endX = nil;
    self.endY = nil;
    self.goodsId = nil;
    self.image = nil
    self.imageWrapper = GComponent.New();
    self.bezierX = nil;
    self.bezierY = nil;
    self.bezierStartX = nil;
    self.bezierStartY = nil;
    self.bezierEndX = nil;
    self.bezierEndY = nil;
    self.bezierTotalTime = nil;
    self.bezierUseTime = nil;
    self.lineDelay = nil;
    self.lineDeltaX = nil;
    self.lineDeltaY = nil;
    self.lineLeftTime = nil;
    self.lineTotalTime = nil;
    self.isAni = false;
    self.lineSpeed = 1000;
    --TODO 添加对象池管理
    --public static var _aniCacheArray:Array;
    --public static var _iconCacheArray:Array;
    self:init(goodsId, startX, startY, endX, endY, delay, rnd)
end

---@param goodsId number
---@param startX number
---@param startY number
---@param endX number
---@param endY number
---@param delay number
---@param parent GameObject
---@param isOwn boolean
---@param rnd table
---@return GoodsFlyEffect
function GoodsFlyEffect.create(goodsId, startX, startY, endX, endY, delay, rnd)
    local ret = GoodsFlyEffect.New(goodsId, startX, startY, endX, endY, delay, rnd)
    return ret
end

---@param goodsId number
---@param startX number
---@param startY number
---@param endX number
---@param endY number
---@param delay number
---@param parent GameObject
---@param isOwn boolean
---@param rnd table
---@return nil
function GoodsFlyEffect:init(goodsId, startX, startY, endX, endY, delay, rnd)
    local goodsIcon = ConfigManager.getConfValue("cfg_goods", goodsId, "waceIcon")
    if not rnd then
        rnd = { }
        for i = 1, 8 do
            rnd[i] = math.random()
        end
    end
    if not self.image then
        if (1 == goodsId) then
            local aniName = "Coin"
            self.isAni = true
            self.image = AnimalManger.create("Assets/Res/UI/Animation/Animation",
                    "Animation", aniName, true)
            self.image:setPivot(0.5, 0.5)
            self.image:addTo(self.imageWrapper)
        else
            --只有图片
            self.image = GLoader.New()
            self.image:SetSize(100, 100);
            self.image.url = tostring(goodsIcon)
            self.imageWrapper:AddChild(self.image)
        end
    else
        if (1 == goodsId) then
            self.image:play(true)
        end
    end
    FishLayer.instance.effectLayer:AddChild(self.imageWrapper);
    self.imageWrapper.x = startX;
    self.imageWrapper.y = startY;
    self.delay = delay;
    self.startX = startX;
    self.startY = startY;
    self.bezierStartX = startX;
    self.bezierStartY = startY;
    self.endX = endX;
    self.endY = endY;
    self.imageWrapper.visible = self.delay <= 0;
    local minX = 60;
    local deltaX = 60;
    local minY = 60;
    local deltaY = 60;
    local rndX;
    local rndY;
    local rndIndex = 1;
    if (rnd[rndIndex] < 0.5) then
        rndIndex = rndIndex + 1
        --左右random
        rndX = 20 -- minX + rnd[rndIndex] * deltaX;
        rndIndex = rndIndex + 1
        rndY = rnd[rndIndex] * (minY + deltaY)

    else
        rndIndex = rndIndex + 1
        --上下random
        rndY = minY + rnd[rndIndex] * deltaY;
        rndIndex = rndIndex + 1
        rndX = 20 -- rnd[rndIndex] * (minX + deltaX);
    end
    rndIndex = rndIndex + 1
    if (rnd[rndIndex] < 0.5) then
        rndIndex = rndIndex + 1
        self.bezierEndX = startX + rndX;
    else
        rndIndex = rndIndex + 1
        self.bezierEndX = startX - rndX;
    end
    if (rnd[rndIndex] < 0.5) then
        rndIndex = rndIndex + 1
        self.bezierEndY = startY + rndY;
    else
        rndIndex = rndIndex + 1
        self.bezierEndY = startY - rndY;
    end
    if (self.bezierEndX < 0) then
        self.bezierEndX = self.bezierEndX - self.bezierEndX
    elseif (self.bezierEndX > GRoot.inst.width) then
        self.bezierEndX = startX + startX - self.bezierEndX
    end
    if (self.bezierEndY < 0) then
        self.bezierEndY = self.bezierEndY - self.bezierEndY;
    elseif (self.bezierEndY > GRoot.inst.height) then
        self.bezierEndY = startY + startY - self.bezierEndY
    end
    local angle
    local len
    local radian
    self.bezierX = (startX + self.bezierEndX) / 2
    self.bezierY = math.min(startY, self.bezierEndY) - 40 - 80 * rnd[rndIndex]
    rndIndex = rndIndex + 1
    self.bezierUseTime = 0;
    self.bezierTotalTime = 0.2;
    self.lineDelay = 0.5;
    len = FightTools:distance1(Vector3.New(self.bezierEndX, self.bezierEndY, 1), Vector3.New(self.endX, self.endY, 1));
    self.lineLeftTime = len / self.lineSpeed
    self.lineTotalTime = self.lineLeftTime
    angle = FightTools:CalLineAngle(Vector3.New(self.bezierEndX, self.bezierEndY, 1), Vector3.New(self.endX, self.endY, 1));
    radian = angle * math.pi / 180;
    self.lineDeltaX = math.cos(radian);
    self.lineDeltaY = math.sin(radian);
    self.imageWrapper.scale(1, 1);
end

---@return number
function GoodsFlyEffect:getEffectTime()
    return self.delay + self.bezierTotalTime + self.lineTotalTime + self.lineDelay
end

---@param delta number
---@return nil
function GoodsFlyEffect:update(delta)
    if (self.delay > 0) then
        self.delay = self.delay - delta;
        if (self.delay <= 0) then
            self.imageWrapper.visible = true;
        end
        return
    end

    local pos_x
    local pos_y
    if (self.bezierUseTime < self.bezierTotalTime) then
        self.bezierUseTime = self.bezierUseTime + delta
        if (self.bezierUseTime > self.bezierTotalTime) then
            self.bezierUseTime = self.bezierTotalTime
        end
        local t = self.bezierUseTime / self.bezierTotalTime
        local minusT = 1 - t
        pos_x = minusT * minusT * self.bezierStartX + 2 * t * minusT * self.bezierX + t * t * self.bezierEndX
        pos_y = minusT * minusT * self.bezierStartY + 2 * t * minusT * self.bezierY + t * t * self.bezierEndY
        self.imageWrapper.x = pos_x
        self.imageWrapper.y = pos_y
    else
        if (self.lineDelay > 0) then
            self.lineDelay = self.lineDelay - delta
            return
        end
        self.lineLeftTime = self.lineLeftTime - delta;
        if (self.lineLeftTime < 0) then
            self.lineLeftTime = 0
        end
        self.imageWrapper.x = self.imageWrapper.x + self.lineDeltaX * delta * self.lineSpeed;
        self.imageWrapper.y = self.imageWrapper.y + self.lineDeltaY * delta * self.lineSpeed;
    end
end

function GoodsFlyEffect:destroy()
    if self.isAni then
        self.image.visible = false
        self.image:destroy()
        --self.aniCacheArray.push(self);
    else
        self.image:RemoveFromParent()
        self.image:Dispose()
    end
    self.imageWrapper:Dispose()
end

---@return boolean
function GoodsFlyEffect:isEnd()
    return self.lineLeftTime <= 0
end