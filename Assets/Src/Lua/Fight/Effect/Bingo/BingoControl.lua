---@class BingoControl
BingoControl = class("BingoControl")
function BingoControl:ctor()
    self.parent = nil
    self.relativeMirrorFlag = nil
    ---@type table BingoSingle
    self.bingoArr = {}
    ---@type number 当前显示的bingo数量
    self.curBingoSum = 0

    ---@type GComponent
    self.bingoTitleParent = nil
    ---@type GComponent
    self.bingoNumParent = nil
    ---@type GComponent
    self.bingoFinalParent = nil
end

---@return BingoControl 创建bingo控制单位
function BingoControl.creatBingoControl(playerComponent, relativeMirrorFlag, seadId)
    local temp = BingoControl.New()
    temp:initData(playerComponent, relativeMirrorFlag, seadId)
    return temp
end

function BingoControl:initData(playerComponent, relativeMirrorFlag, seadId)
    self.parent = playerComponent
    self.relativeMirrorFlag = relativeMirrorFlag
    self.seadId = seadId
    if self.bingoTitleParent == nil then
        self.bingoTitleParent = self.parent:GetChild("bingoTitle")
        self.bingoNumParent = self.parent:GetChild("bingoNum")
        self.bingoFinalParent = self.parent:GetChild("bingoFinalScore")
    end
end

---@param value number 玩家炮倍
---@param type number 参数类型是BingoType
---@param bingoCount number 除旋风鱼以外都为nil
---@param startX number can nil
---@param startY number can nil
---@param endX number can nil
---@param endY number can nil
function BingoControl:showBingo(batteryLevel, type, bingoCount, startX, startY, endX, endY)
    if not bingoCount then
        bingoCount = type
    end
    local obj = self:getCurBingSingle(type, bingoCount)
    obj:BingoFirstStep(batteryLevel, type, startX, startY, endX, endY)
end

---@param bingoCount number 除旋风鱼以外都为nil
---@param initVal number 初始化数值
---@param totalVal number 目标数值
---@param totalTime number 总用时长(单位毫秒)
---@param addVal number 每次增加的数值
function BingoControl:startShowNum(type, bingoCount, initVal, totalVal, totalTime, addVal)
    if not bingoCount then
        bingoCount = type
    end
    if not self.bingoArr[type] or not self.bingoArr[type][bingoCount] then
        return
    end
    local obj = self.bingoArr[type][bingoCount]
    obj:BingoSecondStep(initVal, totalVal, totalTime, addVal)
end

---@param bingoCount number 除旋风鱼以外都为nil
---@param score number 分数
---@param func function 动画结束后执行
---@param isDelay number 是否延迟执行动画
---@return void 设置bingo最后分数
function BingoControl:bingoEnd(type, bingoCount, score, funcSelf, func, isDelay)
    if not bingoCount then
        bingoCount = type
    end
    if not self.bingoArr[type] or not self.bingoArr[type][bingoCount] then
        if isDelay then
            GameTimer.once(3000, self, function()
                if func ~= nil then
                    func(funcSelf)
                end
            end)
        else
            if func ~= nil then
                func(funcSelf)
            end
        end
        return
    end
    local obj = self.bingoArr[type][bingoCount]
    obj:BingoThirdStep(self.relativeMirrorFlag, self.seadId, score, funcSelf, func, isDelay)
end

---@param bingoCount number 除旋风鱼以外都为nil
function BingoControl:resetUi(type, bingoCount)
    if not type then
        for i, v in pairs(self.bingoArr) do
            local arr = self.bingoArr[i]
            for j, z in pairs(arr) do
                local obj = arr[j]
                if obj then
                    obj:disposeState()
                    arr[j] = nil
                end
            end
        end
    else
        if not bingoCount then
            bingoCount = type
        end
        if not self.bingoArr[type] or not self.bingoArr[type][bingoCount] then
            return
        end
        local obj = self.bingoArr[type][bingoCount]
        obj:disposeState()
        self.bingoArr[type][bingoCount] = nil
    end
end

---@param bingoCount number 除旋风鱼以外都为nil
function BingoControl:aloneSetFinalScore(type, bingoCount, score)
    if not bingoCount then
        bingoCount = type
    end
    if not self.bingoArr[type] or not self.bingoArr[type][bingoCount] then
        return
    end
    local obj = self.bingoArr[type][bingoCount]
    obj:aloneSetFinalScore(score, self.seadId, true)
end

---@return BingoSingle 获取当前
------@param bingoCount number 除旋风鱼以外都为nil
function BingoControl:getCurBingSingle(type, bingoCount)
    if not self.bingoArr[type] then
        self.bingoArr[type] = {}
    end
    if #self.bingoArr[type] <= 0 or not self.bingoArr[type][bingoCount] then
        self.bingoArr[type][bingoCount] = BingoSingle.creatBingoSingle(type, self.relativeMirrorFlag, self.bingoTitleParent, self.bingoNumParent, self.bingoFinalParent)
    end
    return self.bingoArr[type][bingoCount]
end

function BingoControl:getWhirlwindPosition(bingoCount)
    local obj = self.bingoArr[BingoType.WhirlwindFish][bingoCount]
    return obj:getWhirlwindPosition()
end

function BingoControl:getBingoTypeRandom(type)
    local random = math.random(1, 100)
    local temp = tonumber(tostring(type) .. tostring(random))
    if not self.bingoArr[type] then
        self.bingoArr[type] = {}
    end
    if self.bingoArr[type][temp] ~= nil then
        self:getBingoTypeRandom(type)
    else
        return temp
    end
end

function BingoControl:isBingoPlaying()
    local result = false
    if #self.bingoArr > 0 then
        for i, v in pairs(self.bingoArr) do
            local arr = self.bingoArr[i]
            for j, z in pairs(arr) do
                local obj = arr[j]
                if obj and obj:BaseComVisible() == true then
                    result = true;
                    break
                end
            end
            if result then
                break
            end
        end
    end
    return result
end

--同步bingo--------------------------
---@param value number 玩家炮倍
---@param type number 参数类型是BingoType
---@param bingoCount number 除旋风鱼以外都为nil
function BingoControl:synBingoShow(batteryLevel, type, bingoCount, score)
    if not bingoCount then
        bingoCount = type
    end
    local obj = self:getCurBingSingle(type, bingoCount)
    obj:showBingoTitle(batteryLevel, false, score)
end
