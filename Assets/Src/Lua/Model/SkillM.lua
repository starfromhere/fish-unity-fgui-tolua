---@class SkillM
---@field public instance SkillM
SkillM = class("SkillM")
function SkillM:ctor()

end
function SkillM:isConsumeEnough(skillId)
    if self:skillCount(skillId) <= 0 then
        local needDiamond = self:diamondCount(skillId)
        return RoleInfoM.instance:getDiamond() >= needDiamond
    else
        return true
    end
end
function SkillM:skillCount(skillId)
    local skill = cfg_skill.instance(skillId)
    --local unreachNum = 0
    --local seatId = SeatRouter:getSeatIdByShowSeatId(1)
    --local seatInfo = SeatRouter.instance:getSeatInfo(seatId)
    --if seatInfo then
    --    unreachNum = FightM.instance:getGoodsUnreachNum(seatInfo.agent, skill.need_prop)
    --end
    return RoleInfoM.instance:getGoodsItemNum(skill.need_prop)
end

function SkillM:skillDiamondCount(skillId)
    local skill = cfg_skill.instance(skillId)
    local goods = cfg_goods.instance(skill.need_prop)
    local arr = goods.replace_res
    return arr[2]
end

function SkillM:diamondCount(skillId)
    local skill = cfg_skill.instance(skillId)
    local goods = cfg_goods.instance(skill.need_prop)
    local arr = goods.replace_res
    return arr[2]
end

function SkillM:skillTime(id)
    if self.skillArr ~= nil then
        if self.skillArr[id] ~= -1 then
            local skill = cfg_skill.instance(self.skillArr[id])
            local time = skill.cd
            return time * 1000
        else
            return 0
        end
    else
        return 0
    end
end
        