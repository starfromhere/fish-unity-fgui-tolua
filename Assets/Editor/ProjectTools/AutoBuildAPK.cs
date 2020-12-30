using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using System.IO;
using Arthas;
using libx;
using UnityEditor.Build.Reporting;
using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;

namespace ProjectTools
{
    public class AutoBuildAPK : UnityEditor.Editor
    {
        private static string appVersion = "0.0.1";

        private static string GetScenePath(string sceneName, string scenePath = "Assets/Src/Scenes/")
        {
            return Path.Combine(scenePath, sceneName + ".unity");
        }

        [MenuItem("Build/Build Bundles")]
        public static void ArthasBuildBundles()
        {
            // libx.Assets.enableCopyAssets = true;
            // LuaTools.CopyLuaFilesToRes();
            // BuildProfileInfo.SetAssetsGroupBy();
            // AssetDatabase.Refresh();
            // libx.MenuItems.BuildBundles();
            // AssetDatabase.Refresh();
        }

        [MenuItem("Build/安卓热更包（需要配置好打包规则）")]
        public static void BuildHotPackageAndroid()
        {
            //TODO 勾选PlayerSettings中的dynamicBatching 
            string apkname = "fish3_Android.apk";
            string ios_project_path = Path.Combine(PathConfig.GetPath(PathConfig.APK_OUTPUT_PATH), apkname);
            BuildProfileInfo.SetAndroidProjectSetting();
            BuildPlayerOptions buildPlayerOptions = new BuildPlayerOptions();
            if (IsLocalResources())
            {
                PlayerSettings.applicationIdentifier = "com.jjhgame.fish3";
                PlayerSettings.productName = "localFish";
            }
            else
            {
                PlayerSettings.applicationIdentifier = "com.jjhgame.fish31";
                PlayerSettings.productName = "fish";
            }
            BuildProfileInfo.WriteXMLApplicationIdentifier();
            PlayerSettings.bundleVersion = appVersion;
            buildPlayerOptions.locationPathName = ios_project_path;
            buildPlayerOptions.target = BuildTarget.Android;
            buildPlayerOptions.options = BuildOptions.None;

            ArthasBuildBundles();
            BuildReport report = BuildPipeline.BuildPlayer(buildPlayerOptions);
            BuildSummary summary = report.summary;

            if (summary.result == BuildResult.Succeeded)
            {
                Debug.Log("Build succeeded: " + summary.totalSize + " bytes   output_path: " + ios_project_path);
            }

            if (summary.result == BuildResult.Failed)
            {
                Debug.Log("Build failed");
            }
        }

        [MenuItem("Build/ios热更包（需要配置好打包规则）")]
        public static void BuildHotPackageIOS()
        {
            //TODO 勾选PlayerSettings中的dynamicBatching 
            string apkname = "fish3_ios";
            string ios_project_path = Path.Combine(PathConfig.GetPath(PathConfig.APK_OUTPUT_PATH), apkname);
            BuildProfileInfo.SetIOSProjectSetting();
            BuildPlayerOptions buildPlayerOptions = new BuildPlayerOptions();

            if (IsLocalResources())
            {
                PlayerSettings.applicationIdentifier = "com.jjhgame.fish3";
                PlayerSettings.productName = "localFish";
            }
            else
            {
                PlayerSettings.applicationIdentifier = "com.jjhgame.fish31";
                PlayerSettings.productName = "fish";
            }

            PlayerSettings.bundleVersion = appVersion;
            buildPlayerOptions.locationPathName = ios_project_path;
            buildPlayerOptions.target = BuildTarget.iOS;
            buildPlayerOptions.options = BuildOptions.None;

            ArthasBuildBundles();

            BuildReport report = BuildPipeline.BuildPlayer(buildPlayerOptions);
            BuildSummary summary = report.summary;

            if (summary.result == BuildResult.Succeeded)
            {
                Debug.Log("Build succeeded: " + summary.totalSize + " bytes   output_path: " + ios_project_path);
            }

            if (summary.result == BuildResult.Failed)
            {
                Debug.Log("Build failed");
            }
        }

        public static bool IsLocalResources()
        {
            Scene FirstScene  = EditorSceneManager.OpenScene(GetScenePath("Init"));
            GameObject[] objs = FirstScene.GetRootGameObjects();       // 获取组件 BaseCompoent
            GameObject obj = objs[0];
            string downloadURL = obj.gameObject.GetComponent<ArthasInitializer>().downloadURL;
            if (downloadURL == "https://cdn-byh5.jjhgame.com/Unity_Fish/")
            {
                return false;
            }
            return true;
        }

        public static void EnableCopyAssets()
        {
            // true 拷贝资源到StreamingAssets目录下， false则不拷贝
            libx.Assets.enableCopyAssets = true;
            // libx.Assets.enableCopyAssets = false;
        }
    }
}