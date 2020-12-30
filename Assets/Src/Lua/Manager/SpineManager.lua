---@class SpineManager
SpineManager = class("SpineManager")

function SpineManager:ctor()
    ---@type SkeletonAnimation
    self.skAnimation = nil
    ---@type Transform
    self.transform = nil
    ---@type GoWrapper
    self.wrapper = nil
    self.params = {}
end

---@param parent GGraph
---@return SpineManager
function SpineManager.create(prefabUrl, position, scale, parent, params )
   
    local scaleVec = Vector3(scale, scale, scale)

    local obj = SpineManager.New()
    obj.params = params or {}
    local spineItem = GameTools.ResourcesLoad(prefabUrl)

    spineItem.transform.position = position
    spineItem.transform.localScale = scaleVec

    obj.transform = spineItem.transform
    obj.skAnimation = spineItem.gameObject:GetComponent("SkeletonAnimation")

    ---@type GoWrapper
    obj.wrapper = GoWrapper.New(spineItem)
    parent:SetNativeObject(obj.wrapper)
    return obj
end

function SpineManager:setPosition(x, y)
    self.wrapper.x = x
    self.wrapper.y = y
end

function SpineManager:play(aniName, isLoop, endHandler)
    self.skAnimation.state:SetAnimation(0, aniName, isLoop)

    if endHandler then
        ---@param state AnimationState
        local checkPlayState
        checkPlayState = function(state, index)
            self.skAnimation.state.Complete = self.skAnimation.state.Complete - checkPlayState
            endHandler(self)
        end
        self.skAnimation.state.Complete = self.skAnimation.state.Complete + checkPlayState

        --self.endHandlerLooper = GameTimer.frameLoop(1, self, checkPlayState, { self.skAnimation.state })
    end

end

function SpineManager:isPlaying()

end

function SpineManager:setScale(x, y)
    self.transform.localScale = Vector3(x, y, 1)
end

function SpineManager:stop()
    --self.skAnimation.state:TimeScale(0)
end

function SpineManager:destroy()
    self.wrapper:RemoveFromParent()
    self.wrapper:Dispose()
    self.skAnimation:Destroy()
end






--function SpineManager:CreateFish(prefabName, position, eulerAngles, scale)
--    local prefabUrl = "Fish/Prefab/" .. prefabName
--
--    -- TODO Resources.Load
--    local fishSpine = GameTools.ResourcesLoad(prefabUrl)
--    fishSpine.transform.position = position
--    fishSpine.transform.eulerAngles = eulerAngles
--    fishSpine.transform.localScale = fishSpine.transform.localScale * scale
--
--    return fishSpine
--end
