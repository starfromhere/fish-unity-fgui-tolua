---@class UpgradeM
---@field public instance UpgradeM
UpgradeM = class("UpgradeM")
function UpgradeM:ctor()
	self._idLen=0
	self._urlArray = nil
	self._idArr = nil
	self._levelCount=nil
	self._countArr = nil

end
function UpgradeM:setInfo(url,count)
	self._idArr=url
	self._countArr=count
	self._idLen=self._idArr.length
end

--[[
	TODO: get and set method
]]