---@class GunM
---@field public instance GunM
GunM = class("GunM")
function GunM:ctor()

end

function GunM:getNextPower(id)
    local a=id+1
    local battery=cfg_battery.instance(tonumber(a))
    if battery == nil then
        return -1
    end
    return battery.comsume
end

function GunM:needDiamod(id)
    local b=id+1
    local battery=cfg_battery.instance(tonumber(b))
    return battery.need_diamond

end

function GunM:giveCount(id)
    local c=id+1
    local battery=cfg_battery.instance(tonumber(c))
    local arr=battery.award
    return arr[2]
end
        