---@class AdC
---@field public instance AdC
AdC = class("AdC")
function AdC:ctor()
	GameEventDispatch.instance:on("ShowAd",self,self.showAd)

end
function AdC:showAd()
	if ENV:isShowBannerAndAD() then
		if WxC:isInMiniGame() then
			WxC.instance:showVideoAD()

		end

	end

end