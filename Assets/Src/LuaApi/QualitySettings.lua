---@class QualitySettings : Object
---@field public currentLevel number
---@field public pixelLightCount Int32
---@field public shadows number
---@field public shadowProjection number
---@field public shadowCascades Int32
---@field public shadowDistance Single
---@field public shadowResolution number
---@field public shadowmaskMode number
---@field public shadowNearPlaneOffset Single
---@field public shadowCascade2Split Single
---@field public shadowCascade4Split Vector3
---@field public lodBias Single
---@field public anisotropicFiltering number
---@field public masterTextureLimit Int32
---@field public maximumLODLevel Int32
---@field public particleRaycastBudget Int32
---@field public softParticles bool
---@field public softVegetation bool
---@field public vSyncCount Int32
---@field public antiAliasing Int32
---@field public asyncUploadTimeSlice Int32
---@field public asyncUploadBufferSize Int32
---@field public asyncUploadPersistentBuffer bool
---@field public realtimeReflectionProbes bool
---@field public billboardsFaceCameraPosition bool
---@field public resolutionScalingFixedDPIFactor Single
---@field public renderPipeline RenderPipelineAsset
---@field public blendWeights number
---@field public skinWeights number
---@field public streamingMipmapsActive bool
---@field public streamingMipmapsMemoryBudget Single
---@field public streamingMipmapsRenderersPerFrame Int32
---@field public streamingMipmapsMaxLevelReduction Int32
---@field public streamingMipmapsAddAllCameras bool
---@field public streamingMipmapsMaxFileIORequests Int32
---@field public maxQueuedFrames Int32
---@field public names String[]
---@field public desiredColorSpace number
---@field public activeColorSpace number
local QualitySettings={ }
---@public
---@param applyExpensiveChanges bool
---@return void
function QualitySettings.IncreaseLevel(applyExpensiveChanges) end
---@public
---@param applyExpensiveChanges bool
---@return void
function QualitySettings.DecreaseLevel(applyExpensiveChanges) end
---@public
---@param index Int32
---@return void
function QualitySettings.SetQualityLevel(index) end
---@public
---@return void
function QualitySettings.IncreaseLevel() end
---@public
---@return void
function QualitySettings.DecreaseLevel() end
---@public
---@param index Int32
---@return RenderPipelineAsset
function QualitySettings.GetRenderPipelineAssetAt(index) end
---@public
---@return Int32
function QualitySettings.GetQualityLevel() end
---@public
---@param index Int32
---@param applyExpensiveChanges bool
---@return void
function QualitySettings.SetQualityLevel(index, applyExpensiveChanges) end
UnityEngine.QualitySettings = QualitySettings