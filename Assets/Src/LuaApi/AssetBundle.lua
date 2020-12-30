---@class AssetBundle : Object
---@field public mainAsset Object
---@field public isStreamedSceneAssetBundle bool
local AssetBundle={ }
---@public
---@param unloadAllObjects bool
---@return void
function AssetBundle.UnloadAllAssetBundles(unloadAllObjects) end
---@public
---@return IEnumerable`1
function AssetBundle.GetAllLoadedAssetBundles() end
---@public
---@param path string
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromFileAsync(path) end
---@public
---@param path string
---@param crc UInt32
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromFileAsync(path, crc) end
---@public
---@param path string
---@param crc UInt32
---@param offset UInt64
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromFileAsync(path, crc, offset) end
---@public
---@param path string
---@return AssetBundle
function AssetBundle.LoadFromFile(path) end
---@public
---@param path string
---@param crc UInt32
---@return AssetBundle
function AssetBundle.LoadFromFile(path, crc) end
---@public
---@param path string
---@param crc UInt32
---@param offset UInt64
---@return AssetBundle
function AssetBundle.LoadFromFile(path, crc, offset) end
---@public
---@param binary Byte[]
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromMemoryAsync(binary) end
---@public
---@param binary Byte[]
---@param crc UInt32
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromMemoryAsync(binary, crc) end
---@public
---@param binary Byte[]
---@return AssetBundle
function AssetBundle.LoadFromMemory(binary) end
---@public
---@param binary Byte[]
---@param crc UInt32
---@return AssetBundle
function AssetBundle.LoadFromMemory(binary, crc) end
---@public
---@param stream Stream
---@param crc UInt32
---@param managedReadBufferSize UInt32
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromStreamAsync(stream, crc, managedReadBufferSize) end
---@public
---@param stream Stream
---@param crc UInt32
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromStreamAsync(stream, crc) end
---@public
---@param stream Stream
---@return AssetBundleCreateRequest
function AssetBundle.LoadFromStreamAsync(stream) end
---@public
---@param stream Stream
---@param crc UInt32
---@param managedReadBufferSize UInt32
---@return AssetBundle
function AssetBundle.LoadFromStream(stream, crc, managedReadBufferSize) end
---@public
---@param stream Stream
---@param crc UInt32
---@return AssetBundle
function AssetBundle.LoadFromStream(stream, crc) end
---@public
---@param stream Stream
---@return AssetBundle
function AssetBundle.LoadFromStream(stream) end
---@public
---@param password string
---@return void
function AssetBundle.SetAssetBundleDecryptKey(password) end
---@public
---@param name string
---@return bool
function AssetBundle:Contains(name) end
---@public
---@param name string
---@return Object
function AssetBundle:Load(name) end
---@public
---@return Object[]
function AssetBundle:LoadAll() end
---@public
---@param name string
---@return Object
function AssetBundle:LoadAsset(name) end
---@public
---@param name string
---@param type Type
---@return Object
function AssetBundle:LoadAsset(name, type) end
---@public
---@param name string
---@return AssetBundleRequest
function AssetBundle:LoadAssetAsync(name) end
---@public
---@param name string
---@param type Type
---@return AssetBundleRequest
function AssetBundle:LoadAssetAsync(name, type) end
---@public
---@param name string
---@return Object[]
function AssetBundle:LoadAssetWithSubAssets(name) end
---@public
---@param name string
---@param type Type
---@return Object[]
function AssetBundle:LoadAssetWithSubAssets(name, type) end
---@public
---@param name string
---@return AssetBundleRequest
function AssetBundle:LoadAssetWithSubAssetsAsync(name) end
---@public
---@param name string
---@param type Type
---@return AssetBundleRequest
function AssetBundle:LoadAssetWithSubAssetsAsync(name, type) end
---@public
---@return Object[]
function AssetBundle:LoadAllAssets() end
---@public
---@param type Type
---@return Object[]
function AssetBundle:LoadAllAssets(type) end
---@public
---@return AssetBundleRequest
function AssetBundle:LoadAllAssetsAsync() end
---@public
---@param type Type
---@return AssetBundleRequest
function AssetBundle:LoadAllAssetsAsync(type) end
---@public
---@return String[]
function AssetBundle:AllAssetNames() end
---@public
---@param unloadAllLoadedObjects bool
---@return void
function AssetBundle:Unload(unloadAllLoadedObjects) end
---@public
---@return String[]
function AssetBundle:GetAllAssetNames() end
---@public
---@return String[]
function AssetBundle:GetAllScenePaths() end
---@public
---@param inputPath string
---@param outputPath string
---@param method BuildCompression
---@param expectedCRC UInt32
---@param priority number
---@return AssetBundleRecompressOperation
function AssetBundle.RecompressAssetBundleAsync(inputPath, outputPath, method, expectedCRC, priority) end
---@public
---@param path string
---@return AssetBundle
function AssetBundle.CreateFromFile(path) end
---@public
---@param binary Byte[]
---@return AssetBundleCreateRequest
function AssetBundle.CreateFromMemory(binary) end
---@public
---@param binary Byte[]
---@return AssetBundle
function AssetBundle.CreateFromMemoryImmediate(binary) end
UnityEngine.AssetBundle = AssetBundle