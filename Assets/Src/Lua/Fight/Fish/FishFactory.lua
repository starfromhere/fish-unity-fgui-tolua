FishFactory = class("FishFactory")

function FishFactory:ctor()
    self.fishMap = {}
end
---@param context FishContext
---@return Fish3D
function FishFactory.create3DFish(context)
    local fish = Fish3D.new()
    fish:init(context)
    return fish
end

---@param proto ProtoFishInfo
---@return Fish2D
function FishFactory.create2DFish(proto)
    local pathId = proto:getPath()[1]
    local fishId = proto:getFishId()
    local cfgFish = cfg_fish.instance(fishId)
    local iswind = proto:isWhirlwind()
-- if cfgFish.aniName_down ~= "xiaochouyu_down" and cfgFish.aniName_down ~= "qingtingyu_down" then return nil end
    -- if table.indexOf(MeshSharing.instance.meshfish, cfgFish.aniName_down.."_swim") < 0 then
    --     return nil
    -- end
    local fish = FishFactory.instance:getFish(cfgFish,iswind)
    
    local path = nil
    -- 鳄鱼的路径特殊处理
    if cfgFish and cfgFish.ctype == FightConst.fish_catch_type_eyu_awake then
        path = PathService.createEyuPath()
    else    
        path = PathService.createPath2D(pathId, proto:getMirror())
    end
    local startingInfo = { startTick = proto:getStartTick(),
                           freezeStartTick = proto:getFreezeStartTick(),
                           extraTick = proto:getExtraTick(),
                           delayDieTick = proto:getDelayDie() };

    fish:init(fishId, proto:getUniId(), path, proto:isCatch(), startingInfo, Vector3.New(proto:getOffX(),proto:getOffY(),0), iswind)
    return fish
end

function FishFactory.testCreateEyuFish()
    local path = PathService.createEyuPath()
    local fish = Fish2D.new()
    fish:init(4018, 6666, path, false, nil)
    return fish
end

function FishFactory:getFish(cfg,iswind)
    local fish = nil
    if iswind then
        return Fish2D.new()
    end
    if not self.fishMap[cfg.aniName_down] then
        fish = Fish2D.new()
    else
        -- luadump(self.fishMap[cfg.aniName_down])
        if #self.fishMap[cfg.aniName_down] > 0 then
            fish = table.remove(self.fishMap[cfg.aniName_down], 1)
        else
            fish = Fish2D.new()
        end
    end
    return fish
end

function FishFactory:returnFish(cfg, fish)
    if not fish then return end
    local list = self.fishMap[cfg.aniName_down]
    if list then
        table.insert(list, fish)
    else
        self.fishMap[cfg.aniName_down] = {}
        table.insert(self.fishMap[cfg.aniName_down], fish)
    end
end

function FishFactory:clearAll()
    for _,fishlist in pairs(self.fishMap) do
        for _,fish in pairs(fishlist) do
            fish:dispose()
        end
    end
    self.fishMap = {}
end



