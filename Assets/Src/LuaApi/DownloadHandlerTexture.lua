---@class DownloadHandlerTexture : DownloadHandler
---@field public texture Texture2D
local DownloadHandlerTexture={ }
---@public
---@param www UnityWebRequest
---@return Texture2D
function DownloadHandlerTexture.GetContent(www) end
UnityEngine.Networking.DownloadHandlerTexture = DownloadHandlerTexture