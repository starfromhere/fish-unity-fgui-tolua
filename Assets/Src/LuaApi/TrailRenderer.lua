---@class TrailRenderer : Renderer
---@field public numPositions Int32
---@field public time Single
---@field public startWidth Single
---@field public endWidth Single
---@field public widthMultiplier Single
---@field public autodestruct bool
---@field public emitting bool
---@field public numCornerVertices Int32
---@field public numCapVertices Int32
---@field public minVertexDistance Single
---@field public startColor Color
---@field public endColor Color
---@field public positionCount Int32
---@field public shadowBias Single
---@field public generateLightingData bool
---@field public textureMode number
---@field public alignment number
---@field public widthCurve AnimationCurve
---@field public colorGradient Gradient
local TrailRenderer={ }
---@public
---@param index Int32
---@param position Vector3
---@return void
function TrailRenderer:SetPosition(index, position) end
---@public
---@param index Int32
---@return Vector3
function TrailRenderer:GetPosition(index) end
---@public
---@return void
function TrailRenderer:Clear() end
---@public
---@param mesh Mesh
---@param useTransform bool
---@return void
function TrailRenderer:BakeMesh(mesh, useTransform) end
---@public
---@param mesh Mesh
---@param camera Camera
---@param useTransform bool
---@return void
function TrailRenderer:BakeMesh(mesh, camera, useTransform) end
---@public
---@param positions Vector3[]
---@return Int32
function TrailRenderer:GetPositions(positions) end
---@public
---@param positions Vector3[]
---@return void
function TrailRenderer:SetPositions(positions) end
---@public
---@param position Vector3
---@return void
function TrailRenderer:AddPosition(position) end
---@public
---@param positions Vector3[]
---@return void
function TrailRenderer:AddPositions(positions) end
UnityEngine.TrailRenderer = TrailRenderer