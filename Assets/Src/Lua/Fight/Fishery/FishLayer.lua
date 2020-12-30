---@class FishLayer
---@field public instance FishLayer
FishLayer = class("FishLayer")
function FishLayer:ctor()

    --以下按照层级排列
    self.specialLayer = {}
    self.bossZhangYu = nil
    ---@type GComponent @鱼层
    self.fishLayer = nil

    ---@type GComponent @子弹层
    self.bulletLayer = nil

    ---@type GImage @冰冻图片
    self.freezeSprite = nil

    ---@type GComponent @效果层
    self.effectLayer = nil

    ---@type GComponent @高于Ui层的效果层
    self.upEffectLayer = nil

    ---@type GComponent @觉醒层
    self.awakeLayer = nil

    ---@type GComponent @炸弹层
    self.fightBoomLayer = nil


    --self.effectLayerUnderScene = nil
    --self.bgSceneRoot = nil

end
function FishLayer:initLayer(bulletLayer, fishLayer, effectLayer, boomLayer, freezeSprite, specialLayer, awakeLayer, upEffectLayer,topLayer)
    ---@type table
    self.specialLayer = specialLayer
    ---@type GComponent
    self.bulletLayer = bulletLayer
    ---@type GComponent
    self.fishLayer = fishLayer
    if not self.fish3dbox then
        self.fish3dbox =  GameTools.ResourcesLoad("Fish/3dlayer")
        self.fishwarper = GoWrapper.New(self.fish3dbox)
        self.fishLayer:GetChild("meshLayer"):SetNativeObject(self.fishwarper)
    end
    MeshSharing.instance:init();
    ---@type GComponent
    self.effectLayer = effectLayer
    ---@type GComponent
    self.boomLayer = boomLayer
    if not self.boom3dbox then
        self.boom3dbox = GameTools.ResourcesLoad("Fish/3dlayer")
        self.boomwarper = GoWrapper.New(self.boom3dbox)
        self.boomLayer:GetChild("meshLayer"):SetNativeObject(self.boomwarper)
    end
    self.freezeSprite = freezeSprite
    ---@type GComponent
    self.awakeLayer = awakeLayer
    self.upEffectLayer = upEffectLayer
    self.topLayer = topLayer
    self:clearBossZhangYuRotation()
    self:initPointLayer()
end

function FishLayer:initBossZhangYu(bossZhangYu)
    self.bossZhangYu = bossZhangYu
end

function FishLayer:playBossZhangYuAniByAllTick()

    local baserotation = 0
    local rotationtime = 3 / GameConst.fixed_update_time
    local waitTime = 10 / GameConst.fixed_update_time
    -- FisheryTick.instance._curTick
    local left = FisheryTick.instance._curTick % (rotationtime + waitTime) * 4
    left = math.floor(left / (rotationtime + waitTime))
    baserotation = baserotation + left * 90
    if left % (rotationtime + waitTime) > rotationtime then
        baserotation = baserotation + 90
    else
        baserotation = baserotation + left % (rotationtime + waitTime) / rotationtime * 90
    end
    self.bossZhangYu.rotation = baserotation
    -- self.rotationtimer = GameTimer.loop(20, self, self.updateZhangYuRotarion)
end

function FishLayer:playBossZhangYuAni(tick)
    if FightM.instance.sceneId ~= 4 then
        return
    end
    if self.rotationtimer then
        self.rotationtimer:clear()
        self.rotationtimer = nil
    end
    local baserotation = 0
    local rotationtime = 3 / GameConst.fixed_update_time
    local waitTime = 10 / GameConst.fixed_update_time
    self.tick = tick
    Log.error("begin tick", tick)
    local left = self.tick % (rotationtime + waitTime) * 4
    left = math.floor(left / (rotationtime + waitTime))
    baserotation = baserotation + left * 90
    if left % (rotationtime + waitTime) > rotationtime then
        baserotation = baserotation + 90
    else
        baserotation = baserotation + left % (rotationtime + waitTime) / rotationtime * 90
    end
    self.bossZhangYu.rotation = baserotation
    self.rotationtimer = GameTimer.loop(20, self, self.updateZhangYuRotarion)
end

function FishLayer:updateZhangYuRotarion()
    self.tick = self.tick + 1
    if self.tick % (13 / GameConst.fixed_update_time) <= (3 / GameConst.fixed_update_time) then
        self.bossZhangYu.rotation = self.bossZhangYu.rotation + 1 / (3 / GameConst.fixed_update_time) * 90
    end
end

function FishLayer:clearBossZhangYuRotation()
    if self.rotationtimer then
        self.rotationtimer:clear()
        self.rotationtimer = nil
    end
    if self.bossZhangYu then
        self.bossZhangYu.rotation = 0
    end
end

function FishLayer:initPointLayer()
    if Fishery.instance.sceneId ~= 3 then
        self.specialLayer["LightLayer"].visible = false
        return
    end
    self.specialLayer["LightLayer"].visible = true
    local lightlayer = self.specialLayer["LightLayer"]
    lightlayer:ChangeBlendMode(7)
    local pointLight = lightlayer:GetChild("pointLight")
    pointLight:ChangeBlendMode(6)
end

function FishLayer:updatePoint(x, y)
    if Fishery.instance.sceneId ~= 3 then
        return
    end
    local pointLight = self.specialLayer["LightLayer"]:GetChild("pointLight")
    pointLight:SetXY(x, y)
end

function FishLayer:exitFight()
    if self.rotationtimer then
        self.rotationtimer:clear()
        self.rotationtimer = nil
    end
    -- GameTimer.clearOnceAll()
    -- self.effectLayer:RemoveChildren(0,-1,true)
    for i = 1, self.effectLayer.numChildren do
        local child = self.effectLayer:GetChildAt(i - 1)
        if child[".name"] == "FairyGUI.GGraph" then
            luadump(child)
        else
            child.visible = false
        end
    end
    for i = 1, self.upEffectLayer.numChildren do
        local child = self.upEffectLayer:GetChildAt(i - 1)
        if child[".name"] == "FairyGUI.GGraph" then
            luadump(child)
        else
            child.visible = false
        end
    end
    self.awakeLayer:RemoveChildren()
end

--function FishLayer:showBgScene(isShow, bgResUrl)
--    self._bgSceneRoot.visible = isShow
--    if isShow and bgResUrl ~= null then
--        self._bgSceneRoot:loadImage(bgResUrl, Handler:create(self, self.bgSceneScreenResize))
--    end
--end
--
--function FishLayer:bgSceneScreenResize()
--    local scaleX = Laya.stage.width / fight.fishery.FishLayer.instance.bgScene.width
--    local scaleY = (Laya.stage.height + 80) / fight.fishery.FishLayer.instance.bgScene.height
--    if scaleX ~= self._bgSceneRoot.scaleX or scaleY ~= self._bgSceneRoot.scaleY then
--        self._bgSceneRoot:scale(scaleX, scaleY, true)
--    end
--end
