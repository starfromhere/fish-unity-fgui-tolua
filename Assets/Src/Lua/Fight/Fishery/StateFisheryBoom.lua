---@class StateFisheryBoom
---@field public instance StateFisheryBoom
StateFisheryBoom = class("StateFisheryBoom")


---@param fishery Fishery
function StateFisheryBoom:enter(fishery)
    for _, fish in pairs(fishery.fishes) do
        fish:showBoomFlag()
    end
    UIFishPage.instance.boomMask.visible = true

end

---@param fishery Fishery
function StateFisheryBoom:execute(fishery)
end

---@param fishery Fishery
function StateFisheryBoom:exit(fishery)
    for _, fish in pairs(fishery.fishes) do
        fish:hideBoomFlag()
    end
    UIFishPage.instance.boomMask.visible = false

end
