using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using System.IO;
using System.Xml;
using libx;
using UnityEditor.Rendering;
using UnityEngine.Rendering;

namespace ProjectTools
{
    public class RulesProfile
    {
        public string _patch = "Init";
        public string _path;
        public GroupBy _groupBy = GroupBy.Filename;
        public string _bundle = string.Empty;

        public RulesProfile(string patch, string path, GroupBy groupBy, string bundle)
        {
            this._patch = path;
            this._path = path;
            this._groupBy = groupBy;
            this._bundle = bundle;
        }
    }

    public class BuildProfileInfo : UnityEditor.Editor
    {
        private static string _rulesPath = "Assets/Rules.asset";

        private static Dictionary<int, RulesProfile> _apkProfiles = new Dictionary<int, RulesProfile>()
        {
            {1, new RulesProfile("Init", "Assets/Src/Scenes/StartGameScene.unity", GroupBy.Filename, string.Empty)},
            {2, new RulesProfile("Init", "Assets/Src/Scenes/EnterGameScene.unity", GroupBy.Filename, string.Empty)},
            {3, new RulesProfile("Init", "Assets/Src/Scenes/Init.unity", GroupBy.Filename, string.Empty)},
        };


        private static Dictionary<int, RulesProfile> _proFilePath = new Dictionary<int, RulesProfile>()
        {
            {1, new RulesProfile("Init", "Assets/Src/Scenes/StartGameScene.unity", GroupBy.Filename, string.Empty)},
            {2, new RulesProfile("Init", "Assets/Src/Scenes/EnterGameScene.unity", GroupBy.Filename, string.Empty)},
            {3, new RulesProfile("Init", "Assets/Src/Scenes/Init.unity", GroupBy.Filename, string.Empty)},
            {4, new RulesProfile("Init", Application.dataPath + "/Res/3d", GroupBy.Filename, string.Empty)},
            {5, new RulesProfile("Init", Application.dataPath + "/Res/Configs", GroupBy.Filename, string.Empty)},
            {6, new RulesProfile("Init", Application.dataPath + "/Res/Fonts", GroupBy.Filename, string.Empty)},
            {7, new RulesProfile("Init", Application.dataPath + "/Res/Lua", GroupBy.Filename, string.Empty)},
            {8, new RulesProfile("Init", Application.dataPath + "/Res/Materials", GroupBy.Filename, string.Empty)},
            {9, new RulesProfile("Init", Application.dataPath + "/Res/Music", GroupBy.Filename, string.Empty)},
            {10, new RulesProfile("Init", Application.dataPath + "/Res/Particle", GroupBy.Filename, string.Empty)},
            {11, new RulesProfile("Init", Application.dataPath + "/Res/Prefabs", GroupBy.Filename, string.Empty)},
            {12, new RulesProfile("Init", Application.dataPath + "/Res/Shaders", GroupBy.Explicit, "shaders")},
            {13, new RulesProfile("Init", Application.dataPath + "/Res/Spine", GroupBy.Directory, string.Empty)},
            {14, new RulesProfile("Init", Application.dataPath + "/Res/Textures", GroupBy.Filename, string.Empty)},
            {15, new RulesProfile("Init", Application.dataPath + "/Res/UI", GroupBy.Directory, string.Empty)},
        };

        public static void SetAssetsGroupBy()
        {
            var rules = AssetDatabase.LoadAssetAtPath<BuildRules>("Assets/Rules.asset");
            rules.assets = new List<AssetBuild>();
            rules.patches = new List<PatchBuild>();
            rules.bundles = new List<BundleBuild>();
            EditorBuildSettings.scenes = new UnityEditor.EditorBuildSettingsScene[]
            {
                new EditorBuildSettingsScene("Assets/Src/Scenes/Init.unity", true),
                new EditorBuildSettingsScene("Assets/Src/Scenes/EnterGameScene.unity", true),
                new EditorBuildSettingsScene("Assets/Src/Scenes/StartGameScene.unity", true),
            };
            rules.patchesInBuild = new string[1]
            {
                "EnterGameScene"
            };

            foreach (var item in _apkProfiles)
            {
                RulesProfile curInfo = item.Value;
                //替换路径中的反斜杠为正斜杠       
                string strTempPath = curInfo._path.Replace(@"\", "/");
                //截取我们需要的路径
                strTempPath = strTempPath.Substring(strTempPath.IndexOf("Assets"));
                if (string.IsNullOrEmpty(strTempPath) || Directory.Exists(strTempPath))
                {
                    continue;
                }

                rules.GroupAsset(strTempPath, curInfo._groupBy, curInfo._bundle);
            }

            foreach (var item in _proFilePath)
            {
                RulesProfile curInfo = item.Value;
                Debug.Log("-patch:---" + curInfo._patch);
                Debug.Log("-path:---" + curInfo._path);
                Debug.Log("-GroupBy:---" + curInfo._groupBy);
                //路径  

                string fullPath = curInfo._path;
                Debug.Log("-Exists:---" + Directory.Exists(fullPath));
                //获取指定路径下面的所有资源文件  
                if (Directory.Exists(fullPath))
                {
                    rules.currentScene = "Init";
                    DirectoryInfo direction = new DirectoryInfo(fullPath);
                    FileInfo[] files = direction.GetFiles("*", SearchOption.AllDirectories);
                    for (int i = 0; i < files.Length; i++)
                    {
                        FileInfo curFile = files[i];
                        //忽略关联文件
                        if (files[i].Name.EndsWith(".meta"))
                        {
                            continue;
                        }

                        //替换路径中的反斜杠为正斜杠       
                        string strTempPath = curFile.FullName.Replace(@"\", "/");
                        //截取我们需要的路径
                        strTempPath = strTempPath.Substring(strTempPath.IndexOf("Assets"));
                        if (string.IsNullOrEmpty(strTempPath) || Directory.Exists(strTempPath))
                        {
                            continue;
                        }

                        rules.GroupAsset(strTempPath, curInfo._groupBy, curInfo._bundle);
                    }
                }
                else
                {
                    //替换路径中的反斜杠为正斜杠       
                    string strTempPath = curInfo._path.Replace(@"\", "/");
                    //截取我们需要的路径
                    strTempPath = strTempPath.Substring(strTempPath.IndexOf("Assets"));
                    if (string.IsNullOrEmpty(strTempPath) || Directory.Exists(strTempPath))
                    {
                        continue;
                    }

                    rules.currentScene = "EnterGameScene";
                    rules.PatchAsset(strTempPath);
                }
            }

            EditorUtility.SetDirty(rules);
            AssetDatabase.SaveAssets();

            Debug.Log("-------SetAssetsGroupBy--------end-------");
        }

        public static void SetAndroidProjectSetting()
        {
            //TODO 勾选PlayerSettings中的dynamicBatching 没找到代码设置API 目前手动设置
            PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android,
                "FAIRYGUI_TOLUA;FAIRYGUI_TEST;UNITY_POST_PROCESSING_STACK_V2;PROJECT_DEBUG");
            //设置HDR
            TierSettings settings = new TierSettings();
            settings.standardShaderQuality = ShaderQuality.Medium;
            settings.hdr = true;
            settings.hdrMode = CameraHDRMode.R11G11B10;
            settings.renderingPath = RenderingPath.DeferredShading;
            settings.realtimeGICPUUsage = RealtimeGICPUUsage.Low;
            EditorGraphicsSettings.SetTierSettings(BuildTargetGroup.Android, GraphicsTier.Tier2, settings);
        }

        public static void SetIOSProjectSetting()
        {
            //TODO 勾选PlayerSettings中的dynamicBatching 没找到代码设置API 目前手动设置
            PlayerSettings.stripEngineCode = false;
            PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.iOS,
                "FAIRYGUI_TOLUA;FAIRYGUI_TEST;PROJECT_DEBUG");
        }

        public static void WriteXMLApplicationIdentifier()
        {
            string path = Application.dataPath + "/Plugins/Android/AndroidManifest.xml";
            if (File.Exists(path))
            {
                XmlDocument xml = new XmlDocument();
                xml.Load(path);
                XmlNodeList xmlNodeList = xml.SelectSingleNode("manifest").ChildNodes;
                foreach (XmlElement xl1 in xmlNodeList)
                {
                    if (xl1.Name == "application")
                    {
                        foreach (XmlElement xl2 in xl1)
                        {
                            if (xl2.Name == "provider")
                            {
                                xl2.SetAttribute("android:authorities",
                                    PlayerSettings.applicationIdentifier + ".fileProvider");
                                Debug.Log("======AndroidManifest.xml=========" + xl2.GetAttribute("android:authorities"));
                            }
                        }
                    }
                }
            }

            path = Application.dataPath + "/Plugins/Android/res/xml/provider_paths.xml";
            if (File.Exists(path))
            {
                XmlDocument xml = new XmlDocument();
                xml.Load(path);
                XmlNode xmlNode = xml.SelectSingleNode("resources").SelectSingleNode("paths")
                    .SelectSingleNode("external-path");
                XmlElement bookElement = (XmlElement) xmlNode;
                bookElement.SetAttribute("path",
                    "Android/data/" + PlayerSettings.applicationIdentifier + "/cache/download");
                Debug.Log("======provider_paths.xml=========" + bookElement.GetAttribute("path"));
            }
        }
    }
}