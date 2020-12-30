---@class ProtoFishInfo
ProtoFishInfo = class("ProtoFishInfo")
function ProtoFishInfo:ctor()
	self.p=nil

end
function ProtoFishInfo:getUniId()
	return self.p[1]

end
function ProtoFishInfo:getFishId()
	return self.p[2]

end
function ProtoFishInfo:getFreezeStartTick()
	return self.p[3]

end
function ProtoFishInfo:getDelayTickNum()
	return self.p[4]

end
function ProtoFishInfo:getPath()
	return self.p[5]

end
function ProtoFishInfo:getStartTick()
	return self.p[6]

end
function ProtoFishInfo:isCatch()
	return self.p[7]==1

end
function ProtoFishInfo:getOffX()
	return self.p[8]

end
function ProtoFishInfo:getOffY()
	return self.p[9]

end
function ProtoFishInfo:getMirror()
	return self.p[10]

end
function ProtoFishInfo:getExtraTick()
	return self.p[11]

end
function ProtoFishInfo:getcalldelayTickNum()
	return self.p[12]

end
function ProtoFishInfo:getDelayDie()
	return self.p[13]

end
function ProtoFishInfo:getOffZ()
	return self.p[14]

end
function ProtoFishInfo:getFollowFishes()
	return self.p[15]

end
function ProtoFishInfo:getExtraInfo()
	return self.p[16]
end
function ProtoFishInfo:getAgent()
	local info = self.p[16]
	if info then
		return info['a']
	end
end

function ProtoFishInfo:getCatchType()
	local info = self.p[16]
	if info then
		return info['t']
	end
end

function ProtoFishInfo:isWhirlwind()
	return self.p[17]==1
end

