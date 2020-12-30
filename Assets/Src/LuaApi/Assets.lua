---@class Assets : MonoBehaviour
---@field public Bundles string
---@field public Versions string
---@field public assetLoader Func`3
---@field public onAssetLoaded Action`1
---@field public onAssetUnloaded Action`1
---@field public versionsLoader Func`1
---@field public verifyBy number
---@field public development bool
---@field public updateAll bool
---@field public enableCopyAssets bool
---@field public loggable bool
---@field public downloadURL string
---@field public currentVersion string
---@field public basePath string
---@field public updatePath string
---@field public patches4Init String[]
---@field public searchPaths String[]
---@field public localVersions Versions
---@field public serverVersions Versions
local Assets={ }
---@public
---@return String[]
function Assets.GetAllAssetPaths() end
---@public
---@param completed Action`1
---@return void
function Assets.Initialize(completed) end
---@public
---@param completed Action`1
---@return void
function Assets.DownloadVersions(completed) end
---@public
---@param filename string
---@return Versions
function Assets.LoadVersions(filename) end
---@public
---@param patches String[]
---@param handler Downloader&
---@return bool
function Assets.DownloadAll(patches, handler) end
---@public
---@param handler Downloader&
---@return bool
function Assets.DownloadAll(handler) end
---@public
---@return void
function Assets.Pause() end
---@public
---@return void
function Assets.UnPause() end
---@public
---@param path string
---@param additive bool
---@return SceneAssetRequest
function Assets.LoadSceneAsync(path, additive) end
---@public
---@param scene SceneAssetRequest
---@return void
function Assets.UnloadScene(scene) end
---@public
---@param path string
---@param type Type
---@return AssetRequest
function Assets.LoadAssetAsync(path, type) end
---@public
---@param path string
---@param type Type
---@return AssetRequest
function Assets.LoadAsset(path, type) end
---@public
---@param asset AssetRequest
---@return void
function Assets.UnloadAsset(asset) end
---@public
---@return void
function Assets.RemoveUnusedAssets() end
---@public
---@param url string
---@param filename string
---@return UnityWebRequest
function Assets.Download(url, filename) end
---@public
---@param filename string
---@return string
function Assets.GetDownloadURL(filename) end
---@public
---@return string
function Assets.DumpAssets() end
---@public
---@param path string
---@return string
function Assets.GetAssetsPath(path) end
libx.Assets = Assets