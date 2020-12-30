//
// BuildScript.cs
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
using UnityEditor;
using UnityEditor.Build;
using UnityEngine;

namespace libx
{
    public class BuildScript : IPreprocessBuild
    {
//        internal static readonly string outputPath = Assets.Bundles + "/" + GetPlatformName();
        public static string _outputPath;

        public static string outputPath
        {
            get
            {
                if (_outputPath == null)
                {
                    outputPath = string.Format("{0}/{1}/{2}",
                        Assets.Bundles,
                        GetBuildRules().GetVersion().Replace('.','_'),
                        GetPlatformName());
                }
                return _outputPath;
            }
            set { _outputPath = value; }
        }

        public static void ClearAssetBundles()
        {
            var names = AssetDatabase.GetAllAssetBundleNames();
            for (var i = 0; i < names.Length; i++)
            {
                var text = names[i];
                if (EditorUtility.DisplayCancelableProgressBar(
                    string.Format("Clear Bundles {0}/{1}", i, names.Length), text,
                    i * 1f / names.Length))
                    break;

                AssetDatabase.RemoveAssetBundleName(text, true);
            }

            EditorUtility.ClearProgressBar();
        }

        internal static void BuildRules()
        {
            var rules = GetBuildRules();
            rules.Build();
        }

        internal static BuildRules GetBuildRules()
        {
            return GetAsset<BuildRules>("Assets/Rules.asset");
        }

        private static string GetPlatformName()
        {
            return GetPlatformForAssetBundles(EditorUserBuildSettings.activeBuildTarget);
        }

        private static string GetPlatformForAssetBundles(BuildTarget target)
        {
            // ReSharper disable once SwitchStatementMissingSomeCases
            switch (target)
            {
                case BuildTarget.Android:
                    return "Android";
                case BuildTarget.iOS:
                    return "iOS";
                case BuildTarget.WebGL:
                    return "WebGL";
                case BuildTarget.StandaloneWindows:
                case BuildTarget.StandaloneWindows64:
                    return "Windows";
#if UNITY_2017_3_OR_NEWER
                case BuildTarget.StandaloneOSX:
                    return "OSX";
#else
                case BuildTarget.StandaloneOSXIntel:
                case BuildTarget.StandaloneOSXIntel64:
                case BuildTarget.StandaloneOSXUniversal:
                    return "OSX";
#endif
                default:
                    return null;
            }
        }

        private static string[] GetLevelsFromBuildSettings()
        {
            List<string> scenes = new List<string>();
            foreach (var item in GetBuildRules().scenesInBuild)
            {
                var path = AssetDatabase.GetAssetPath(item);
                if (!string.IsNullOrEmpty(path))
                {
                    scenes.Add(path);
                }
            }

            return scenes.ToArray();
        }

        private static string GetAssetBundleManifestFilePath()
        {
            return Path.Combine(outputPath, GetPlatformName()) + ".manifest";
        }

        public static void BuildPlayer()
        {
            var path = Path.Combine(Environment.CurrentDirectory, "Build/" + GetPlatformName());
            if (path.Length == 0)
                return;

            var levels = GetLevelsFromBuildSettings();
            if (levels.Length == 0)
            {
                Debug.Log("Nothing to build.");
                return;
            }

            var targetName = GetBuildTargetName(EditorUserBuildSettings.activeBuildTarget);
            if (targetName == null)
                return;

            var buildPlayerOptions = new BuildPlayerOptions
            {
                scenes = levels,
                locationPathName = path + targetName,
                assetBundleManifestPath = GetAssetBundleManifestFilePath(),
                target = EditorUserBuildSettings.activeBuildTarget,
                options = EditorUserBuildSettings.development ? BuildOptions.Development : BuildOptions.None
            };
            BuildPipeline.BuildPlayer(buildPlayerOptions);
        }

        private static string CreateAssetBundleDirectory()
        {
            // Choose the output build according to the build target.
            if (!Directory.Exists(outputPath))
                Directory.CreateDirectory(outputPath);

            return outputPath;
        }

        public static void BuildAssetBundles()
        {
            string filePath = Application.dataPath + "/curResVersion.txt";
            string[] versionData = new string[] {"0", "0", "0"};
            if (File.Exists(filePath))
            {
                versionData = File.ReadAllText(filePath).Split('_');
            }
            // Choose the output build according to the build target.
            var rules = GetBuildRules();
            rules.major = int.Parse(versionData[0]);
            rules.minor = int.Parse(versionData[1]);
            rules.build = int.Parse(versionData[2]);
            string ver = rules.AddVersion().Replace('.', '_');
            StreamWriter txt = File.CreateText(filePath);
            txt.Write(ver);
            txt.Close();
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            outputPath = string.Format("{0}/{1}/{2}", Assets.Bundles, ver, GetPlatformName());
            var dir = CreateAssetBundleDirectory();
            var platform = EditorUserBuildSettings.activeBuildTarget;
            var builds = rules.GetBuilds();
            var manifest = BuildPipeline.BuildAssetBundles(dir, builds, rules.options, platform);
            if (manifest == null)
            {
                return;
            }
            BuildVersions(manifest, rules);
        }

        private static void BuildVersions(AssetBundleManifest manifest, BuildRules rules)
        {
            var allBundles = manifest.GetAllAssetBundles();
            var bundle2Ids = GetBundle2Ids(allBundles);
            var bundles = GetBundles(manifest, allBundles, bundle2Ids);
            var ver = rules.GetVersion();

            var dirs = new List<string>();
            var assets = new List<AssetRef>();
            var patches = new List<Patch>();
            var asset2Bundles = new Dictionary<string, BundleRef>();
            foreach (var item in rules.assets)
            {
                var path = item.name;
                var dir = Path.GetDirectoryName(path);
                if (!string.IsNullOrEmpty(dir))
                {
                    dir = dir.Replace("\\", "/");
                }
                var index = dirs.FindIndex(o => o.Equals(dir));
                if (index == -1)
                {
                    index = dirs.Count;
                    dirs.Add(dir);
                }
                var asset = new AssetRef();
                if (item.groupBy == GroupBy.None)
                {
                    AddBundle(path, asset, ref bundles);
                }
                bundle2Ids.TryGetValue(item.bundle, out asset.bundle);
                asset.dir = index;
                asset.name = Path.GetFileName(path);
                asset2Bundles[path] = bundles[asset.bundle];
                assets.Add(asset);
            }

            Func<List<string>, List<int>> getFiles = delegate (List<string> list)
            {
                var ret = new List<int>();
                foreach (var file in list)
                {
                    BundleRef bundle;
                    asset2Bundles.TryGetValue(file, out bundle);
                    if (bundle != null)
                    {
                        if (!ret.Contains(bundle.id))
                        {
                            ret.Add(bundle.id);
                        }
                        foreach (var child in bundle.children)
                        {
                            if (!ret.Contains(child))
                            {
                                ret.Add(child);
                            }
                        }
                    }
                    else
                    {
                        Debug.LogWarning("bundle == nil, file:" + file);
                    }
                }
                return ret;
            };

            for (var i = 0; i < rules.patches.Count; i++)
            {
                var item = rules.patches[i];
                patches.Add(new Patch
                {
                    name = item.name,
                    files = getFiles(item.assets),
                });
            }

            var versions = new Versions();
            if (!rules.allAssetsToBuild)
            {
                versions.patchesInBuild.AddRange(rules.patchesInBuild);
            }
            versions.activeVariants = manifest.GetAllAssetBundlesWithVariant();
            versions.dirs = dirs.ToArray();
            versions.assets = assets;
            versions.bundles = bundles;
            versions.patches = patches;
            versions.ver = ver;
            Debug.Log("show version ver info: " + ver);
            versions.Save(outputPath + "/" + Assets.Versions);
        }

        private static void AddBundle(string path, AssetRef asset, ref List<BundleRef> bundles)
        {
            var bundleName = path.Replace("Assets/", "");
            var destFile = Path.Combine(outputPath, bundleName);
            var destDir = Path.GetDirectoryName(destFile);
            if (!Directory.Exists(destDir) && !string.IsNullOrEmpty(destDir))
            {
                Directory.CreateDirectory(destDir);
            }
            File.Copy(path, destFile, true);
            using (var stream = File.OpenRead(destFile))
            {
                var bundle = new BundleRef
                {
                    name = bundleName,
                    id = bundles.Count,
                    len = stream.Length,
                    crc = Utility.GetCRC32Hash(stream),
                    hash = string.Empty
                };
                asset.bundle = bundles.Count;
                bundles.Add(bundle);
            }
        }

        private static List<BundleRef> GetBundles(AssetBundleManifest manifest,
            IEnumerable<string> allBundles,
            IDictionary<string, int> bundle2Ids)
        {
            var bundles = new List<BundleRef>();
            foreach (var bundle in allBundles)
            {
                var children = manifest.GetAllDependencies(bundle);
                var path = string.Format("{0}/{1}", outputPath, bundle);
                if (File.Exists(path))
                {
                    using (var stream = File.OpenRead(path))
                    {
                        bundles.Add(new BundleRef
                        {
                            id = bundle2Ids[bundle],
                            name = bundle,
                            children = Array.ConvertAll(children, input => bundle2Ids[input]),
                            len = stream.Length,
                            hash = manifest.GetAssetBundleHash(bundle).ToString(),
                            crc = Utility.GetCRC32Hash(stream)
                        });
                    }
                }
                else
                {
                    Debug.LogError(path + " file not exist.");
                }
            }

            return bundles;
        }

        private static Dictionary<string, int> GetBundle2Ids(string[] bundles)
        {
            var bundle2Ids = new Dictionary<string, int>();
            for (var index = 0; index < bundles.Length; index++)
            {
                var bundle = bundles[index];
                bundle2Ids[bundle] = index;
            }
            return bundle2Ids;
        }

        private static string GetBuildTargetName(BuildTarget target)
        {
            var time = DateTime.Now.ToString("yyyyMMdd-HHmmss");
            var name = PlayerSettings.productName + "-v" + PlayerSettings.bundleVersion + ".";
            switch (target)
            {
                case BuildTarget.Android:
                    return string.Format("/{0}{1}-{2}.apk", name, GetBuildRules().GetVersion(), time);

                case BuildTarget.StandaloneWindows:
                case BuildTarget.StandaloneWindows64:
                    return string.Format("/{0}{1}-{2}.exe", name, GetBuildRules().GetVersion(), time);

#if UNITY_2017_3_OR_NEWER
                case BuildTarget.StandaloneOSX:
                    return "/" + name + ".app";

#else
                case BuildTarget.StandaloneOSXIntel:
                case BuildTarget.StandaloneOSXIntel64:
                case BuildTarget.StandaloneOSXUniversal:
                    return "/" + build + ".app";

#endif

                case BuildTarget.WebGL:
                case BuildTarget.iOS:
                    return "";
                // Add more build targets for your own.
                default:
                    Debug.Log("Target not implemented.");
                    return null;
            }
        }

        public static T GetAsset<T>(string path) where T : ScriptableObject
        {
            var asset = AssetDatabase.LoadAssetAtPath<T>(path);
            if (asset == null)
            {
                asset = ScriptableObject.CreateInstance<T>();
                AssetDatabase.CreateAsset(asset, path);
                AssetDatabase.SaveAssets();
            }

            return asset;
        }

        public int callbackOrder
        {
            get { return 0; }
        }

        public void OnPreprocessBuild(BuildTarget target, string path)
        {
            ResetScenes();
            if (Assets.enableCopyAssets)
            {
                CopyAssets();
            }
        }

        private static void ResetScenes()
        {
            var levels = GetLevelsFromBuildSettings();
            var scenes = new EditorBuildSettingsScene[levels.Length];
            for (var index = 0; index < levels.Length; index++)
            {
                var asset = levels[index];
                scenes[index] = new EditorBuildSettingsScene(asset, true);
            }
            EditorBuildSettings.scenes = scenes;
        }

        public static void CopyAssets()
        {
            var dir = Application.streamingAssetsPath + "/" + Assets.Bundles;
            if (Directory.Exists(dir))
            {
                Directory.Delete(dir, true);
            }
            Directory.CreateDirectory(dir);
            Debug.Log("show outputpath: " + outputPath);
            var sourceDir = outputPath;
            var versions = Assets.LoadVersions(Path.Combine(sourceDir, Assets.Versions));
            var bundles = new List<BundleRef>();
            var rules = GetBuildRules();
            if (!rules.allAssetsToBuild)
            {
                var patches = rules.patchesInBuild;
                foreach (var patch in patches)
                {
                    var files = versions.GetFiles(patch);
                    foreach (var file in files)
                    {
                        if (!bundles.Exists(x => x.name.Equals(file.name)))
                        {
                            bundles.Add(file);
                        }
                    }
                }
            }
            else
            {
                bundles.AddRange(versions.bundles);
            }
            foreach (var file in bundles)
            {
                var destFile = Path.Combine(dir, file.name);
                var destDir = Path.GetDirectoryName(destFile);
                if (!Directory.Exists(destDir) && !string.IsNullOrEmpty(destDir))
                {
                    Directory.CreateDirectory(destDir);
                }
                File.Copy(Path.Combine(sourceDir, file.name), destFile);
            }
            File.Copy(Path.Combine(sourceDir, Assets.Versions), Path.Combine(dir, Assets.Versions));
            AssetDatabase.Refresh();
        }

        public static void ViewVersions()
        {
            var versions = Assets.LoadVersions(Path.Combine(outputPath, Assets.Versions));
            var txt = "versions.txt";
            File.WriteAllText(txt, versions.ToString());
            EditorUtility.OpenWithDefaultApp(txt);
        }

        public static void ClearManifestFile()
        {
            string path = Path.Combine(System.Environment.CurrentDirectory, outputPath);
            DirectoryInfo TheFolder = new DirectoryInfo(path);
            float p = 0.2f;
            //遍历文件夹
            foreach (FileInfo NextFile in TheFolder.GetFiles())
            {
                if (NextFile.Name.EndsWith(".manifest"))
                {
                    p = p > 1.0f ? 0.2f : (p + 0.2f);
                    // Debug.Log("clear file name: "+ NextFile.Name);
                    EditorUtility.DisplayProgressBar("清理manifest", NextFile.Name, p);
                    NextFile.Delete();
                }
            }

            EditorUtility.ClearProgressBar();
        }
    }
}