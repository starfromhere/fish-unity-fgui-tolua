---@class CertificationM
---@field public instance CertificationM
CertificationM = class("CertificationM")

function CertificationM:ctor()
    ---@type CertificationInfo
    self.info = nil
end

---@return boolean
function CertificationM:isOpenCertification()
    if (SwitchOffTool.isNeedCertification()) then
        if (RoleInfoM.instance.is_bind_tel == 0 or LoginM.instance:getIsCompleteCertification() == 0) then
            return true
        end
    end
    return false
end

function CertificationM:OpenCertification()
    if (RoleInfoM.instance.is_bind_tel == 0 or self._info.openFrom == GameConst.from_bank) then
        NetSender.GetBankInfo()
    else
        UIManager:LoadView("CertificationPage")
    end
end

---@return CertificationInfo
function CertificationM:getInfo()
    return self._info;
end

---@param value CertificationInfo
function CertificationM:setInfo(value)
    self._info = value;
end