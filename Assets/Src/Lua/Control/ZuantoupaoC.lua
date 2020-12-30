---@class ZuantoupaoC
ZuantoupaoC = class("ZuantoupaoC")
function ZuantoupaoC:ctor()
    -- 每只鱼显示的积分数组
    self.counts = {}
    self.totalTp = 0
    self.bRate = 0
    -- 当前展示的鱼的积分顺序
    self.curFishCount = 1
end

function ZuantoupaoC:reset()
    self.counts = {}
    self.totalTp = 0
    self.bRate = 0
    self.curFishCount = 1
end

function ZuantoupaoC:getShowPoint()
    local ret = 0
    local arr = self.counts
    local fishCount = self.curFishCount
    if arr[fishCount] then
        ret = arr[fishCount] or self.bRate
    end
    return ret
end

function ZuantoupaoC:getShowPointEx()
    local ret = self:getShowPoint()
    self.curFishCount = math.min(self.curFishCount + 1, #self.counts + 1)
    return ret
end

function ZuantoupaoC:setTotalPoint(tp, num, bRate)
    local arr = self.counts
    if self.tp ~= tp or num ~= #arr or self.bRate ~= bRate then
        self.tp = tp
        self.bRate = bRate
        self.counts = {}
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