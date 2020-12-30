---@class SkeletonRenderer : MonoBehaviour
---@field public skeletonDataAsset SkeletonDataAsset
---@field public initialSkinName string
---@field public initialFlipX bool
---@field public initialFlipY bool
---@field public separatorSlotNames String[]
---@field public separatorSlots List`1
---@field public zSpacing Single
---@field public useClipping bool
---@field public immutableTriangles bool
---@field public pmaVertexColors bool
---@field public clearStateOnDisable bool
---@field public tintBlack bool
---@field public singleSubmesh bool
---@field public addNormals bool
---@field public calculateTangents bool
---@field public logErrors bool
---@field public disableRenderingOnOverride bool
---@field public valid bool
---@field public skeleton Skeleton
---@field public SkeletonDataAsset SkeletonDataAsset
---@field public CustomMaterialOverride Dictionary`2
---@field public CustomSlotMaterials Dictionary`2
---@field public Skeleton Skeleton
local SkeletonRenderer={ }
---@public
---@param value SkeletonRendererDelegate
---@return void
function SkeletonRenderer:add_OnRebuild(value) end
---@public
---@param value SkeletonRendererDelegate
---@return void
function SkeletonRenderer:remove_OnRebuild(value) end
---@public
---@param value MeshGeneratorDelegate
---@return void
function SkeletonRenderer:add_OnPostProcessVertices(value) end
---@public
---@param value MeshGeneratorDelegate
---@return void
function SkeletonRenderer:remove_OnPostProcessVertices(value) end
---@public
---@param value InstructionDelegate
---@return void
function SkeletonRenderer:add_GenerateMeshOverride(value) end
---@public
---@param value InstructionDelegate
---@return void
function SkeletonRenderer:remove_GenerateMeshOverride(value) end
---@public
---@param settings Settings
---@return void
function SkeletonRenderer:SetMeshSettings(settings) end
---@public
---@return void
function SkeletonRenderer:Awake() end
---@public
---@return void
function SkeletonRenderer:ClearState() end
---@public
---@param minimumVertexCount Int32
---@return void
function SkeletonRenderer:EnsureMeshGeneratorCapacity(minimumVertexCount) end
---@public
---@param overwrite bool
---@return void
function SkeletonRenderer:Initialize(overwrite) end
---@public
---@return void
function SkeletonRenderer:LateUpdate() end
Spine.Unity.SkeletonRenderer = SkeletonRenderer