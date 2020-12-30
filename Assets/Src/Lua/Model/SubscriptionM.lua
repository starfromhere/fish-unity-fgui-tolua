---@class SubscriptionM
---@field public instance SubscriptionM
SubscriptionM = class("SubscriptionM")
function SubscriptionM:ctor()
	self._giftcode=""

end
function SubscriptionM:getGiftcode()
	return self._giftcode

end
function SubscriptionM:setGiftcode(_str)
	self._giftcode=_str
end
        