---@class FishContext2D
FishContext2D = class("FishContext2D")
function FishContext2D:ctor()
    self.pathId = nil
    self.uniId = nil
    self.offVec = null
    self.aniName2D = null
    self.scale2D = nil
    self.boom = 0
    self.hitTime = nil
    self.fishId = nil
    self.lock_pri = nil
    self.ctype = nil
    self.catchShow = 0
    self.aniName = null
    self.shock = null
    self.actionName = null
    self.playCatchSound = nil
    self.coin_fly = null
    self.layer = nil
    self.hitSound = null
    self.changeNum = nil
    self.specFishFlag = nil
    self.deadAni = null
    self.startTick = 0
    self.freezeStartTick = 0
    self.extraTick = 0
    self.delayDieTick = 0
    self.specFlag = null
    self.specFishsContext = null
    self.mirror = nil
    --self.isPrintPathId = StartParam.instance:getParam("printDebug") == 1
    self.fishSpecType = 0

end
function FishContext2D:init(fishId, aniName2D, scale, boom, hitTime, lockPri, ctype, catchShow, aniName, shock, actionName, playCatchSound, coin_fly, layer, hitSound, change_num, spec_flag, deadAni, pathId, uniId, offVec, mirror)
    self.fishId = fishId
    self.pathId = pathId
    self.offVec = offVec
    self.uniId = uniId
    self.aniName2D = aniName2D
    self.scale2D = scale
    self.boom = boom
    self.hitTime = hitTime
    self.lock_pri = lockPri
    self.ctype = ctype
    self.catchShow = catchShow
    self.aniName = aniName
    self.shock = shock
    self.actionName = actionName
    self.playCatchSound = playCatchSound
    self.coin_fly = coin_fly
    self.layer = layer
    self.hitSound = hitSound
    self.changeNum = change_num
    self.specFishFlag = spec_flag
    self.deadAni = deadAni
    self.mirror = mirror

end
function FishContext2D:isSpecFish()
    return FishHelper:isSpecFish(self.ctype)

end
function FishContext2D:isCornucopia()
    return FishHelper:isCornucopia(self.ctype)

end
function FishContext2D:isDaFuDaGui()
    return FishHelper:isDaFuDaGui(self.ctype)

end
function FishContext2D:getSpecTypeSpineName()
    return FishHelper:getSpecTypeSpineName(self.fishSpecType)

end
function FishContext2D:getSpecTypeSpineActionName()
    return FishHelper:getSpecTypeSpineActionName(self.fishSpecType)

end


