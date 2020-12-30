---@class UIFishTypePage :UIDialogBase
local UIFishTypePage = class("UIFishTypePage",UIDialogBase)

function UIFishTypePage:init()
    self.packageName = "FishType"
    self.resName = "FishTypePage"
    self.view = nil  -- 界面对象引用
    self.param = ""
    self.context = nil
end

function UIFishTypePage:StartGames(param)
    self:initComponent()
    self:initView()
end

function UIFishTypePage:initComponent()
    self.contentView = self.view:GetChild("contentView")
    self.contentView:GetChild("ReturnBtn"):onClick(self.onQuitClick,self)
end
function UIFishTypePage:initView()

    local arr = FishTypeM:showBigFish()
    local fishTypeList = self.contentView:GetChild("fishTypeList")
    fishTypeList:RemoveChildrenToPool()
    for i,v in pairs(arr) do

        local obj = fishTypeList:AddItemFromPool()
        local name = obj:GetChild("name")
        local bei = obj:GetChild("bei")
        local icon = obj:GetChild("icon")

        name.text = v.name;
        icon.icon =  v.image
        if v.txt and v.txt ~= "" then
            bei.text = v.txt;
        else
            bei.text = ""    
        end
    end

end


function UIFishTypePage:onQuitClick()
    UIManager:ClosePanel("FishTypePage")
end


return UIFishTypePage