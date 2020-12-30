---@class FullScreenCoinEffectSingle
FullScreenCoinEffectSingle = class("FullScreenCoinEffectSingle")
function FullScreenCoinEffectSingle:ctor()
    self.image = nil
    self.imageWrapper = GComponent.New()
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    self.delay = 0
    self.parent = nil
    self.ani_play_time = 0
    self.play_time = 1000
    self.play_time_offset = 2500
    self.is_end = false
    self.maxNumber = 12
    self.minNumber = 6
    self.c = 0
end

function FullScreenCoinEffectSingle.create(startX, startY, endX, endY, scaleX, scaleY, skewX, skewY, delay, parent)
    local obj = FullScreenCoinEffectSingle.New()
    --local obj = Pool:getItemByClass("FullScreenCoinEffectSingle", FullScreenCoinEffectSingle)
    obj:init(startX, startY, endX, endY, scaleX, scaleY, skewX, skewY, delay, parent)
    return obj
end

function FullScreenCoinEffectSingle:init(startX, startY, endX, endY, scaleX, scaleY, skewX, skewY, delay, parent)
    self.startX = startX
    self.startY = startY
    self.endX = endX
    self.endY = endY
    self.delay = delay
    self.parent = parent
    self.ani_play_time = self.play_time + self:random(self.play_time_offset)
    self.c = (math.random() * (self.maxNumber - self.minNumber) + self.minNumber) / 10
    local aniName = "Coin1"
    if not self.image then
        self.image = AnimalManger.create("Assets/Res/UI/Animation/Animation",
                "Animation", aniName)
        self.image:setPivot(0.5, 0.5)
        self.image:play(true)
        self.image:addTo(self.imageWrapper)
    end
    self.imageWrapper.x = startX
    self.imageWrapper.y = startY
    self.imageWrapper.scaleX = scaleX
    self.imageWrapper.scaleY = scaleY
    self.image:setSkew(skewX, skewY)
    self.imageWrapper.visible = true
    self.is_end = false
    FishLayer.instance.effectLayer:AddChild(self.imageWrapper)
end

function FullScreenCoinEffectSingle:clear()
    self.imageWrapper.alpha = 1
    self.imageWrapper.visible = false
    self.image:destroy()
    self.is_end = true
    self.imageWrapper:Dispose()
    --Pool:recover("FullScreenCoinEffectSingle", self)
end

function FullScreenCoinEffectSingle:update(cur_time)
    local distance_percent = EaseTools:strongOut(cur_time, 0, self.c, self.ani_play_time)
    self.imageWrapper.x = self.startX + (self.endX - self.startX) * distance_percent
    self.imageWrapper.y = self.startY + (self.endY - self.startY) * distance_percent
    local speed = -math.log(cur_time / self.ani_play_time)
    --self.ani.interval = None--[TODO](35/speed)>60?60:(35/speed)
    if cur_time>(self.ani_play_time*2/3) then
        self.imageWrapper.alpha = speed
    end
    if cur_time >= self.ani_play_time then
        self:clear()
    end
end

function FullScreenCoinEffectSingle:random(num)
    return math.floor(math.random() * num)
end
