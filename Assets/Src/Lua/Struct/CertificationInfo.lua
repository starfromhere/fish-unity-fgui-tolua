---@class CertificationInfo
---@field public quitInfo QuitTipInfo
---@field public buyInfo cfg_commodity
---@field public openFrom string
---@field public realForciblySwitchState boolean
---@field public realState number
---@field public bindState number
---@field public ageState number

CertificationInfo = class("CertificationInfo")
function CertificationInfo:ctor()
    self.quitInfo = nil
    self.buyInfo = nil
    self.openFrom = nil
    self.realForciblySwitchState = LoginInfoM.instance:getOpenCertification()
    self.realState = LoginM.instance:getIsCompleteCertification()
    self.bindState = RoleInfoM.instance.is_bind_tel
    self.ageState = LoginInfoM.instance:getAgeType()
end