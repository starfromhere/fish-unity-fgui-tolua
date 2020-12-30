---@class UIPackage : Object
---@field public unloadBundleByFGUI bool
---@field public URL_PREFIX string
---@field public LoadFromResPath LoadResource
---@field public id string
---@field public name string
---@field public branch string
---@field public assetPath string
---@field public customId string
---@field public resBundle AssetBundle
---@field public dependencies Dictionary`2[]
local UIPackage={ }
---@public
---@param key string
---@return string
function UIPackage.GetVar(key) end
---@public
---@param key string
---@param value string
---@return void
function UIPackage.SetVar(key, value) end
---@public
---@param id string
---@return UIPackage
function UIPackage.GetById(id) end
---@public
---@param name string
---@return UIPackage
function UIPackage.GetByName(name) end
---@public
---@param bundle AssetBundle
---@return UIPackage
function UIPackage.AddPackage(bundle) end
---@public
---@param desc AssetBundle
---@param res AssetBundle
---@return UIPackage
function UIPackage.AddPackage(desc, res) end
---@public
---@param desc AssetBundle
---@param res AssetBundle
---@param mainAssetName string
---@return UIPackage
function UIPackage.AddPackage(desc, res, mainAssetName) end
---@public
---@param descFilePath string
---@return UIPackage
function UIPackage.AddPackage(descFilePath) end
---@public
---@param assetPath string
---@param loadFunc LoadResource
---@return UIPackage
function UIPackage.AddPackage(assetPath, loadFunc) end
---@public
---@param descData Byte[]
---@param assetNamePrefix string
---@param loadFunc LoadResource
---@return UIPackage
function UIPackage.AddPackage(descData, assetNamePrefix, loadFunc) end
---@public
---@param descData Byte[]
---@param assetNamePrefix string
---@param loadFunc LoadResourceAsync
---@return UIPackage
function UIPackage.AddPackage(descData, assetNamePrefix, loadFunc) end
---@public
---@param packageIdOrName string
---@return void
function UIPackage.RemovePackage(packageIdOrName) end
---@public
---@return void
function UIPackage.RemoveAllPackages() end
---@public
---@return List`1
function UIPackage.GetPackages() end
---@public
---@param pkgName string
---@param resName string
---@return GObject
function UIPackage.CreateObject(pkgName, resName) end
---@public
---@param pkgName string
---@param resName string
---@param userClass Type
---@return GObject
function UIPackage.CreateObject(pkgName, resName, userClass) end
---@public
---@param url string
---@return GObject
function UIPackage.CreateObjectFromURL(url) end
---@public
---@param url string
---@param userClass Type
---@return GObject
function UIPackage.CreateObjectFromURL(url, userClass) end
---@public
---@param pkgName string
---@param resName string
---@param callback CreateObjectCallback
---@return void
function UIPackage.CreateObjectAsync(pkgName, resName, callback) end
---@public
---@param url string
---@param callback CreateObjectCallback
---@return void
function UIPackage.CreateObjectFromURL(url, callback) end
---@public
---@param pkgName string
---@param resName string
---@return Object
function UIPackage.GetItemAsset(pkgName, resName) end
---@public
---@param url string
---@return Object
function UIPackage.GetItemAssetByURL(url) end
---@public
---@param pkgName string
---@param resName string
---@return string
function UIPackage.GetItemURL(pkgName, resName) end
---@public
---@param url string
---@return PackageItem
function UIPackage.GetItemByURL(url) end
---@public
---@param url string
---@return string
function UIPackage.NormalizeURL(url) end
---@public
---@param source XML
---@return void
function UIPackage.SetStringsSource(source) end
---@public
---@return void
function UIPackage:LoadAllAssets() end
---@public
---@return void
function UIPackage:UnloadAssets() end
---@public
---@return void
function UIPackage:ReloadAssets() end
---@public
---@param resBundle AssetBundle
---@return void
function UIPackage:ReloadAssets(resBundle) end
---@public
---@param resName string
---@return GObject
function UIPackage:CreateObject(resName) end
---@public
---@param resName string
---@param userClass Type
---@return GObject
function UIPackage:CreateObject(resName, userClass) end
---@public
---@param resName string
---@param callback CreateObjectCallback
---@return void
function UIPackage:CreateObjectAsync(resName, callback) end
---@public
---@param resName string
---@return Object
function UIPackage:GetItemAsset(resName) end
---@public
---@return List`1
function UIPackage:GetItems() end
---@public
---@param itemId string
---@return PackageItem
function UIPackage:GetItem(itemId) end
---@public
---@param itemName string
---@return PackageItem
function UIPackage:GetItemByName(itemName) end
---@public
---@param item PackageItem
---@return Object
function UIPackage:GetItemAsset(item) end
---@public
---@param item PackageItem
---@param asset Object
---@param destroyMethod number
---@return void
function UIPackage:SetItemAsset(item, asset, destroyMethod) end
FairyGUI.UIPackage = UIPackage