---@class RTipM
---@field public instance RTipM
RTipM = class("RTipM")
function RTipM:ctor()
    self._imageUrl = nil
    self._urlArray = nil
    self._idArr = nil
    self._idLen = 0
    self._countArr = nil
    self._isShow = false

end

function RTipM:setInfo(url, count, ishow)
    if ishow == nil then
        ishow = false
    end
    self._countArr = count
    self._idArr = url
    if self._idArr ~= nil then
        self._idLen = #self._idArr
    end
    self._isShow = ishow
end

function RTipM:getPointList()
    local fixedX = 190;
    local fixedY = 190;
    local width = 103
    local height = 162
    local arr = {};
    local onePoint
    --local stageWidth = UnityEngine.Screen.width
    local stageWidth = GRoot.inst.width
    --local stageHeight = UnityEngine.Screen.height
    local stageHeight = GRoot.inst.height
    if self._idLen <= 7 then
        for i = 0, (self._idLen - 1) do
            onePoint = { (stageWidth - fixedX * (self._idLen - 1)) / 2 + fixedX * i - width / 2, (stageHeight / 2 - height / 2) };
            table.insert(arr, onePoint)
        end
    elseif self._idLen < 11 and self._idLen >= 8 then
        for i = 0, (self._idLen - 1) do
            if (i + 1) <= math.floor(self._idLen / 2) then
                onePoint = { (stageWidth - fixedX * (math.floor(self._idLen / 2) - 1)) / 2 + fixedX * i - width / 2, stageHeight / 2 - fixedY / 2 - height / 2 }
            else
                onePoint = { (stageWidth - fixedX * ((self._idLen - math.floor(self._idLen / 2)) - 1)) / 2 + fixedX * (i - math.floor(self._idLen / 2)) - width / 2, stageHeight / 2 + fixedY / 2 - height / 2 }
            end
            table.insert(arr, onePoint)
        end
    else
        return nil;
    end
    ConfigManager.dump_table(arr)
    return arr;
end

function RTipM:getCountArr()
    return self._countArr;
end

function RTipM:getIsShow()
    return _isShow;
end

function RTipM:getImageArr()
    self._urlArray = {}
    if self._idArr ~= nil then
        for i = 1, #self._idArr do
            local goods = cfg_goods.instance(tonumber(self._idArr[i]));
            table.insert(self._urlArray, goods.icon)
            if self._idArr[i] == GameConst.currency_exchange and self._countArr[i] then
                self._countArr[i] = ActivityM.instance:exchangeConversion(GameConst.currency_exchange, self._countArr[i])
            end
        end
    end
    return self._urlArray;
end

