---@class Texture2D : Texture
---@field public format number
---@field public whiteTexture Texture2D
---@field public blackTexture Texture2D
---@field public redTexture Texture2D
---@field public grayTexture Texture2D
---@field public linearGrayTexture Texture2D
---@field public normalTexture Texture2D
---@field public isReadable bool
---@field public streamingMipmaps bool
---@field public streamingMipmapsPriority Int32
---@field public requestedMipmapLevel Int32
---@field public minimumMipmapLevel Int32
---@field public calculatedMipmapLevel Int32
---@field public desiredMipmapLevel Int32
---@field public loadingMipmapLevel Int32
---@field public loadedMipmapLevel Int32
---@field public alphaIsTransparency bool
local Texture2D={ }
---@public
---@param highQuality bool
---@return void
function Texture2D:Compress(highQuality) end
---@public
---@return void
function Texture2D:ClearRequestedMipmapLevel() end
---@public
---@return bool
function Texture2D:IsRequestedMipmapLevelLoaded() end
---@public
---@return void
function Texture2D:ClearMinimumMipmapLevel() end
---@public
---@param nativeTex IntPtr
---@return void
function Texture2D:UpdateExternalTexture(nativeTex) end
---@public
---@return Byte[]
function Texture2D:GetRawTextureData() end
---@public
---@param x Int32
---@param y Int32
---@param blockWidth Int32
---@param blockHeight Int32
---@param miplevel Int32
---@return Color[]
function Texture2D:GetPixels(x, y, blockWidth, blockHeight, miplevel) end
---@public
---@param x Int32
---@param y Int32
---@param blockWidth Int32
---@param blockHeight Int32
---@return Color[]
function Texture2D:GetPixels(x, y, blockWidth, blockHeight) end
---@public
---@param miplevel Int32
---@return Color32[]
function Texture2D:GetPixels32(miplevel) end
---@public
---@return Color32[]
function Texture2D:GetPixels32() end
---@public
---@param textures Texture2D[]
---@param padding Int32
---@param maximumAtlasSize Int32
---@param makeNoLongerReadable bool
---@return Rect[]
function Texture2D:PackTextures(textures, padding, maximumAtlasSize, makeNoLongerReadable) end
---@public
---@param textures Texture2D[]
---@param padding Int32
---@param maximumAtlasSize Int32
---@return Rect[]
function Texture2D:PackTextures(textures, padding, maximumAtlasSize) end
---@public
---@param textures Texture2D[]
---@param padding Int32
---@return Rect[]
function Texture2D:PackTextures(textures, padding) end
---@public
---@param width Int32
---@param height Int32
---@param format number
---@param mipChain bool
---@param linear bool
---@param nativeTex IntPtr
---@return Texture2D
function Texture2D.CreateExternalTexture(width, height, format, mipChain, linear, nativeTex) end
---@public
---@param x Int32
---@param y Int32
---@param color Color
---@return void
function Texture2D:SetPixel(x, y, color) end
---@public
---@param x Int32
---@param y Int32
---@param color Color
---@param mipLevel Int32
---@return void
function Texture2D:SetPixel(x, y, color, mipLevel) end
---@public
---@param x Int32
---@param y Int32
---@param blockWidth Int32
---@param blockHeight Int32
---@param colors Color[]
---@param miplevel Int32
---@return void
function Texture2D:SetPixels(x, y, blockWidth, blockHeight, colors, miplevel) end
---@public
---@param x Int32
---@param y Int32
---@param blockWidth Int32
---@param blockHeight Int32
---@param colors Color[]
---@return void
function Texture2D:SetPixels(x, y, blockWidth, blockHeight, colors) end
---@public
---@param colors Color[]
---@param miplevel Int32
---@return void
function Texture2D:SetPixels(colors, miplevel) end
---@public
---@param colors Color[]
---@return void
function Texture2D:SetPixels(colors) end
---@public
---@param x Int32
---@param y Int32
---@return Color
function Texture2D:GetPixel(x, y) end
---@public
---@param x Int32
---@param y Int32
---@param mipLevel Int32
---@return Color
function Texture2D:GetPixel(x, y, mipLevel) end
---@public
---@param u Single
---@param v Single
---@return Color
function Texture2D:GetPixelBilinear(u, v) end
---@public
---@param u Single
---@param v Single
---@param mipLevel Int32
---@return Color
function Texture2D:GetPixelBilinear(u, v, mipLevel) end
---@public
---@param data IntPtr
---@param size Int32
---@return void
function Texture2D:LoadRawTextureData(data, size) end
---@public
---@param data Byte[]
---@return void
function Texture2D:LoadRawTextureData(data) end
---@public
---@param updateMipmaps bool
---@param makeNoLongerReadable bool
---@return void
function Texture2D:Apply(updateMipmaps, makeNoLongerReadable) end
---@public
---@param updateMipmaps bool
---@return void
function Texture2D:Apply(updateMipmaps) end
---@public
---@return void
function Texture2D:Apply() end
---@public
---@param width Int32
---@param height Int32
---@return bool
function Texture2D:Resize(width, height) end
---@public
---@param width Int32
---@param height Int32
---@param format number
---@param hasMipMap bool
---@return bool
function Texture2D:Resize(width, height, format, hasMipMap) end
---@public
---@param source Rect
---@param destX Int32
---@param destY Int32
---@param recalculateMipMaps bool
---@return void
function Texture2D:ReadPixels(source, destX, destY, recalculateMipMaps) end
---@public
---@param source Rect
---@param destX Int32
---@param destY Int32
---@return void
function Texture2D:ReadPixels(source, destX, destY) end
---@public
---@param sizes Vector2[]
---@param padding Int32
---@param atlasSize Int32
---@param results List`1
---@return bool
function Texture2D.GenerateAtlas(sizes, padding, atlasSize, results) end
---@public
---@param colors Color32[]
---@param miplevel Int32
---@return void
function Texture2D:SetPixels32(colors, miplevel) end
---@public
---@param colors Color32[]
---@return void
function Texture2D:SetPixels32(colors) end
---@public
---@param x Int32
---@param y Int32
---@param blockWidth Int32
---@param blockHeight Int32
---@param colors Color32[]
---@param miplevel Int32
---@return void
function Texture2D:SetPixels32(x, y, blockWidth, blockHeight, colors, miplevel) end
---@public
---@param x Int32
---@param y Int32
---@param blockWidth Int32
---@param blockHeight Int32
---@param colors Color32[]
---@return void
function Texture2D:SetPixels32(x, y, blockWidth, blockHeight, colors) end
---@public
---@param miplevel Int32
---@return Color[]
function Texture2D:GetPixels(miplevel) end
---@public
---@return Color[]
function Texture2D:GetPixels() end
UnityEngine.Texture2D = Texture2D