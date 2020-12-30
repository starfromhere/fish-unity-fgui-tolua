---@class Texture : Object
---@field public GenerateAllMips Int32
---@field public masterTextureLimit Int32
---@field public mipmapCount Int32
---@field public anisotropicFiltering number
---@field public graphicsFormat number
---@field public width Int32
---@field public height Int32
---@field public dimension number
---@field public isReadable bool
---@field public wrapMode number
---@field public wrapModeU number
---@field public wrapModeV number
---@field public wrapModeW number
---@field public filterMode number
---@field public anisoLevel Int32
---@field public mipMapBias Single
---@field public texelSize Vector2
---@field public updateCount UInt32
---@field public imageContentsHash Hash128
---@field public totalTextureMemory UInt64
---@field public desiredTextureMemory UInt64
---@field public targetTextureMemory UInt64
---@field public currentTextureMemory UInt64
---@field public nonStreamingTextureMemory UInt64
---@field public streamingMipmapUploadCount UInt64
---@field public streamingRendererCount UInt64
---@field public streamingTextureCount UInt64
---@field public nonStreamingTextureCount UInt64
---@field public streamingTexturePendingLoadCount UInt64
---@field public streamingTextureLoadingCount UInt64
---@field public streamingTextureForceLoadAll bool
---@field public streamingTextureDiscardUnusedMips bool
---@field public allowThreadedTextureCreation bool
local Texture={ }
---@public
---@param forcedMin Int32
---@param globalMax Int32
---@return void
function Texture.SetGlobalAnisotropicFilteringLimits(forcedMin, globalMax) end
---@public
---@return IntPtr
function Texture:GetNativeTexturePtr() end
---@public
---@return Int32
function Texture:GetNativeTextureID() end
---@public
---@return void
function Texture:IncrementUpdateCount() end
---@public
---@return void
function Texture.SetStreamingTextureMaterialDebugProperties() end
UnityEngine.Texture = Texture