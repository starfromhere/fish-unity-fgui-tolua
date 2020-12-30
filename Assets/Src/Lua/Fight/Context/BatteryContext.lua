---@class BatteryContext
BatteryContext = class("BatteryContext")


function BatteryContext:ctor()
    --炮台皮肤id
    self._skinId = 0
    --连击发射间隔
    self._shootInterval = nil

    --射击动画名
    self._aniNameShoot = nil
    --待机动画名
    self._aniNameDaiji = nil

    --碰撞次数
    self._catchCount = nil
    --多少发子弹
    self._multi = nil
    --炮id
    self._batteryId = nil
    --一炮消耗金币数
    self._consume = nil
    -- 子弹移动的速度
    self._speed = nil
    -- 击中后使用的网的特效名
    self._netEffectName = nil

end




function BatteryContext:netEffectName(value)
    local a = value or nil
    if a == nil then
        return self._netEffectName;
    else
        self._netEffectName = a;
    end
end

function BatteryContext:speed(value)
    local a = value or nil
    if a == nil then
        return self._speed;
    else
        self._speed = a;
    end
end

function BatteryContext:batteryId(value)
    local a = value or nil
    if a == nil then
        return self._batteryId;
    else
        self._batteryId = a;
    end
end

function BatteryContext:consume(value)
    local a = value or nil
    if a == nil then
        return self._consume;
    else
        self._consume = a;
    end
end

---shootInterval
---@public
---@param value table
---@return void
function BatteryContext:shootInterval(value)
    local a = value or nil
    if a == nil then
        return self._shootInterval;
    else
        self._shootInterval = a;
    end
end

function BatteryContext:aniName(value)
    local a = value or nil
    if a == nil then
        return self._aniName;
    else
        self._aniName = a;
    end
end

function BatteryContext:catchCount(value)
    local a = value or nil
    if a == nil then
        return self._catchCount;
    else
        self._catchCount = a;
    end
end

function BatteryContext:multi(value)
    local a = value or nil
    if a == nil then
        return self._multi;
    else
        self._multi = a;
    end
end

function BatteryContext:skinId(value)
    local a = value or nil
    if a == nil then
        return self._skinId;
    else
        self._skinId = a;
    end
end
