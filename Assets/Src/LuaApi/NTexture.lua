---@class NTexture : Object
---@field public CustomDestroyMethod Action`1
---@field public uvRect Rect
---@field public rotated bool
---@field public refCount Int32
---@field public lastActive Single
---@field public destroyMethod number
---@field public Empty NTexture
---@field public width Int32
---@field public height Int32
---@field public offset Vector2
---@field public originalSize Vector2
---@field public root NTexture
---@field public disposed bool
---@field public nativeTexture Texture
---@field public alphaTexture Texture
local NTexture={ }
---@public
---@param value Action
---@return void
function NTexture:add_onSizeChanged(value) end
---@public
---@param value Action
---@return void
function NTexture:remove_onSizeChanged(value) end
---@public
---@return void
function NTexture.DisposeEmpty() end
---@public
---@param drawRect Rect
---@return Rect
function NTexture:GetDrawRect(drawRect) end
---@public
---@param uv Vector2[]
---@return void
function NTexture:GetUV(uv) end
---@public
---@param shaderName string
---@return MaterialManager
function NTexture:GetMaterialManager(shaderName) end
---@public
---@return void
function NTexture:Unload() end
---@public
---@param destroyMaterials bool
---@return void
function NTexture:Unload(destroyMaterials) end
---@public
---@param nativeTexture Texture
---@param alphaTexture Texture
---@return void
function NTexture:Reload(nativeTexture, alphaTexture) end
---@public
---@return void
function NTexture:Dispose() end
FairyGUI.NTexture = NTexture