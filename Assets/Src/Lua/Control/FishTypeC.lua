---@class FishTypeC
---@field public instance FishTypeC
FishTypeC = class("FishTypeC")
function FishTypeC:ctor()
	GameEventDispatch.instance:on("FishTypeC",self,self.FishTip)

end
function FishTypeC:FishTip(data)
	FishTypeM.instance:setInfo()
	UiManager.instance:loadView("FishType",null,"SMALL_TO_BIG")

end