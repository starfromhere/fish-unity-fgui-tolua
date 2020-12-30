---@class LineRenderer : Renderer
---@field public numPositions Int32
---@field public startWidth Single
---@field public endWidth Single
---@field public widthMultiplier Single
---@field public numCornerVertices Int32
---@field public numCapVertices Int32
---@field public useWorldSpace bool
---@field public loop bool
---@field public startColor Color
---@field public endColor Color
---@field public positionCount Int32
---@field public shadowBias Single
---@field public generateLightingData bool
---@field public textureMode number
---@field public alignment number
---@field public widthCurve AnimationCurve
---@field public colorGradient Gradient
local LineRenderer={ }
---@public
---@param start Single
---@param end Single
---@return void
function LineRenderer:SetWidth(start, end) end
---@public
---@param start Color
---@param end Color
---@return void
function LineRenderer:SetColors(start, end) end
---@public
---@param count Int32
---@return void
function LineRenderer:SetVertexCount(count) end
---@public
---@param index Int32
---@param position Vector3
---@return void
function LineRenderer:SetPosition(index, position) end
---@public
---@param index Int32
---@return Vector3
function LineRenderer:GetPosition(index) end
---@public
---@param tolerance Single
---@return void
function LineRenderer:Simplify(tolerance) end
---@public
---@param mesh Mesh
---@param useTransform bool
---@return void
function LineRenderer:BakeMesh(mesh, useTransform) end
---@public
---@param mesh Mesh
---@param camera Camera
---@param useTransform bool
---@return void
function LineRenderer:BakeMesh(mesh, camera, useTransform) end
---@public
---@param positions Vector3[]
---@return Int32
function LineRenderer:GetPositions(positions) end
---@public
---@param positions Vector3[]
---@return void
function LineRenderer:SetPositions(positions) end
UnityEngine.LineRenderer = LineRenderer