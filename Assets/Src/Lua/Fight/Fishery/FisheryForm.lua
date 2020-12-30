function Fishery:_initFishForm()
    self.fishFormRunTime = 0
    self.fishFormTotalTime = 0
    self.fishFormClearDir = 1
    self.fishFormLooper = nil

    local prefabUrl = 'Particle/FishTide'
    local spineItem = GameTools.ResourcesLoad(prefabUrl)

    ---@type GoWrapper
    self.fishFormWrapper = GoWrapper.New(spineItem)
    local box = GComponent.New()
    ---@type GGraph
    local graph = GGraph.New()
    graph:SetNativeObject(self.fishFormWrapper)
    graph.rotation = 90
    graph.position = Vector3.New(0, GameScreen.instance.adaptHeight / 2, 0)
    box:AddChild(graph)
    --graph.rotation = 90
    FishLayer.instance.fishLayer:AddChild(box)
end

function Fishery:playFishFormSound()
    --    TODO 添加鱼潮声音
    Log.error("添加鱼潮声音")
end

---@param dir number
function Fishery:playForm(dir, time)
    if self.fishFormLooper then
        return
    end

    if not self.fishFormWrapper then
        self:_initFishForm()
    end

    self:playFishFormSound();

    self.fishFormRunTime = 0
    self.fishFormWrapper.scaleX = 1
    if dir == 2 then
        self.fishFormWrapper.scaleX = -1
    end
    self.fishFormClearDir = dir
    self.fishFormTotalTime = time
    self.fishFormWrapper.visible = true

    self.fishFormLooper = GameTimer.frameLoop(1, self, self.onLoop)
end

function Fishery:cleanFishByWidth(startX, endX)
    ---@param fish Fish2D
    for _, fish in pairs(self.fishes) do
        if fish.fishWrapper.x > startX and fish.fishWrapper.x <= endX then
            fish.fsm:changeState(StateFishStop)
        end
    end
end

function Fishery:onLoop()
    self.fishFormRunTime = self.fishFormRunTime + Time.deltaTime
    if self.fishFormClearDir == 1 then
        local distance = GameScreen.instance.adaptWidth * (self.fishFormRunTime / self.fishFormTotalTime)
        self.fishFormWrapper.x = distance

        self:cleanFishByWidth(0, self.fishFormWrapper.x)
        if distance > GameScreen.instance.adaptWidth then
            self.fishFormLooper:clear()
            self.fishFormLooper = nil
            self.fishFormWrapper.visible = false
        end
    elseif self.fishFormClearDir == 2 then
        local distance = GameScreen.instance.adaptWidth - GameScreen.instance.adaptWidth * (self.fishFormRunTime / self.fishFormTotalTime)
        self.fishFormWrapper.x = distance
        self:cleanFishByWidth(self.fishFormWrapper.x, GameScreen.instance.adaptWidth)
        if distance < 0 then
            self.fishFormLooper:clear()
            self.fishFormLooper = nil
            self.fishFormWrapper.visible = false
        end
    end
end