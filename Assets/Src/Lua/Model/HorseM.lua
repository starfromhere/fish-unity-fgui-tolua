---@class HorseM
---@field public instance HorseM
HorseM = class("HorseM")
function HorseM:ctor()
    self.isI = false
    self._isOpenNotice = false
    self._noticeTime = 30        -- 分钟
    self._oneTimesNotice = true
    self._oneTimes = 1                        -- 分钟
    self._horseTipArray = {
        { id = 1, a6 = 300, agent = true },
        { id = 3, a6 = 700, agent = true },
        { id = 6, a6 = 100, agent = true },
        { id = 4, a6 = 800, agent = false },
        { id = 5, a6 = 500, agent = true },
        { id = 3, a6 = 134, agent = false }
    }
    ---@type table
    self._resetArr = nil
    ---@type number
    self._repeatNum = nil
    self._horseTipArray = {}
end

function HorseM:addHorseTipItem(data)
    table.insert(self._horseTipArray, data)
end

function HorseM:setInfo()
    self.isI = true
end

function HorseM:getHorseTipNum()
    return #self._horseTipArray
end

function HorseM:getRepeatNum()
    if #self._horseTipArray > 50 then
        return 1
    end
    return 3
end

function HorseM:getHtml()
    self:resetArr()
    local html = ""
    local bitNum = 0
    if #self._horseTipArray > 0 then
        local tipData = self._horseTipArray[1]
        if tipData.id ~= 5 then
            local agent
            if tipData.agent then
                agent = 1
            else
                agent = 0
            end
            if SeatRouter.instance:getSeatInfoByAgent(agent) ~= nil then
                self:setRepeatNum(3)
            else
                self:setRepeatNum(1)
            end
            if agent < 0 then
                self:setRepeatNum(1)
            end
        else
            self:setRepeatNum(3)
        end
        table.remove(self._horseTipArray, 1)
        local id = tipData.id
        local cfg = cfg_hourse.instance(id)
        local conent
        local isName = false
        bitNum = 0
        for i = 1, 7 do
            local idTmp = cfg["txt" .. tostring(i)]
            if i == 1 and idTmp == 1 then
                isName = true
            end
            if idTmp > 0 then
                conent = self:getContent(idTmp)
                if 1 == self:getType(idTmp) then
                    if isName and i == 2 then
                        conent = GameTools.filterName(FightTools:formatNickName(tipData["a" .. tostring(i)]))
                    else
                        conent = tostring(tipData["a" .. tostring(i)])
                    end
                    conent = string.gsub(conent, "/[&<>]/g", "")
                    --TODO 渠道获取
                    if ENV.channelType == 3 then
                        conent = string.gsub(conent, "集结号", "联机捕鱼")
                    end
                end
                bitNum = bitNum + #tostring(conent)
                html = html .. "[color=" .. self:getColor(idTmp) .. "]" .. conent .. "[/color]"
            end
        end
    end
    self.htmlWith = bitNum * 12;
    return html
end

function HorseM:getHtmlWidth()
    return self.htmlWith
end

function HorseM:getCoinCount(i)
    local tipData = self._horseTipArray[i]
end

function HorseM:isSystemHorse(i)
    local tipData = self._horseTipArray[i]
    local id = tipData.id
    if id == 5 then
        return true
    else
        return false
    end
end

function HorseM:isOwn(i)
    local tipData = self._horseTipArray[i]
    if tipData.agent then
        return false
    else
        table.insert(self._resetArr, tipData)
        table.remove(self._horseTipArray, i)
        return true
    end
end

function HorseM:getContent(id)
    local cf = cfg_hId.instance(tonumber(id))
    local content = cf.txtContent
    return content
end

function HorseM:getType(id)
    local cf = cfg_hId.instance(tonumber(id))
    return cf.txtType
end

function HorseM:getColor(id)
    local cf = cfg_hId.instance(tonumber(id))
    local color = cf.txtColor
    return color
end

function HorseM:getdata()

end

--将跑马灯按照规则排序
function HorseM:resetArr()
    self._resetArr = {}
    for i, v in pairs(self._horseTipArray) do
        if self:isSystemHorse(i) then
            local obj = self._horseTipArray[i]
            table.remove(self._horseTipArray, i)
            table.insert(self._resetArr, obj)
        end
    end
    --@a S2c_21000
    --@b S2c_21000
    local comp = function(a, b)
        local coinCountA = 0
        local coinCountB = 0
        if a.a6 then
            coinCountA = a.a6
        end
        if b.a6 then
            coinCountB = b.a6
        end
        local agentA = GameTools.booleanToNumber(a.agent)
        local agentB = GameTools.booleanToNumber(b.agent)
        if SeatRouter.instance:getSeatInfoByAgent(agentA) ~= nil or SeatRouter.instance:getSeatInfoByAgent(agentB) ~= nil then
            return false
        else
            if coinCountA > coinCountB then
                return true
            end
            return false
        end
    end
    table.sort(self._horseTipArray, comp)

    if #self._resetArr > 0 then
        for k, v in ipairs(self._resetArr) do
            table.insert(self._horseTipArray, 1, self._resetArr[k])
        end
    end
    return self._horseTipArray
end

function HorseM:getNoticeTime()
    local time = self._noticeTime * 60 * 1000;
    return time;
end

function HorseM:getIsOpenNotice()
    return self._isOpenNotice;
end

---@param boo boolean
function HorseM:setIsOpenNotice(boo)
    self._isOpenNotice = boo;
end

---@return boolean
function HorseM:getIsIn()
    return self.isI
end

---@param boo boolean
function HorseM:setIsIn(boo)
    self.isI = boo;
end

function HorseM:getRepeatNum()
    return self._repeatNum
end

---@param num number
function HorseM:setRepeatNum(num)
    self._repeatNum = num
end

---@param arr table
function HorseM:setResetArr(arr)
    self._resetArr = arr
end

---@param value boolean
function HorseM:setOneTimesNotice(value)
    self._oneTimesNotice = value
end

---@return boolean
function HorseM:getOneTimesNotice()
    return self._oneTimesNotice
end

function HorseM:getOneTimes()
    local time = self._oneTimes * 60 * 1000;
    return time
end

        