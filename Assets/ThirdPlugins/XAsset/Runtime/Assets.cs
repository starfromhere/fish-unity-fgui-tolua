//
// Assets.cs
//
// Author:
//       fjy <jiyuan.feng@live.com>
//
// Copyright (c) 2020 fjy
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation bundles (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;
using UnityEngine.Assertions;
using UnityEngine.Networking;
using Object = UnityEngine.Object;
using Version = System.Version;

namespace libx
{
    public sealed class Assets : MonoBehaviour
    {
        public const string Bundles = "Bundles";
        public const string Versions = "versions.bundle";

        private const string TAG = "[Assets]";

        public static Func<string, Type, Object> assetLoader = null;
        public static Action<string> onAssetLoaded = null;
        public static Action<string> onAssetUnloaded = null;
        public static Func<Versions> versionsLoader = null;

        private static void Log(string s)
        {
            if (!loggable) return;
            Debug.Log(string.Format("{0}{1}", TAG, s)); 
        }

        #region API

        public static VerifyBy verifyBy = VerifyBy.CRC;

        public static bool development { get; set; }

        public static bool updateAll { get; set; }
        
        public static bool enableCopyAssets { get; set; }

        public static bool loggable { get; set; }

        public static string downloadURL { get; set; }
        
        public static string currentVersion { get; set; }

        public static string basePath { get; set; }

        public static string updatePath { get; set; }

        public static string[] patches4Init { get; set; }

        public static string[] searchPaths { get; set; }
        
        public static string apkUrl { get; set; }

        public static string[] GetAllAssetPaths()
        {
            var assets = new List<string>();
            assets.AddRange(AssetToBundles.Keys);
            return assets.ToArray();
        }

        private static bool WriteVersion(string file)
        { 
            if (File.Exists(file))
            {
                var ver = File.ReadAllText(file);
                var v1 = new Version(ver);
                var v2 = new Version(localVersions.ver);
                if (v2 > v1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }

            return true;
        }

        public static void Initialize(Action<string> completed = null)
        {
            var instance = FindObjectOfType<Assets>();
            if (instance == null)
            {
                instance = new GameObject("Assets").AddComponent<Assets>();
                DontDestroyOnLoad(instance.gameObject);
                NetworkMonitor.Instance.onReachabilityChanged += OnReachablityChanged;
                Application.lowMemory += ApplicationOnLowMemory;
            }

            if (string.IsNullOrEmpty(basePath))
                basePath = Application.streamingAssetsPath + "/" + Bundles + "/";

            if (string.IsNullOrEmpty(updatePath))
                updatePath = Application.persistentDataPath + "/" + Bundles + "/";

            if (!Directory.Exists(updatePath))
                Directory.CreateDirectory(updatePath);

            _platform = GetPlatformForAssetBundles(Application.platform);

            if (Application.platform == RuntimePlatform.OSXEditor ||
                Application.platform == RuntimePlatform.OSXPlayer ||
                Application.platform == RuntimePlatform.IPhonePlayer)
            {
                _localProtocol = "file://";
            }
            else if (Application.platform == RuntimePlatform.WindowsEditor ||
                     Application.platform == RuntimePlatform.WindowsPlayer)
            {
                _localProtocol = "file:///";
            }

            var onLoadVersions = new Action<Versions>(versions =>
            {
                localVersions = versions;

                var file = updatePath + "ver.binary";
                if (!development && WriteVersion(file))
                {
                    var filesInBuild = localVersions.GetFilesInBuild();
                    foreach (var bundle in filesInBuild)
                    {
                        var path = string.Format("{0}{1}", updatePath, bundle.name);
                        if (File.Exists(path))
                        {
                            File.Delete(path);
                            Log("Delete" + path);
                        }
                    }
                    File.WriteAllText(file, localVersions.ver);
                }

                ReloadVersions(localVersions);
                Log("Initialize");
                Log(string.Format("Development:{0}", development));
                Log(string.Format("Platform:{0}", _platform));
                Log(string.Format("BasePath:{0}", basePath));
                Log(string.Format("UpdatePath:{0}", updatePath));
                Log(string.Format("DownloadURL:{0}", downloadURL));
                Log(string.Format("ver:{0}", localVersions.ver));
                if (completed != null)
                    completed(null);
            });

            if (development)
            {
                if (versionsLoader != null)
                    onLoadVersions(versionsLoader());
            }
            else
            {
                var filename = string.Format("{0}{1}", updatePath, Versions);
                var request = Download(GetLocalURL(Versions), filename);
                request.SendWebRequest().completed += operation =>
                {
                    if (!string.IsNullOrEmpty(request.error))
                    {
                        if (completed != null)
                            completed(request.error);
                    }
                    else
                    {
                        onLoadVersions(LoadVersions(filename));
                    }

                    request.Dispose();
                };
            }
        }

        private static void ReloadVersions(Versions versions)
        {
            ActiveVariants.Clear();
            AssetToBundles.Clear();
            BundleToChildren.Clear();
            var assets = versions.assets;
            var dirs = versions.dirs;
            var bundles = versions.bundles;
            var activeVariants = versions.activeVariants;
            foreach (var item in bundles)
                BundleToChildren[item.name] = Array.ConvertAll(item.children, id => bundles[id].name);
            foreach (var item in assets)
            {
                var path = string.Format("{0}/{1}", dirs[item.dir], item.name);
                if (item.bundle >= 0 && item.bundle < bundles.Count)
                    AssetToBundles[path] = bundles[item.bundle].name;
                else
                    AssetToBundles[path] = string.Empty;
            }

            ActiveVariants.AddRange(activeVariants);
        }

        public static void DownloadVersions(Action<string> completed)
        {
            var url = GetDownloadURL(Versions);
            Log("DownloadVersions:" + url);
            var filename = Application.temporaryCachePath + "/" + Versions;
            var request = Download(url, filename);
            request.SendWebRequest().completed += operation =>
            {
                if (string.IsNullOrEmpty(request.error))
                {
                    serverVersions = LoadVersions(Application.temporaryCachePath + "/" + Versions);
                    ReloadVersions(serverVersions);
                    RemoveUnusedAssets();
                }

                if (completed != null)
                    completed(request.error);

                request.Dispose();
            };
        }

        public static Versions LoadVersions(string filename)
        {
            if (!File.Exists(filename))
                return new Versions();
            try
            {
                using (var stream = File.OpenRead(filename))
                {
                    var reader = new BinaryReader(stream);
                    var ver = new Versions();
                    ver.Deserialize(reader);
                    return ver;
                }
            }
            catch (Exception e)
            {
                Debug.LogException(e);
                return new Versions();
            }
        }

        public static bool DownloadAll(string[] patches, out Downloader handler)
        {
            if (updateAll)
            {
                return DownloadAll(out handler);
            }

            var bundles = new List<BundleRef>();
            foreach (var patch in patches)
            {
                var newFiles = GetNewFiles(patch);
                foreach (var file in newFiles)
                    if (!bundles.Exists(x => x.name.Equals(file.name)))
                        bundles.Add(file);
            }

            if (bundles.Count > 0)
            {
                var downloader = new Downloader();
                foreach (var item in bundles)
                    downloader.AddDownload(GetDownloadURL(item.name), updatePath + item.name, item.crc, item.len);
                Downloaders.Add(downloader);
                handler = downloader;
                return true;
            }

            handler = null;
            return false;
        }

        public static bool DownloadAll(out Downloader handler)
        {
            var bundles = new List<BundleRef>();
            for (var i = 0; i < serverVersions.bundles.Count; i++)
            {
                var bundle = serverVersions.bundles[i];
                if (IsNew(bundle))
                {
                    bundles.Add(bundle);
                }
            }

            if (bundles.Count > 0)
            {
                var downloader = new Downloader();
                foreach (var item in bundles)
                    downloader.AddDownload(GetDownloadURL(item.name), updatePath + item.name, item.crc, item.len);
                Downloaders.Add(downloader);
                handler = downloader;
                return true;
            }

            handler = null;
            return false;
        }

        public static void Pause()
        {
            foreach (var downloader in Downloaders)
                downloader.Pause();
        }

        public static void UnPause()
        {
            foreach (var downloader in Downloaders)
                downloader.UnPause();
        }

        public static SceneAssetRequest LoadSceneAsync(string path, bool additive = false)
        {
            Assert.IsNotNull(path, "path != null");
            string assetBundleName;
            path = GetSearchPath(path, out  assetBundleName);
            var asset = new SceneAssetAsyncRequest(path, additive) {assetBundleName = assetBundleName};
            Log(string.Format("LoadSceneAsync:{0}", path));
            asset.Load();
            asset.Retain();
            asset.name = path;
            
            LoadingScenes.Add(asset);
            
            if (!additive)
            {
                if (_runningScene != null)
                {
                    _runningScene.Release();
                    _runningScene = null;
                }

                _runningScene = asset;
            }
            else
            {
                if (_runningScene != null)
                {
                    _runningScene.additives.Add(asset);
                }
            }

            return asset;
        }

        public static void UnloadScene(SceneAssetRequest scene)
        {
            scene.Release();
        }

        public static AssetRequest LoadAssetAsync(string path, Type type)
        {
            return LoadAsset(path, type, true);
        }

        public static AssetRequest LoadAsset(string path, Type type)
        {
            return LoadAsset(path, type, false);
        }

        public static void UnloadAsset(AssetRequest asset)
        {
            asset.Release();
        }

        public static void RemoveUnusedAssets()
        {
            foreach (var item in AssetRequests)
                if (item.Value.IsUnused())
                    UnusedAssets.Add(item.Value);

            foreach (var request in UnusedAssets)
                AssetRequests.Remove(request.url);
        }

        #endregion

        #region Private

        public static UnityWebRequest Download(string url, string filename)
        {
            var request = UnityWebRequest.Get(url);
            // 设置一个超时时间
            request.timeout = 3000;
            request.downloadHandler = new DownloadHandlerFile(filename);
            return request;
        }

        public static Versions localVersions { get; private set; }

        public static Versions serverVersions { get; private set; }

        private static bool IsNew(BundleRef bundle)
        {
            if (localVersions != null)
                if (localVersions.Contains(bundle))
                    return false;

            var path = updatePath + bundle.name;
            if (!File.Exists(updatePath + bundle.name))
                return true;

            using (var stream = File.OpenRead(path))
            {
                if (stream.Length != bundle.len)
                    return true;
                if (verifyBy != VerifyBy.CRC)
                    return false;
                var comparison = StringComparison.OrdinalIgnoreCase;
                var crc = Utility.GetCRC32Hash(stream);
                return !crc.Equals(bundle.crc, comparison);
            }
        }

        private static List<BundleRef> GetNewFiles(string patch)
        {
            var list = new List<BundleRef>();
            var files = serverVersions.GetFiles(patch);
            foreach (var file in files)
                if (IsNew(file))
                    list.Add(file);

            return list;
        }

        private static string GetPlatformForAssetBundles(RuntimePlatform target)
        {
            switch (target)
            {
                case RuntimePlatform.Android:
                    return "Android";
                case RuntimePlatform.IPhonePlayer:
                    return "iOS";
                case RuntimePlatform.WebGLPlayer:
                    return "WebGL";
                case RuntimePlatform.WindowsPlayer:
                case RuntimePlatform.WindowsEditor:
                    return "Windows";
                case RuntimePlatform.OSXEditor:
                case RuntimePlatform.OSXPlayer:
                    return "OSX"; // OSX
                default:
                    return null;
            }
        }

        public static string GetDownloadURL(string filename)
        {
            return string.Format("{0}{1}/{2}", downloadURL, _platform, filename);
        }

        private static string GetLocalURL(string filename)
        {
            return _localProtocol + string.Format("{0}{1}", basePath, filename);
        }

        private static void UpdateDownloaders()
        {
            if (Downloaders.Count > 0)
            {
                for (var i = 0; i < Downloaders.Count; ++i)
                {
                    var downloader = Downloaders[i];
                    downloader.Update();
                    if (downloader.isDone)
                    {
                        Log("RemoveDownloader:" + i);
                        Downloaders.RemoveAt(i);
                        --i;
                    }
                }
            }
        }

        private static readonly List<Downloader> Downloaders = new List<Downloader>();

        private static SceneAssetRequest _runningScene;

        private static readonly Dictionary<string, AssetRequest> AssetRequests = new Dictionary<string, AssetRequest>();

        private static readonly List<AssetRequest> LoadingAssets = new List<AssetRequest>();
        private static readonly List<AssetRequest> UnusedAssets = new List<AssetRequest>();

        private static readonly List<SceneAssetRequest> SceneRequests = new List<SceneAssetRequest>();
        private static readonly List<SceneAssetRequest> LoadingScenes = new List<SceneAssetRequest>();


        private void OnApplicationFocus(bool hasFocus)
        {
#if UNITY_EDITOR // 编辑器去掉这个可以用来模拟手机上切换后台环境对下载器得功能进行测试
            if (hasFocus)
            {
                UnPause();
            }
            else
            {
                Pause();
            }
#endif
        }

        private static void OnReachablityChanged(NetworkReachability reachability)
        {
            if (reachability == NetworkReachability.NotReachable)
            {
                Pause();
            }
            else
            {
                Pause();
                UnPause();
            }
        }

        private void Update()
        {
            UpdateDownloaders();
            UpdateAssets();
            UpdateBundles();
        }

        private static void UpdateAssets()
        {
            for (var i = 0; i < LoadingAssets.Count; ++i)
            {
                var request = LoadingAssets[i];
                if (request.Update())
                    continue;
                if (!string.IsNullOrEmpty(request.error))
                {
                    request.Release();
                    if (request.IsUnused())
                    {
                        Debug.LogError(string.Format("加载失败：{0}({1})", request.url, request.error));
                        UnusedAssets.Add(request);
                    }
                }
                else
                {
                    OnAssetLoaded(request.url);
                } 
                LoadingAssets.RemoveAt(i);
                --i;
            }

            for (var i = 0; i < UnusedAssets.Count; ++i)
            {
                var request = UnusedAssets[i];
                OnAssetUnloaded(request.url);
                AssetRequests.Remove(request.url);
                UnusedAssets.RemoveAt(i);
                request.Unload();
                Log(string.Format("<color=green>UnloadAsset:{0}</color>", request.url)); 
                --i;
            }

            for (var i = 0; i < LoadingScenes.Count; ++i)
            {
                var request = LoadingScenes[i];
                if (request.Update())
                {
                    continue;
                }

                LoadingScenes.RemoveAt(i);
                if (!string.IsNullOrEmpty(request.error))
                {
                    Debug.LogError(string.Format("加载失败：{0}({1})", request.url, request.error));
                    request.Release();
                }
                else
                {
                    SceneRequests.Add(request);
                    OnAssetLoaded(request.url);
                } 
                --i;
            }

            for (var i = 0; i < SceneRequests.Count; ++i)
            {
                var request = SceneRequests[i];
                if (!request.IsUnused())
                    continue;
                SceneRequests.RemoveAt(i); 
                Log(string.Format("<color=green>UnloadScene:{0}</color>", request.url));
                OnAssetUnloaded(request.url);
                request.Unload();
                RemoveUnusedAssets();
                --i;
            }
        }

        public static string DumpAssets()
        {
            var sb = new StringBuilder();
            if (_runningScene != null)
            {
                sb.AppendLine("Scene:" + _runningScene.name); 
                sb.AppendLine("Additive:" + _runningScene.additives.Count);
                foreach (var additive in _runningScene.additives)
                {
                    if (additive.IsUnused())
                    {
                        continue;
                    }
                    sb.AppendLine("\t" + additive.name); 
                }
            } 
            sb.AppendLine("Asset:" + AssetRequests.Count);
            foreach (var request in AssetRequests)
            {
                sb.AppendLine("\t" + request.Key);
            }
            sb.AppendLine("Bundle:" + BundleRequests.Count); 
            foreach (var request in BundleRequests)
            {
                sb.AppendLine("\t" + request.Key);
            }
            return sb.ToString();
        }

        private static void ApplicationOnLowMemory()
        {
            RemoveUnusedAssets();
        }

        private static void OnAssetLoaded(string path)
        { 
            if (onAssetLoaded != null)
                onAssetLoaded(path);
        }

        private static void OnAssetUnloaded(string path)
        {
            if (onAssetUnloaded != null)
                onAssetUnloaded(path);
        }

        private static void AddRequest(AssetRequest request, bool load = true)
        {
            AssetRequests.Add(request.url, request);
            LoadingAssets.Add(request);
            if (load)
                request.Load();
        }

        private static AssetRequest LoadAsset(string path, Type type, bool async)
        {
            Assert.IsNotNull(path, "path != null");

            var isWebURL = path.StartsWith("http://", StringComparison.Ordinal) ||
                           path.StartsWith("https://", StringComparison.Ordinal) ||
                           path.StartsWith("file://", StringComparison.Ordinal) ||
                           path.StartsWith("ftp://", StringComparison.Ordinal) ||
                           path.StartsWith("jar:file://", StringComparison.Ordinal);

            string assetBundleName = null;
            if (!isWebURL)
            {
                path = GetSearchPath(path, out assetBundleName);
            }
            
            AssetRequest request;
            if (AssetRequests.TryGetValue(path, out request))
            {
                request.Retain();
                if (!LoadingAssets.Contains(request))
                {
                    LoadingAssets.Add(request);
                }

                return request;
            }

            if (! string.IsNullOrEmpty(assetBundleName))
            {
                request = async
                    ? new BundleAssetAsyncRequest(assetBundleName)
                    : new BundleAssetRequest(assetBundleName);
            }
            else
            {
                request = isWebURL ? new WebAssetRequest() : new AssetRequest();
            }

            Log(string.Format("<color=red>LoadAsset:{0}</color>", path));
            request.name = path;
            request.url = path;
            request.assetType = type;
            AddRequest(request);
            request.Retain();
            return request;
        }

        #endregion

        #region Paths

        private static string _platform;
        private static string _localProtocol;

        private static string GetSearchPath(string path, out string assetBundleName)
        {
            if (AssetToBundles.TryGetValue(path, out assetBundleName))
                return path;

            if (searchPaths != null)
            {
                foreach (var item in searchPaths)
                {
                    var existPath = string.Format("{0}/{1}", item, path);
                    if (development && File.Exists(existPath))
                    {
                        return existPath;
                    }

                    if (AssetToBundles.TryGetValue(existPath, out assetBundleName))
                        return existPath;
                }
            }

            return path;
        }

        public static string GetAssetsPath(string path)
        {
            var actualPath = Application.persistentDataPath;
            actualPath = Path.Combine(actualPath, Bundles);
            actualPath = Path.Combine(actualPath, path);
            if (File.Exists(actualPath))
            {
                return actualPath.Replace("\\", "/");
            }

            return Path.Combine(Application.dataPath, path).Replace("\\", "/");
        }

        #endregion

        #region BundleRequests

        private static readonly int MAX_BUNDLES_PERFRAME = 10;

        private static readonly Dictionary<string, BundleRequest> BundleRequests =
            new Dictionary<string, BundleRequest>();

        private static readonly List<BundleRequest> LoadingBundles = new List<BundleRequest>();

        private static readonly List<BundleRequest> UnusedBundles = new List<BundleRequest>();

        private static readonly List<BundleRequest> ToloadBundles = new List<BundleRequest>();

        private static readonly List<BundleRequest> LoadedBundles = new List<BundleRequest>();

        private static readonly List<string> ActiveVariants = new List<string>();

        private static readonly Dictionary<string, string> AssetToBundles = new Dictionary<string, string>();

        private static readonly Dictionary<string, string[]> BundleToChildren = new Dictionary<string, string[]>();

        private static string[] GetChildren(string bundle)
        {
            string[] deps;
            if (BundleToChildren.TryGetValue(bundle, out deps))
                return deps;

            return new string[0];
        }

        internal static BundleRequest LoadBundle(string assetBundleName)
        {
            return LoadBundle(assetBundleName, false);
        }

        internal static BundleRequest LoadBundleAsync(string assetBundleName)
        {
            return LoadBundle(assetBundleName, true);
        }

        internal static void UnloadBundle(BundleRequest bundle)
        {
            bundle.Release();
        } 

        private static void UnloadChildren(BundleRequest bundle)
        {
            for (var i = 0; i < bundle.children.Count; i++)
            {
                var item = bundle.children[i];
                item.Release();
            }

            bundle.children.Clear();
        }

        private static void LoadChildren(BundleRequest bundle, string assetBundleName, bool asyncRequest)
        {
            var dependencies = GetChildren(assetBundleName);
            if (dependencies.Length <= 0)
                return;
            for (var i = 0; i < dependencies.Length; i++)
            {
                var item = dependencies[i];
                bundle.children.Add(LoadBundle(item, asyncRequest));
            }
        }

        internal static BundleRequest LoadBundle(string assetBundleName, bool asyncMode)
        {
            if (string.IsNullOrEmpty(assetBundleName))
            {
                Debug.LogError("bundle == null");
                return null;
            }

            assetBundleName = RemapVariantName(assetBundleName);
            var url = GetDataPath(assetBundleName) + assetBundleName;

            BundleRequest bundle; 
            
            if (BundleRequests.TryGetValue(assetBundleName, out bundle))
            { 
                bundle.Retain();
                // LoadingBundles.Add(bundle);
                return bundle;
            }

            if (url.StartsWith("http://", StringComparison.Ordinal) ||
                url.StartsWith("https://", StringComparison.Ordinal) ||
                url.StartsWith("file://", StringComparison.Ordinal) ||
                url.StartsWith("ftp://", StringComparison.Ordinal))
                bundle = new WebBundleRequest();
            else
                bundle = asyncMode ? new BundleAsyncRequest() : new BundleRequest();

            bundle.url = url;
            bundle.name = assetBundleName;

            BundleRequests.Add(assetBundleName, bundle);

            if (MAX_BUNDLES_PERFRAME > 0 && (bundle is BundleAsyncRequest || bundle is WebBundleRequest))
            {
                ToloadBundles.Add(bundle);
            }
            else
            {
                bundle.Load();
                LoadingBundles.Add(bundle);
                Log("LoadBundle: " + url);
            }

            LoadChildren(bundle, assetBundleName, asyncMode);

            bundle.Retain();
            return bundle;
        }

        private static string GetDataPath(string bundleName)
        {
            if (string.IsNullOrEmpty(updatePath))
                return basePath;
            if (File.Exists(updatePath + bundleName))
                return updatePath;

            if (serverVersions != null)
            {
                var server = serverVersions.GetBundle(bundleName);
                if (server != null)
                {
                    var local = localVersions.GetBundle(bundleName);
                    if (local != null)
                    {
                        if (!local.Equals(server))
                        {
                            return GetDownloadURL(string.Empty);
                        }
                    }
                }
            }

            return basePath;
        }

        private static void UpdateBundles()
        {
            var max = MAX_BUNDLES_PERFRAME;
            if (ToloadBundles.Count > 0 && max > 0 && LoadingBundles.Count < max)
                for (var i = 0; i < Math.Min(max - LoadingBundles.Count, ToloadBundles.Count); ++i)
                {
                    var item = ToloadBundles[i];
                    if (item.loadState == LoadState.Init)
                    {
                        item.Load();
                        LoadingBundles.Add(item);
                        ToloadBundles.RemoveAt(i);
                        --i;
                    }
                }

            for (var i = 0; i < LoadingBundles.Count; ++i)
            {
                var item = LoadingBundles[i];
                if (item.Update())
                    continue;
                LoadingBundles.RemoveAt(i);
                if (!LoadedBundles.Contains(item))
                {
                    LoadedBundles.Add(item);
                } 
                --i;
            }

            for (var i = 0; i < LoadedBundles.Count; ++i)
            {
                var item = LoadedBundles[i];
                if (item.IsUnused())
                {
                    UnusedBundles.Add(item);
                    LoadedBundles.RemoveAt(i);
                    --i;
                }
            }

            for (var i = 0; i < UnusedBundles.Count; ++i)
            {
                var item = UnusedBundles[i];
                BundleRequests.Remove(item.name);
                UnloadChildren(item);
                item.Unload();
                Log("UnloadBundle: " + item.url);
                UnusedBundles.RemoveAt(i);
                --i;
            }
        }

        private static string RemapVariantName(string bundle)
        {
            var bundlesWithVariant = ActiveVariants;
            // Get base bundle path
            var baseName = bundle.Split('.')[0];

            var bestFit = int.MaxValue;
            var bestFitIndex = -1;
            // Loop all the assetBundles with variant to find the best fit variant assetBundle.
            for (var i = 0; i < bundlesWithVariant.Count; i++)
            {
                var curSplit = bundlesWithVariant[i].Split('.');
                var curBaseName = curSplit[0];
                var curVariant = curSplit[1];

                if (curBaseName != baseName)
                    continue;

                var found = bundlesWithVariant.IndexOf(curVariant);

                // If there is no active variant found. We still want to use the first
                if (found == -1)
                    found = int.MaxValue - 1;

                if (found >= bestFit)
                    continue;
                bestFit = found;
                bestFitIndex = i;
            }

            if (bestFit == int.MaxValue - 1)
                Debug.LogWarning(
                    "Ambiguous asset bundle variant chosen because there was no matching active variant: " +
                    bundlesWithVariant[bestFitIndex]);

            return bestFitIndex != -1 ? bundlesWithVariant[bestFitIndex] : bundle;
        }

        #endregion
    }
}