
---@class ExchangeM
---@field public instance ExchangeM
ExchangeM = class("ExchangeM")

function ExchangeM:ctor()
    ---@type number
    --微信绑定
    self._wxIsBind = nil -- 是否已经绑定
    ---@type string
    self._wxBindTicket = nil--绑定码
    self._wxExpiredTime = nil--绑定码过期时间

    --支付宝绑定
    self._alipayIsBind = nil  --是否已经绑定
    ---@type string
    self._alipayBindTicket = nil  --绑定码
    self._alipayExpiredTime = nil  --绑定码过期时间

    --微信渠道 支付宝和微信兑换开关
    self._wx_wxExchangeOpen = false
    self._wx_alipayExchangeOpen = false

    --h5渠道 支付宝和微信兑换开关
    self._h5_wxExchangeOpen = false
    self._h5_alipayExchangeOpen = false

    --渠道 1小游戏  2非小游戏
    self._platform = 2;


    --绑定支付偏好 0:没有 1微信 2支付宝
    self._payType = 0;

    self._curSelect = 0;
end

---@return boolean
function ExchangeM:getWxExchangeOpen()
    if (self._platform == 1) then
        return self._wx_wxExchangeOpen
    else
        return self._h5_wxExchangeOpen
    end
end

---@return boolean
function ExchangeM:getAlipayExchangeOpen()
    if (_platform == 1) then
        return self._wx_alipayExchangeOpen;
    else
        return self._h5_alipayExchangeOpen;
    end
end

---@return boolean
function ExchangeM:getExchangeOpen()
    if (not self:getWxExchangeOpen() and not self:getAlipayExchangeOpen()) then
        return false
    else
        return true
    end
end
---@return boolean
function ExchangeM:isCanChangePayType()
    if (self:getWxExchangeOpen() and self:getAlipayExchangeOpen()) then
        return true
    end
    return false
end
---@return number
function ExchangeM:getPayType()
    return self._payType;
end

---@param value number
function ExchangeM:setPayType(value)
    self._payType = value;
end
---@return number
function ExchangeM:getWxIsBind()
    return self._wxIsBind;
end
---@param value number
function ExchangeM:setWxIsBind(value)
    self._wxIsBind = value
end
---@return string
function ExchangeM:getWxBindTicket()
    return self._wxBindTicket
end
---@param value string
function ExchangeM:setWxBindTicket(value)
    self._wxBindTicket = value;
end
---@return number
function ExchangeM:getWxExpiredTime()
    return self._wxExpiredTime;
end
---@param value number
function ExchangeM:setWxExpiredTime(value)
    self._wxExpiredTime = value;
end
---@return number
function ExchangeM:getAlipayIsBind()
    return self._alipayIsBind;
end
---@param value number
function ExchangeM:setAlipayIsBind(value)
    self._alipayIsBind = value;
end
---@return string
function ExchangeM:getAlipayBindTicket()
    return self._alipayBindTicket;
end
---@param value string
function ExchangeM:setAlipayBindTicket(value)
    self._alipayBindTicket = value;
end
---@return number
function ExchangeM:getAlipayExpiredTime()
    return self._alipayExpiredTime;
end
---@param value number
function ExchangeM:setAlipayExpiredTime(value)
    self._alipayExpiredTime = value;
end
---@param value boolean
function ExchangeM:setWx_wxExchangeOpen(value)
    self._wx_wxExchangeOpen = value;
end
---@param value boolean
function ExchangeM:setWx_alipayExchangeOpen(value)
    self._wx_alipayExchangeOpen = value;
end
---@param value boolean
function ExchangeM:setH5_wxExchangeOpen(value)
    self._h5_wxExchangeOpen = value;
end
---@param value boolean
function ExchangeM:setH5_alipayExchangeOpen(value)
    self._h5_alipayExchangeOpen = value;
end
---@return number
function ExchangeM:getCurSelect()
    return self._curSelect;
end
---@param value number
function ExchangeM:setCurSelect(value)
    self._curSelect = value;
end
