---@class SpecialPaoEffect
---@field New SpecialPaoEffect
SpecialPaoEffect = class("SpecialPaoEffect", EffectBase)
function SpecialPaoEffect:ctor()
    SpecialPaoEffect.super.ctor(self)
    ---@type GLoader
    self.img = nil
    self.startX = nil
    self.startY = nil
    self.endX = nil
    self.endY = nil
    self.seatId = nil
    self.typeId = nil
    self.itemType = nil
end

function SpecialPaoEffect.create(startX, startY, endX, endY, itemType, seatId, parent)
    local item = Pool.createByClass(SpecialPaoEffect)
    SpecialPaoEffect.super.InitInfo(item)
    item:init(startX, startY, endX, endY, itemType, seatId, parent)
    -- 钻头炮掉落的音效
    if FightConst.goods_type_zuantoupao == itemType then
        GameTools.playRandomMusic("zuantoupao_get", ".wav", 1, 3)
    end
    return item
end

function SpecialPaoEffect:reset()
    self.startX = 0
    self.startY = 0
    self.endX = 0
    self.endY = 0
    -- GTween.Kill(self.img)
    self.img:RemoveFromParent()
    -- self.img:Dispose()
end

function SpecialPaoEffect:recover()
    self:reset()
    Pool:recoverByClass(self)
end

function SpecialPaoEffect:Destroy()
    SpecialPaoEffect.super.Destroy(self)
    self:reset()
    self.img:Dispose()
end

function SpecialPaoEffect:init(startX, startY, endX, endY, itemType, seatId, parent)
    self.startX = startX
    self.startY = startY
    self.endX = endX
    self.endY = endY
    self.itemType = itemType
    self.seatId = seatId
    local cfgGoods = cfg_goods.instance(itemType)
    local goodsIcon = nil
    if cfgGoods then
        goodsIcon = cfgGoods.waceIcon
        self.typeId = cfgGoods.typeID
    end
    if self.img then
        self.img.url = goodsIcon
    else
        self.img = GLoader.New()
        self.img:SetSize(420, 450)
        self.img.pivot = Vector2.New(0.5, 0.5)
        self.img.pivotAsAnchor = true
        -- self.img:SetPivot(0.5, 0.5)

        self.img.url = goodsIcon
    end
    parent:AddChild(self.img)
end

function SpecialPaoEffect:play()
    self.img.x = self.startX
    self.img.y = self.startY
    local dx = self.endX - self.startX
    local dy = self.endY - self.startY
    local distance = math.sqrt(dx * dx + dy * dy)
    -- TweenMove的时间单位是秒,所以速度要调成h5版的1000倍
    local speed = 500
    local endVec = Vector2.New(self.endX, self.endY)
    self.img:TweenMove(endVec, distance / speed):OnComplete(function()
        local seatInfo = SeatRouter.instance:getSeatById(self.seatId)        
        local cfgSkin = cfg_battery_skin.instance(seatInfo.skinId)
        -- 修正多次获得特殊炮导致切换皮肤为特殊炮的bug
        if cfgSkin and cfgSkin.is_one_time == 0  and SeatRouter.instance.mySeatId == self.seatId then --
            RoleInfoM.instance:setLastSkinID(seatInfo.skinId)
        end
        if self.seatId == SeatRouter.instance.mySeatId then
            GameEventDispatch.instance:event(GameEvent.ChangeSkin, self.typeId)
        end
        self:recover()
    end)
end