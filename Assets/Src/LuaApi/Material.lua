---@class Material : Object
---@field public shader Shader
---@field public color Color
---@field public mainTexture Texture
---@field public mainTextureOffset Vector2
---@field public mainTextureScale Vector2
---@field public renderQueue Int32
---@field public globalIlluminationFlags number
---@field public doubleSidedGI bool
---@field public enableInstancing bool
---@field public passCount Int32
---@field public shaderKeywords String[]
local Material={ }
---@public
---@param scriptContents string
---@return Material
function Material.Create(scriptContents) end
---@public
---@param nameID Int32
---@return bool
function Material:HasProperty(nameID) end
---@public
---@param name string
---@return bool
function Material:HasProperty(name) end
---@public
---@param keyword string
---@return void
function Material:EnableKeyword(keyword) end
---@public
---@param keyword string
---@return void
function Material:DisableKeyword(keyword) end
---@public
---@param keyword string
---@return bool
function Material:IsKeywordEnabled(keyword) end
---@public
---@param passName string
---@param enabled bool
---@return void
function Material:SetShaderPassEnabled(passName, enabled) end
---@public
---@param passName string
---@return bool
function Material:GetShaderPassEnabled(passName) end
---@public
---@param pass Int32
---@return string
function Material:GetPassName(pass) end
---@public
---@param passName string
---@return Int32
function Material:FindPass(passName) end
---@public
---@param tag string
---@param val string
---@return void
function Material:SetOverrideTag(tag, val) end
---@public
---@param tag string
---@param searchFallbacks bool
---@param defaultValue string
---@return string
function Material:GetTag(tag, searchFallbacks, defaultValue) end
---@public
---@param tag string
---@param searchFallbacks bool
---@return string
function Material:GetTag(tag, searchFallbacks) end
---@public
---@param start Material
---@param end Material
---@param t Single
---@return void
function Material:Lerp(start, end, t) end
---@public
---@param pass Int32
---@return bool
function Material:SetPass(pass) end
---@public
---@param mat Material
---@return void
function Material:CopyPropertiesFromMaterial(mat) end
---@public
---@return Int32
function Material:ComputeCRC() end
---@public
---@return String[]
function Material:GetTexturePropertyNames() end
---@public
---@return Int32[]
function Material:GetTexturePropertyNameIDs() end
---@public
---@param outNames List`1
---@return void
function Material:GetTexturePropertyNames(outNames) end
---@public
---@param outNames List`1
---@return void
function Material:GetTexturePropertyNameIDs(outNames) end
---@public
---@param name string
---@param value Single
---@return void
function Material:SetFloat(name, value) end
---@public
---@param nameID Int32
---@param value Single
---@return void
function Material:SetFloat(nameID, value) end
---@public
---@param name string
---@param value Int32
---@return void
function Material:SetInt(name, value) end
---@public
---@param nameID Int32
---@param value Int32
---@return void
function Material:SetInt(nameID, value) end
---@public
---@param name string
---@param value Color
---@return void
function Material:SetColor(name, value) end
---@public
---@param nameID Int32
---@param value Color
---@return void
function Material:SetColor(nameID, value) end
---@public
---@param name string
---@param value Vector4
---@return void
function Material:SetVector(name, value) end
---@public
---@param nameID Int32
---@param value Vector4
---@return void
function Material:SetVector(nameID, value) end
---@public
---@param name string
---@param value Matrix4x4
---@return void
function Material:SetMatrix(name, value) end
---@public
---@param nameID Int32
---@param value Matrix4x4
---@return void
function Material:SetMatrix(nameID, value) end
---@public
---@param name string
---@param value Texture
---@return void
function Material:SetTexture(name, value) end
---@public
---@param nameID Int32
---@param value Texture
---@return void
function Material:SetTexture(nameID, value) end
---@public
---@param name string
---@param value RenderTexture
---@param element number
---@return void
function Material:SetTexture(name, value, element) end
---@public
---@param nameID Int32
---@param value RenderTexture
---@param element number
---@return void
function Material:SetTexture(nameID, value, element) end
---@public
---@param name string
---@param value ComputeBuffer
---@return void
function Material:SetBuffer(name, value) end
---@public
---@param nameID Int32
---@param value ComputeBuffer
---@return void
function Material:SetBuffer(nameID, value) end
---@public
---@param name string
---@param value ComputeBuffer
---@param offset Int32
---@param size Int32
---@return void
function Material:SetConstantBuffer(name, value, offset, size) end
---@public
---@param nameID Int32
---@param value ComputeBuffer
---@param offset Int32
---@param size Int32
---@return void
function Material:SetConstantBuffer(nameID, value, offset, size) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:SetFloatArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:SetFloatArray(nameID, values) end
---@public
---@param name string
---@param values Single[]
---@return void
function Material:SetFloatArray(name, values) end
---@public
---@param nameID Int32
---@param values Single[]
---@return void
function Material:SetFloatArray(nameID, values) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:SetColorArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:SetColorArray(nameID, values) end
---@public
---@param name string
---@param values Color[]
---@return void
function Material:SetColorArray(name, values) end
---@public
---@param nameID Int32
---@param values Color[]
---@return void
function Material:SetColorArray(nameID, values) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:SetVectorArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:SetVectorArray(nameID, values) end
---@public
---@param name string
---@param values Vector4[]
---@return void
function Material:SetVectorArray(name, values) end
---@public
---@param nameID Int32
---@param values Vector4[]
---@return void
function Material:SetVectorArray(nameID, values) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:SetMatrixArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:SetMatrixArray(nameID, values) end
---@public
---@param name string
---@param values Matrix4x4[]
---@return void
function Material:SetMatrixArray(name, values) end
---@public
---@param nameID Int32
---@param values Matrix4x4[]
---@return void
function Material:SetMatrixArray(nameID, values) end
---@public
---@param name string
---@return Single
function Material:GetFloat(name) end
---@public
---@param nameID Int32
---@return Single
function Material:GetFloat(nameID) end
---@public
---@param name string
---@return Int32
function Material:GetInt(name) end
---@public
---@param nameID Int32
---@return Int32
function Material:GetInt(nameID) end
---@public
---@param name string
---@return Color
function Material:GetColor(name) end
---@public
---@param nameID Int32
---@return Color
function Material:GetColor(nameID) end
---@public
---@param name string
---@return Vector4
function Material:GetVector(name) end
---@public
---@param nameID Int32
---@return Vector4
function Material:GetVector(nameID) end
---@public
---@param name string
---@return Matrix4x4
function Material:GetMatrix(name) end
---@public
---@param nameID Int32
---@return Matrix4x4
function Material:GetMatrix(nameID) end
---@public
---@param name string
---@return Texture
function Material:GetTexture(name) end
---@public
---@param nameID Int32
---@return Texture
function Material:GetTexture(nameID) end
---@public
---@param name string
---@return Single[]
function Material:GetFloatArray(name) end
---@public
---@param nameID Int32
---@return Single[]
function Material:GetFloatArray(nameID) end
---@public
---@param name string
---@return Color[]
function Material:GetColorArray(name) end
---@public
---@param nameID Int32
---@return Color[]
function Material:GetColorArray(nameID) end
---@public
---@param name string
---@return Vector4[]
function Material:GetVectorArray(name) end
---@public
---@param nameID Int32
---@return Vector4[]
function Material:GetVectorArray(nameID) end
---@public
---@param name string
---@return Matrix4x4[]
function Material:GetMatrixArray(name) end
---@public
---@param nameID Int32
---@return Matrix4x4[]
function Material:GetMatrixArray(nameID) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:GetFloatArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:GetFloatArray(nameID, values) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:GetColorArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:GetColorArray(nameID, values) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:GetVectorArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:GetVectorArray(nameID, values) end
---@public
---@param name string
---@param values List`1
---@return void
function Material:GetMatrixArray(name, values) end
---@public
---@param nameID Int32
---@param values List`1
---@return void
function Material:GetMatrixArray(nameID, values) end
---@public
---@param name string
---@param value Vector2
---@return void
function Material:SetTextureOffset(name, value) end
---@public
---@param nameID Int32
---@param value Vector2
---@return void
function Material:SetTextureOffset(nameID, value) end
---@public
---@param name string
---@param value Vector2
---@return void
function Material:SetTextureScale(name, value) end
---@public
---@param nameID Int32
---@param value Vector2
---@return void
function Material:SetTextureScale(nameID, value) end
---@public
---@param name string
---@return Vector2
function Material:GetTextureOffset(name) end
---@public
---@param nameID Int32
---@return Vector2
function Material:GetTextureOffset(nameID) end
---@public
---@param name string
---@return Vector2
function Material:GetTextureScale(name) end
---@public
---@param nameID Int32
---@return Vector2
function Material:GetTextureScale(nameID) end
UnityEngine.Material = Material