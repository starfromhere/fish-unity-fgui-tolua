---@class FullScreenCoinEffect
FullScreenCoinEffect = class("FullScreenCoinEffect")

function FullScreenCoinEffect:ctor()
    self.eff_arr = {}
    self.cur_time = 0
    self.points = { 250, GameScreen.instance.adaptWidth / 2, GameScreen.instance.adaptWidth - 220, GameScreen.instance.adaptHeight / 2, GameScreen.instance.adaptHeight / 2, GameScreen.instance.adaptHeight / 2 }

end

function FullScreenCoinEffect.create(preLoad, points)
    local ret = FullScreenCoinEffect.New()
    --local ret=Pool:getItemByClass("FullScreenCoinEffect",FullScreenCoinEffect)
    ret:play(FishLayer.instance.effectLayer, points)
    if preLoad then
        ret:stop()
    end
    return ret
end

function FullScreenCoinEffect:play(parent, pts)
    self.cur_time = 0
    local scaleXs = { 1.2, 1.5, 1.3, 1.5, 1.3, 0.8, 1.1 }
    local points = pts
    if not points then
        points = self.points
    end
    local tmpIndex = 1
    for j = 1, 3 do
        local x = points[j]
        local y = points[j + 3]
        for i = 1, 60 do
            local sx = x + self:random(50) * self:random_pn()
            local ex = math.random() * GameScreen.instance.adaptWidth
            local sy = y + self:random(50) * self:random_pn()
            local ey = math.random() * GameScreen.instance.adaptHeight
            local scx = scaleXs[self:random(#scaleXs) + 1]
            local scy = scx
            local skx = math.random() * 180
            local sky = skx
            if self.eff_arr[tmpIndex] then
                self.eff_arr[tmpIndex]:init(sx, sy, ex, ey, scx, scy, skx, sky, 1, parent)
            else
                local eff = FullScreenCoinEffectSingle.create(sx, sy, ex, ey, scx, scy, skx, sky, 1, parent)
                table.insert(self.eff_arr, eff)
            end
            tmpIndex = tmpIndex + 1
        end
    end
    self.effectTimer = GameTimer.frameLoop(1, self, self.loop)
end

function FullScreenCoinEffect:loop()
    local isEnd = true
    self.cur_time = self.cur_time + Time.deltaTime*1000
    for i = 1, #self.eff_arr do
        local effect = self.eff_arr[i]
        if not effect.is_end then
            effect:update(self.cur_time)
            isEnd = false
        end
    end
    if isEnd then
        self:stop()
    end

end
function FullScreenCoinEffect:stop()
    for i = 1, #self.eff_arr do
        local effect = self.eff_arr[i]
        effect:clear()
    end
    self.effectTimer:clear()
    self.effectTimer = nil
    --Pool:recover("FullScreenCoinEffect", self)
end



function FullScreenCoinEffect:random(num)
    return math.floor(math.random() * num)
end

function FullScreenCoinEffect:random_pn()
    if math.random() > 0.5 then
        return 1
    else
        return -1
    end
end
