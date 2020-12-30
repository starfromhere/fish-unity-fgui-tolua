---@class Mesh : Object
---@field public uv1 Vector2[]
---@field public indexFormat number
---@field public vertexBufferCount Int32
---@field public blendShapeCount Int32
---@field public bindposes Matrix4x4[]
---@field public isReadable bool
---@field public vertexCount Int32
---@field public subMeshCount Int32
---@field public bounds Bounds
---@field public vertices Vector3[]
---@field public normals Vector3[]
---@field public tangents Vector4[]
---@field public uv Vector2[]
---@field public uv2 Vector2[]
---@field public uv3 Vector2[]
---@field public uv4 Vector2[]
---@field public uv5 Vector2[]
---@field public uv6 Vector2[]
---@field public uv7 Vector2[]
---@field public uv8 Vector2[]
---@field public colors Color[]
---@field public colors32 Color32[]
---@field public vertexAttributeCount Int32
---@field public triangles Int32[]
---@field public boneWeights BoneWeight[]
local Mesh={ }
---@public
---@param indexCount Int32
---@param format number
---@return void
function Mesh:SetIndexBufferParams(indexCount, format) end
---@public
---@param vertexCount Int32
---@param attributes VertexAttributeDescriptor[]
---@return void
function Mesh:SetVertexBufferParams(vertexCount, attributes) end
---@public
---@param index Int32
---@return VertexAttributeDescriptor
function Mesh:GetVertexAttribute(index) end
---@public
---@param attr number
---@return bool
function Mesh:HasVertexAttribute(attr) end
---@public
---@param attr number
---@return Int32
function Mesh:GetVertexAttributeDimension(attr) end
---@public
---@param attr number
---@return number
function Mesh:GetVertexAttributeFormat(attr) end
---@public
---@param index Int32
---@return IntPtr
function Mesh:GetNativeVertexBufferPtr(index) end
---@public
---@return IntPtr
function Mesh:GetNativeIndexBufferPtr() end
---@public
---@return void
function Mesh:ClearBlendShapes() end
---@public
---@param shapeIndex Int32
---@return string
function Mesh:GetBlendShapeName(shapeIndex) end
---@public
---@param blendShapeName string
---@return Int32
function Mesh:GetBlendShapeIndex(blendShapeName) end
---@public
---@param shapeIndex Int32
---@return Int32
function Mesh:GetBlendShapeFrameCount(shapeIndex) end
---@public
---@param shapeIndex Int32
---@param frameIndex Int32
---@return Single
function Mesh:GetBlendShapeFrameWeight(shapeIndex, frameIndex) end
---@public
---@param shapeIndex Int32
---@param frameIndex Int32
---@param deltaVertices Vector3[]
---@param deltaNormals Vector3[]
---@param deltaTangents Vector3[]
---@return void
function Mesh:GetBlendShapeFrameVertices(shapeIndex, frameIndex, deltaVertices, deltaNormals, deltaTangents) end
---@public
---@param shapeName string
---@param frameWeight Single
---@param deltaVertices Vector3[]
---@param deltaNormals Vector3[]
---@param deltaTangents Vector3[]
---@return void
function Mesh:AddBlendShapeFrame(shapeName, frameWeight, deltaVertices, deltaNormals, deltaTangents) end
---@public
---@param bonesPerVertex NativeArray`1
---@param weights NativeArray`1
---@return void
function Mesh:SetBoneWeights(bonesPerVertex, weights) end
---@public
---@return NativeArray`1
function Mesh:GetAllBoneWeights() end
---@public
---@return NativeArray`1
function Mesh:GetBonesPerVertex() end
---@public
---@param index Int32
---@param desc SubMeshDescriptor
---@param flags number
---@return void
function Mesh:SetSubMesh(index, desc, flags) end
---@public
---@param index Int32
---@return SubMeshDescriptor
function Mesh:GetSubMesh(index) end
---@public
---@return void
function Mesh:MarkModified() end
---@public
---@param uvSetIndex Int32
---@return Single
function Mesh:GetUVDistributionMetric(uvSetIndex) end
---@public
---@param vertices List`1
---@return void
function Mesh:GetVertices(vertices) end
---@public
---@param inVertices List`1
---@return void
function Mesh:SetVertices(inVertices) end
---@public
---@param inVertices List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetVertices(inVertices, start, length) end
---@public
---@param inVertices Vector3[]
---@return void
function Mesh:SetVertices(inVertices) end
---@public
---@param inVertices Vector3[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetVertices(inVertices, start, length) end
---@public
---@param normals List`1
---@return void
function Mesh:GetNormals(normals) end
---@public
---@param inNormals List`1
---@return void
function Mesh:SetNormals(inNormals) end
---@public
---@param inNormals List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetNormals(inNormals, start, length) end
---@public
---@param inNormals Vector3[]
---@return void
function Mesh:SetNormals(inNormals) end
---@public
---@param inNormals Vector3[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetNormals(inNormals, start, length) end
---@public
---@param tangents List`1
---@return void
function Mesh:GetTangents(tangents) end
---@public
---@param inTangents List`1
---@return void
function Mesh:SetTangents(inTangents) end
---@public
---@param inTangents List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetTangents(inTangents, start, length) end
---@public
---@param inTangents Vector4[]
---@return void
function Mesh:SetTangents(inTangents) end
---@public
---@param inTangents Vector4[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetTangents(inTangents, start, length) end
---@public
---@param colors List`1
---@return void
function Mesh:GetColors(colors) end
---@public
---@param inColors List`1
---@return void
function Mesh:SetColors(inColors) end
---@public
---@param inColors List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetColors(inColors, start, length) end
---@public
---@param inColors Color[]
---@return void
function Mesh:SetColors(inColors) end
---@public
---@param inColors Color[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetColors(inColors, start, length) end
---@public
---@param colors List`1
---@return void
function Mesh:GetColors(colors) end
---@public
---@param inColors List`1
---@return void
function Mesh:SetColors(inColors) end
---@public
---@param inColors List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetColors(inColors, start, length) end
---@public
---@param inColors Color32[]
---@return void
function Mesh:SetColors(inColors) end
---@public
---@param inColors Color32[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetColors(inColors, start, length) end
---@public
---@param channel Int32
---@param uvs List`1
---@return void
function Mesh:SetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs List`1
---@return void
function Mesh:SetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs List`1
---@return void
function Mesh:SetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetUVs(channel, uvs, start, length) end
---@public
---@param channel Int32
---@param uvs List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetUVs(channel, uvs, start, length) end
---@public
---@param channel Int32
---@param uvs List`1
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetUVs(channel, uvs, start, length) end
---@public
---@param channel Int32
---@param uvs Vector2[]
---@return void
function Mesh:SetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs Vector3[]
---@return void
function Mesh:SetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs Vector4[]
---@return void
function Mesh:SetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs Vector2[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetUVs(channel, uvs, start, length) end
---@public
---@param channel Int32
---@param uvs Vector3[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetUVs(channel, uvs, start, length) end
---@public
---@param channel Int32
---@param uvs Vector4[]
---@param start Int32
---@param length Int32
---@return void
function Mesh:SetUVs(channel, uvs, start, length) end
---@public
---@param channel Int32
---@param uvs List`1
---@return void
function Mesh:GetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs List`1
---@return void
function Mesh:GetUVs(channel, uvs) end
---@public
---@param channel Int32
---@param uvs List`1
---@return void
function Mesh:GetUVs(channel, uvs) end
---@public
---@return VertexAttributeDescriptor[]
function Mesh:GetVertexAttributes() end
---@public
---@param attributes VertexAttributeDescriptor[]
---@return Int32
function Mesh:GetVertexAttributes(attributes) end
---@public
---@param attributes List`1
---@return Int32
function Mesh:GetVertexAttributes(attributes) end
---@public
---@param submesh Int32
---@return Int32[]
function Mesh:GetTriangles(submesh) end
---@public
---@param submesh Int32
---@param applyBaseVertex bool
---@return Int32[]
function Mesh:GetTriangles(submesh, applyBaseVertex) end
---@public
---@param triangles List`1
---@param submesh Int32
---@return void
function Mesh:GetTriangles(triangles, submesh) end
---@public
---@param triangles List`1
---@param submesh Int32
---@param applyBaseVertex bool
---@return void
function Mesh:GetTriangles(triangles, submesh, applyBaseVertex) end
---@public
---@param triangles List`1
---@param submesh Int32
---@param applyBaseVertex bool
---@return void
function Mesh:GetTriangles(triangles, submesh, applyBaseVertex) end
---@public
---@param submesh Int32
---@return Int32[]
function Mesh:GetIndices(submesh) end
---@public
---@param submesh Int32
---@param applyBaseVertex bool
---@return Int32[]
function Mesh:GetIndices(submesh, applyBaseVertex) end
---@public
---@param indices List`1
---@param submesh Int32
---@return void
function Mesh:GetIndices(indices, submesh) end
---@public
---@param indices List`1
---@param submesh Int32
---@param applyBaseVertex bool
---@return void
function Mesh:GetIndices(indices, submesh, applyBaseVertex) end
---@public
---@param indices List`1
---@param submesh Int32
---@param applyBaseVertex bool
---@return void
function Mesh:GetIndices(indices, submesh, applyBaseVertex) end
---@public
---@param submesh Int32
---@return UInt32
function Mesh:GetIndexStart(submesh) end
---@public
---@param submesh Int32
---@return UInt32
function Mesh:GetIndexCount(submesh) end
---@public
---@param submesh Int32
---@return UInt32
function Mesh:GetBaseVertex(submesh) end
---@public
---@param triangles Int32[]
---@param submesh Int32
---@return void
function Mesh:SetTriangles(triangles, submesh) end
---@public
---@param triangles Int32[]
---@param submesh Int32
---@param calculateBounds bool
---@return void
function Mesh:SetTriangles(triangles, submesh, calculateBounds) end
---@public
---@param triangles Int32[]
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, submesh, calculateBounds, baseVertex) end
---@public
---@param triangles Int32[]
---@param trianglesStart Int32
---@param trianglesLength Int32
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, trianglesStart, trianglesLength, submesh, calculateBounds, baseVertex) end
---@public
---@param triangles UInt16[]
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, submesh, calculateBounds, baseVertex) end
---@public
---@param triangles UInt16[]
---@param trianglesStart Int32
---@param trianglesLength Int32
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, trianglesStart, trianglesLength, submesh, calculateBounds, baseVertex) end
---@public
---@param triangles List`1
---@param submesh Int32
---@return void
function Mesh:SetTriangles(triangles, submesh) end
---@public
---@param triangles List`1
---@param submesh Int32
---@param calculateBounds bool
---@return void
function Mesh:SetTriangles(triangles, submesh, calculateBounds) end
---@public
---@param triangles List`1
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, submesh, calculateBounds, baseVertex) end
---@public
---@param triangles List`1
---@param trianglesStart Int32
---@param trianglesLength Int32
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, trianglesStart, trianglesLength, submesh, calculateBounds, baseVertex) end
---@public
---@param triangles List`1
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, submesh, calculateBounds, baseVertex) end
---@public
---@param triangles List`1
---@param trianglesStart Int32
---@param trianglesLength Int32
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetTriangles(triangles, trianglesStart, trianglesLength, submesh, calculateBounds, baseVertex) end
---@public
---@param indices Int32[]
---@param topology number
---@param submesh Int32
---@return void
function Mesh:SetIndices(indices, topology, submesh) end
---@public
---@param indices Int32[]
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@return void
function Mesh:SetIndices(indices, topology, submesh, calculateBounds) end
---@public
---@param indices Int32[]
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param indices Int32[]
---@param indicesStart Int32
---@param indicesLength Int32
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, indicesStart, indicesLength, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param indices UInt16[]
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param indices UInt16[]
---@param indicesStart Int32
---@param indicesLength Int32
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, indicesStart, indicesLength, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param indices List`1
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param indices List`1
---@param indicesStart Int32
---@param indicesLength Int32
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, indicesStart, indicesLength, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param indices List`1
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param indices List`1
---@param indicesStart Int32
---@param indicesLength Int32
---@param topology number
---@param submesh Int32
---@param calculateBounds bool
---@param baseVertex Int32
---@return void
function Mesh:SetIndices(indices, indicesStart, indicesLength, topology, submesh, calculateBounds, baseVertex) end
---@public
---@param bindposes List`1
---@return void
function Mesh:GetBindposes(bindposes) end
---@public
---@param boneWeights List`1
---@return void
function Mesh:GetBoneWeights(boneWeights) end
---@public
---@param keepVertexLayout bool
---@return void
function Mesh:Clear(keepVertexLayout) end
---@public
---@return void
function Mesh:Clear() end
---@public
---@return void
function Mesh:RecalculateBounds() end
---@public
---@return void
function Mesh:RecalculateNormals() end
---@public
---@return void
function Mesh:RecalculateTangents() end
---@public
---@return void
function Mesh:MarkDynamic() end
---@public
---@param markNoLongerReadable bool
---@return void
function Mesh:UploadMeshData(markNoLongerReadable) end
---@public
---@return void
function Mesh:Optimize() end
---@public
---@return void
function Mesh:OptimizeIndexBuffers() end
---@public
---@return void
function Mesh:OptimizeReorderVertexBuffer() end
---@public
---@param submesh Int32
---@return number
function Mesh:GetTopology(submesh) end
---@public
---@param combine CombineInstance[]
---@param mergeSubMeshes bool
---@param useMatrices bool
---@param hasLightmapData bool
---@return void
function Mesh:CombineMeshes(combine, mergeSubMeshes, useMatrices, hasLightmapData) end
---@public
---@param combine CombineInstance[]
---@param mergeSubMeshes bool
---@param useMatrices bool
---@return void
function Mesh:CombineMeshes(combine, mergeSubMeshes, useMatrices) end
---@public
---@param combine CombineInstance[]
---@param mergeSubMeshes bool
---@return void
function Mesh:CombineMeshes(combine, mergeSubMeshes) end
---@public
---@param combine CombineInstance[]
---@return void
function Mesh:CombineMeshes(combine) end
UnityEngine.Mesh = Mesh