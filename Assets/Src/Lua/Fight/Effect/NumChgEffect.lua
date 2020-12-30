---@class NumChgEffect
---@field New NumChgEffect
NumChgEffect = class("NumChgEffect")
function NumChgEffect:ctor()
    --- @type number
    self.addVal = 0
    --- @type number
    self.initVal = 0
    --- @type number
    self.totalVal = 0
    --- @type number
    self.curVal = 0
    --- @type number
    self.totalTime = 0
    --- @type number
    self.interval = 1
    --- @type GTextField
    self.numFt = nil
    --- @type GameTimer
    self.timer = nil
    self.runTime = 0
end

function NumChgEffect.create(numFt, initVal, totalVal, totalTime, addVal)
    local item = Pool.createByClass(NumChgEffect)
    item:init(numFt, initVal, totalVal, totalTime, addVal)
    return item
end

function NumChgEffect:onCompleted()
    self:recover()
end
function NumChgEffect:addEvtLsn()
    GameEventDispatch.instance:On(GameEvent.FightStop, self, self.onCompleted)
end
function NumChgEffect:rmvEvtLsn()
    GameEventDispatch.instance:Off(GameEvent.FightStop, self, self.onCompleted)
end

function NumChgEffect:recover()
    self.addVal = 0
    self.initVal = 0
    self.totalVal = 0
    self.runTime = 0
    self:rmvEvtLsn()
    if self.timer then
        self.timer:clear()
    end
    Pool.recoverByClass(self)
end

function NumChgEffect:init(numFt, initVal, totalVal, totalTime, addVal)
    self.numFt = numFt
    self.initVal = initVal
    self.totalVal = totalVal
    self.totalTime = totalTime
    self.addVal = addVal
    -- local count = 0
    -- if self.addVal == 0 then
    --     count = math.ceil(self.totalTime / UnityEngine.Time.deltaTime / self.interval / 1000)
    --     self.addVal = math.max(math.floor((totalVal - initVal) / count), 1)
    -- else
    --     count = math.ceil((totalVal - initVal) / addVal)
    --     self.interval = math.min(math.floor(totalTime / count / UnityEngine.Time.deltaTime / 1000), 2)
    -- end
    self:addEvtLsn()
    self.curVal = self.initVal
    self:showVal()
end

function NumChgEffect:play()
    self.curVal = self.initVal
    self.runTime = 0
    self.timer = GameTimer.frameLoop(self.interval, self, self.updVal)
end

function NumChgEffect:showVal()
    self.numFt.text = self.curVal
end

function NumChgEffect:updVal()
    self.runTime = self.runTime + UnityEngine.Time.deltaTime * 1000
    self.curVal = self.initVal + math.floor((self.totalVal - self.initVal) / self.totalTime * self.runTime)
    -- self.curVal = self.curVal + self.addVal
    self.curVal = math.min(self.curVal, self.totalVal)
    self:showVal()
    if self.curVal >= self.totalVal then
        self:recover()
    end
end