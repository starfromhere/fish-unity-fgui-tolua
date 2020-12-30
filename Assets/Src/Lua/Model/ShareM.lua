---@class ShareM
---@field public instance ShareM
ShareM = class("ShareM")
function ShareM:ctor()
	self._idArr = nil
	self._idArr={}
	local items=ConfigManager.getConfBySheet("cfg_shareLottery")
	for i,i in ipairs(items) do
		self._idArr:push(parseInt(i))
	end
end

function ShareM:getGoodsId(prizeId)
	local cfg=cfg_shareLottery.instance(prizeId)
	if ActivityM.instance.isShowShareRebate then
		return cfg.activity_rewardId
	else
		return cfg.rewardId
	end
end

function ShareM:count(prizeId)
	local cfg=cfg_shareLottery.instance(prizeId)
	if ActivityM.instance.isShowShareRebate then
		return cfg.activity_rewardCount
	else
		return cfg.rewardCount
	end
end
        