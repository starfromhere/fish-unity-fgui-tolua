
---深拷贝
local function _deepCopy(object)
    local SearchTable = {}

    local function Func(object)
        if type(object) ~= "table" then
            return object
        end
        local NewTable = {}
        SearchTable[object] = NewTable
        for k, v in pairs(object) do
            NewTable[Func(k)] = Func(v)
        end

        return setmetatable(NewTable, getmetatable(object))
    end

    return Func(object)
end

local proto_base = {
    New = function(self)
        return _deepCopy(self)
    end
}
        
---@class C_BulletHitInfo
---@field New C_BulletHitInfo
C_BulletHitInfo = {

	---@type number
	b=0,
	---@type number[]
	f={},

}
setmetatable(C_BulletHitInfo,{__index=proto_base})
---@class C_BulletRemoveFishes
---@field New C_BulletRemoveFishes
C_BulletRemoveFishes = {

	---@type number[]
	uids={},
	---@type number
	type=0,

}
setmetatable(C_BulletRemoveFishes,{__index=proto_base})
---@class CS_BulletHit
---@field New CS_BulletHit
CS_BulletHit = {
	---@type number
	msg_id=600001,
	---@type C_BulletHitInfo[]
	hit={},
	---@type C_BulletRemoveFishes
	rf=None,

}
setmetatable(CS_BulletHit,{__index=proto_base})
