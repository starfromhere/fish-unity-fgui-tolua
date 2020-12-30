---@class CompenC
---@field public instance CompenC
CompenC = class("CompenC")
function CompenC:ctor()
	GameEventDispatch.instance:on("OpenMakeUp",self,self.openMakeUp)
	GameEventDispatch.instance:on(tostring(10022),self,self.startMake)

end
function CompenC:startMake(data)
	if data.from and data.from>0 then
		CompenM.instance.rewardFrom=data.from

	end
	CompenM.instance.compenArr=data.show
	UiManager.instance:loadView("Compenstate",null,"SMALL_TO_BIG")

end
function CompenC:openMakeUp(data)
	if CompenM.instance.currentTimes<=CompenM.instance.totalTimes then
		UiManager.instance:loadView("Compenstate",null,"SMALL_TO_BIG")

	end

end