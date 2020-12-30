---@class SwitchOffTool
---@field public instance SwitchOffTool
SwitchOffTool = class("SwitchOffTool")

---@return boolean 是否需要实名认证
function SwitchOffTool.isNeedCertification()
    return true
end