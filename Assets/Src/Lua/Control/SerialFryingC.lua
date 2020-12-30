---@class SerialFryingC
SerialFryingC = class("SerialFryingC")
function SerialFryingC:ctor()
    -- 每次表现显示的积分数组
    self.counts = {}
    -- 每只鱼显示的积分数组
    self.fishCounts = {}
    self.totalTp = 0
    self.bRate = 0
    -- 当前展示的鱼的积分顺序
    self.curFishCount = 1
end


function SerialFryingC:getCountByPoint(point, bRate)
    local count = 0
    local curVal = point
    local maxVal = bRate * 10
    while curVal > 0 do
        count = count + 1
        curVal = curVal - maxVal
        maxVal = maxVal * 2
    end
    return count
end

function SerialFryingC:getCountPoints(count, endX, endY)
    local ret = {}
    local width = FightContext.instance.designWidth
    local height = FightContext.instance.designHeight
    local randomX = endX
    local randomY = endY
    local rate = 0.5
    local randomRet = 0
    for i = 1, count, 1 do
        randomRet = math.random()
        if randomRet > rate then
            if (randomX > width / 2) then
                randomX = width / 3 - FightTools:getRandomNumber(-100, 100)
            else
                randomX = width / 3 * 2 + FightTools:getRandomNumber(-100, 100)
            end
        else
            randomX = randomX + FightTools:getRandomNumber(-100, 100)
        end
        if (randomRet <= rate) then
            if (randomY > height / 2) then
                randomY = height / 3 - FightTools:getRandomNumber(-50, 50)
            else
                randomY = height / 3 * 2 + FightTools:getRandomNumber(-50, 50)
            end
        else
            if (randomRet > rate + (1 - rate) / 3) then
                randomY = height / 3 - FightTools:getRandomNumber(-50, 50)
            elseif (randomRet > rate + (1 - rate) / 3 * 2) then
                randomY = height / 3 * 2 + FightTools:getRandomNumber(-50, 50)
            else
                randomY = randomY + FightTools:getRandomNumber(-50, 50)
            end
        end
        table.insert(ret, {["x"] = randomX, ["y"] = randomY })
    end
    return ret
end

function SerialFryingC:sendMsg(startX, startY, endX, endY, point)
    local seatInfo = SeatRouter.instance.mySeat
    local bRate = 0
    if seatInfo then
        bRate = seatInfo._batteryContext:consume()
    end
    local count = self:getCountByPoint(point, bRate)
    local countPoints = self:getCountPoints(count, endX, endY)
    local c2s = C2s_12120.create()
    local sceneId = FightM.instance.sceneId
    c2s:init(startX, startY, endX, endY, bRate, point, countPoints, sceneId)
    c2s:sendMsg()
end

function SerialFryingC:onMsgRet(data)
    local flyObj = SerialFryingItem.create()
    flyObj:reset()

    local boomLayer = FishLayer.instance.effectLayer
    local protoFrying = ProtoSerialFrying.create()
    protoFrying:parse(data)
    local effect = SerialFryingEffect.create(protoFrying.startX, protoFrying.startY, protoFrying.endX, protoFrying.endY, flyObj, protoFrying.points, protoFrying.agentId, protoFrying.bRate, protoFrying.tp, protoFrying.sceneId, boomLayer)
    effect:play()
    local seat = SeatRouter.instance:getSeatByAgent(protoFrying.agentId)
    seat:changeToWait()
end

function SerialFryingC:reset()
    self.counts = {}
    self.fishCounts = {}
    self.totalTp = 0
    self.bRate = 0
    self.curFishCount = 1
end

function SerialFryingC:getShowPoint()
    local ret = 0
    local arr = self.fishCounts
    local fishCount = self.curFishCount
    if arr[fishCount] then
        ret = arr[fishCount] or self.bRate
    end
    return ret
end

function SerialFryingC:getShowPointEx()
    local ret = self:getShowPoint()
    self.curFishCount = math.min(self.curFishCount + 1, #self.fishCounts + 1)
    return ret
end

function SerialFryingC:setTotalPoint(tp, num, bRate)
    local arr = self.counts
    if self.tp ~= tp or num ~= #arr or self.bRate ~= bRate then
        self.tp = tp
        self.bRate = bRate
        self.counts = {}
        self.fishCount = {}
        self.curFishCount = 1
        arr = self.counts
        local totalVal = tp
        -- 分数大致平均
        for i = 1, num, 1 do
            local val = math.floor(totalVal / (num - i + 1) / bRate) * bRate
            totalVal = totalVal - val
            table.insert(arr, val)
        end
    end
end

function SerialFryingC:setSinglePoint(tp, totalNum, num, fishCount, bRate)
    self:setTotalPoint(tp, totalNum, bRate)
    local arr = self.fishCounts
    local totalVal = self.counts[num]
    -- 分数大致平均
    for i = 1, fishCount, 1 do
        local val = math.floor(totalVal / (fishCount - i + 1) / bRate) * bRate
        totalVal = totalVal - val
        table.insert(arr, val)
    end
end