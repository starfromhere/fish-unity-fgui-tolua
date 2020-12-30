---@class UpgradeC
---@field public instance UpgradeC
UpgradeC = class("UpgradeC")
function UpgradeC:ctor()
	GameEventDispatch.instance:on("UpgradeC",self,self.gradeC)

end
function UpgradeC:gradeC(dataOne,isShow)
	UpgradeM.instance:setInfo(dataOne,isShow)
	--UiManager.instance:loadView("Levelup")

end 