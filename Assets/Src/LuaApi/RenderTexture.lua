---@class RenderTexture : Texture
---@field public width Int32
---@field public height Int32
---@field public dimension number
---@field public graphicsFormat number
---@field public useMipMap bool
---@field public sRGB bool
---@field public vrUsage number
---@field public memorylessMode number
---@field public format number
---@field public stencilFormat number
---@field public autoGenerateMips bool
---@field public volumeDepth Int32
---@field public antiAliasing Int32
---@field public bindTextureMS bool
---@field public enableRandomWrite bool
---@field public useDynamicScale bool
---@field public isPowerOfTwo bool
---@field public active RenderTexture
---@field public colorBuffer RenderBuffer
---@field public depthBuffer RenderBuffer
---@field public depth Int32
---@field public descriptor RenderTextureDescriptor
---@field public generateMips bool
---@field public isCubemap bool
---@field public isVolume bool
---@field public enabled bool
local RenderTexture={ }
---@public
---@return IntPtr
function RenderTexture:GetNativeDepthBufferPtr() end
---@public
---@param discardColor bool
---@param discardDepth bool
---@return void
function RenderTexture:DiscardContents(discardColor, discardDepth) end
---@public
---@return void
function RenderTexture:MarkRestoreExpected() end
---@public
---@return void
function RenderTexture:DiscardContents() end
---@public
---@return void
function RenderTexture:ResolveAntiAliasedSurface() end
---@public
---@param target RenderTexture
---@return void
function RenderTexture:ResolveAntiAliasedSurface(target) end
---@public
---@param propertyName string
---@return void
function RenderTexture:SetGlobalShaderProperty(propertyName) end
---@public
---@return bool
function RenderTexture:Create() end
---@public
---@return void
function RenderTexture:Release() end
---@public
---@return bool
function RenderTexture:IsCreated() end
---@public
---@return void
function RenderTexture:GenerateMips() end
---@public
---@param equirect RenderTexture
---@param eye number
---@return void
function RenderTexture:ConvertToEquirect(equirect, eye) end
---@public
---@param rt RenderTexture
---@return bool
function RenderTexture.SupportsStencil(rt) end
---@public
---@param temp RenderTexture
---@return void
function RenderTexture.ReleaseTemporary(temp) end
---@public
---@param desc RenderTextureDescriptor
---@return RenderTexture
function RenderTexture.GetTemporary(desc) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param antiAliasing Int32
---@param memorylessMode number
---@param vrUsage number
---@param useDynamicScale bool
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, antiAliasing, memorylessMode, vrUsage, useDynamicScale) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param antiAliasing Int32
---@param memorylessMode number
---@param vrUsage number
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, antiAliasing, memorylessMode, vrUsage) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param antiAliasing Int32
---@param memorylessMode number
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, antiAliasing, memorylessMode) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param antiAliasing Int32
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, antiAliasing) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param readWrite number
---@param antiAliasing Int32
---@param memorylessMode number
---@param vrUsage number
---@param useDynamicScale bool
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, readWrite, antiAliasing, memorylessMode, vrUsage, useDynamicScale) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param readWrite number
---@param antiAliasing Int32
---@param memorylessMode number
---@param vrUsage number
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, readWrite, antiAliasing, memorylessMode, vrUsage) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param readWrite number
---@param antiAliasing Int32
---@param memorylessMode number
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, readWrite, antiAliasing, memorylessMode) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param readWrite number
---@param antiAliasing Int32
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, readWrite, antiAliasing) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@param readWrite number
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format, readWrite) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@param format number
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer, format) end
---@public
---@param width Int32
---@param height Int32
---@param depthBuffer Int32
---@return RenderTexture
function RenderTexture.GetTemporary(width, height, depthBuffer) end
---@public
---@param width Int32
---@param height Int32
---@return RenderTexture
function RenderTexture.GetTemporary(width, height) end
---@public
---@param color Color
---@return void
function RenderTexture:SetBorderColor(color) end
---@public
---@return Vector2
function RenderTexture:GetTexelOffset() end
UnityEngine.RenderTexture = RenderTexture