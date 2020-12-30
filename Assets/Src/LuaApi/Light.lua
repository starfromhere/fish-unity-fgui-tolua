---@class Light : Behaviour
---@field public type number
---@field public shape number
---@field public spotAngle Single
---@field public innerSpotAngle Single
---@field public color Color
---@field public colorTemperature Single
---@field public useColorTemperature bool
---@field public intensity Single
---@field public bounceIntensity Single
---@field public useBoundingSphereOverride bool
---@field public boundingSphereOverride Vector4
---@field public shadowCustomResolution Int32
---@field public shadowBias Single
---@field public shadowNormalBias Single
---@field public shadowNearPlane Single
---@field public useShadowMatrixOverride bool
---@field public shadowMatrixOverride Matrix4x4
---@field public range Single
---@field public flare Flare
---@field public bakingOutput LightBakingOutput
---@field public cullingMask Int32
---@field public renderingLayerMask Int32
---@field public lightShadowCasterMode number
---@field public shadowRadius Single
---@field public shadowAngle Single
---@field public shadows number
---@field public shadowStrength Single
---@field public shadowResolution number
---@field public shadowSoftness Single
---@field public shadowSoftnessFade Single
---@field public layerShadowCullDistances Single[]
---@field public cookieSize Single
---@field public cookie Texture
---@field public renderMode number
---@field public bakedIndex Int32
---@field public areaSize Vector2
---@field public lightmapBakeType number
---@field public commandBufferCount Int32
---@field public pixelLightCount Int32
---@field public shadowConstantBias Single
---@field public shadowObjectSizeBias Single
---@field public attenuate bool
---@field public lightmappingMode number
---@field public isBaked bool
---@field public alreadyLightmapped bool
local Light={ }
---@public
---@return void
function Light:Reset() end
---@public
---@return void
function Light:SetLightDirty() end
---@public
---@param evt number
---@param buffer CommandBuffer
---@return void
function Light:AddCommandBuffer(evt, buffer) end
---@public
---@param evt number
---@param buffer CommandBuffer
---@param shadowPassMask number
---@return void
function Light:AddCommandBuffer(evt, buffer, shadowPassMask) end
---@public
---@param evt number
---@param buffer CommandBuffer
---@param queueType number
---@return void
function Light:AddCommandBufferAsync(evt, buffer, queueType) end
---@public
---@param evt number
---@param buffer CommandBuffer
---@param shadowPassMask number
---@param queueType number
---@return void
function Light:AddCommandBufferAsync(evt, buffer, shadowPassMask, queueType) end
---@public
---@param evt number
---@param buffer CommandBuffer
---@return void
function Light:RemoveCommandBuffer(evt, buffer) end
---@public
---@param evt number
---@return void
function Light:RemoveCommandBuffers(evt) end
---@public
---@return void
function Light:RemoveAllCommandBuffers() end
---@public
---@param evt number
---@return CommandBuffer[]
function Light:GetCommandBuffers(evt) end
---@public
---@param type number
---@param layer Int32
---@return Light[]
function Light.GetLights(type, layer) end
UnityEngine.Light = Light