---@class LoginInfoM
---@field public instance LoginInfoM
LoginInfoM = class("LoginInfoM")
function LoginInfoM:ctor()
    self.name = nil
    self.uid = nil
    self._shopRate = nil
    self.mainPageShow = false

    self._openBankBatteryLevel = 0
    self._openCertification = 0
    self._isShowRankAniBox = 0
    self._ageType = 1

    self._shopRate = 1
    self.token = nil;

    self._nameFilter = {}
end

---@param value table
function LoginInfoM:setNameFilter(value)
    self._nameFilter = value
end

---@param name string
---@return string
function LoginInfoM:filterName(name)
    local tmp = name
    for i = 1, #self._nameFilter do
        local nameFilterElement = self._nameFilter[i]
        tmp = string.gsub(tmp, nameFilterElement, "*")
    end
    return tmp
end

function LoginInfoM:setShopRate(rate)
    self._shopRate = rate
end

function LoginInfoM:getShopRate()
    return self._shopRate
end

function LoginInfoM:setUserToken(value)
    self.token = value;
end

function LoginInfoM:getUserToken()
    return self.token;
end

function LoginInfoM:getOpenBankBatteryLevel()
    return self._openBankBatteryLevel;
end

function LoginInfoM:setOpenBankBatteryLevel(value)
    self._openBankBatteryLevel = value
end

---@param value number
function LoginInfoM:setOpenCertification(value)
    self._openCertification = value
end

---@return boolean 强制实名认证开关
function LoginInfoM:getOpenCertification()
    if self._openCertification == 1 then
        return true
    end
    return false
end
---@return number
function LoginInfoM:getAgeType()
    return self._ageType;
end
---@param value number
function LoginInfoM:setAgeType(value)
    self._ageType = value
end

---@return number
function LoginInfoM:getIsShowRankAniBox()
    return self._isShowRankAniBox;
end

---@param value number
function LoginInfoM:setIsShowRankAniBox(value)
    self._isShowRankAniBox = value
end
