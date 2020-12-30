---@class FishTypeM
---@field public instance FishTypeM
FishTypeM = class("FishTypeM")
function FishTypeM:ctor()
    self._infoList = {}
    self.sceneId = 0
    self.aniNames = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "201", "202" }
    self.gameView = ENV.fishDown

end
function FishTypeM:setInfo()
    self.sceneId = 1

end

-- 展现大鱼列表

function FishTypeM:showBigFish()
    local smallArr = self:bigFishIdArr()
    local smallArrData = {}
    for i = 1, #smallArr do
        local fishData = ConfigManager.getConfObject("cfg_fish", smallArr[i])
        if smallArr[i] < 4019 or smallArr[i] > 4023 then
            if fishData.fishType == 1 then
                table.insert(smallArrData, {
                    txt = fishData.coin_rate,
                    image = fishData.Imageurl_down,
                    name = fishData.fishname_down,
                    boss = false,
                    reward = false
                })
            elseif fishData.fishType == 0 then
                table.insert(smallArrData, {
                    txt = fishData.coin_rate,
                    image = fishData.Imageurl_down,
                    name = fishData.fishname_down,
                    boss = false,
                    reward = true
                })
            elseif fishData.fishType == 3 then

            elseif fishData.fishType == 4 then
                table.insert(smallArrData, {
                    txt = "",
                    image = fishData.Imageurl_down,
                    name = fishData.fishname_down,
                    boss = true,
                    reward = false
                })                    
            else
                table.insert(smallArrData, {
                    txt = fishData.coin_rate,
                    image = fishData.Imageurl_down,
                    name = fishData.fishname_down,
                    boss = true,
                    reward = false
                })
            end
        end
    end
    return smallArrData
end

--展示小鱼列表
function FishTypeM:showSmallFish()
    local smallArr = self:smallFishArr()
    local smallArrData = {}
    for i = 1, #smallArr do
        local fishData = ConfigManager.getConfObject("cfg_fish", smallArr[i])
        if fishData.fishType == 1 then
            table.insert(smallArrData, {
                txt = fishData.coin_rate,
                image = fishData.Imageurl_down,
                name = fishData.fishname_down,
                boss = false,
                reward = false
            })
        elseif fishData.fishType == 0 then
            table.insert(smallArrData, {
                txt = fishData.coin_rate,
                image = fishData.Imageurl_down,
                name = fishData.fishname_down,
                boss = false,
                reward = true
            })
        elseif fishData.fishType == 3 then
        else
            table.insert(smallArrData, {
                txt = fishData.coin_rate,
                image = fishData.Imageurl_down,
                name = fishData.fishname_down,
                boss = true,
                reward = false
            })
        end
    end
    return smallArrData
end

function FishTypeM:bigFishIdArr()
    local scene_id = Fishery.instance.sceneId
    return ConfigManager.getConfObject("cfg_scene", scene_id).bigfish_arr
end

function FishTypeM:smallFishArr()
    local scene_id = Fishery.instance.sceneId
    return ConfigManager.getConfObject("cfg_scene", scene_id).smallfish_arr
end
        