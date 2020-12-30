using UnityEngine;
using UnityEditor;
using Object = UnityEngine.Object;
using Debug = UnityEngine.Debug;

namespace ProjectTools
{
    // TODO 待优化 ， 需要将代码写死内容提出来重新封装好
    public class AssetsBundleTools: UnityEditor.Editor
    {
        [MenuItem("Arthas/AB包/打包选中的资源(.PC)", false,11)]
        static void PrefabsBuilding ()
        {
            Object[] selection = Selection.GetFiltered(typeof(Object),SelectionMode.DeepAssets);
            if (selection.Length <= 0)
                return;
            string path = EditorUtility.SaveFilePanel("另存为",Application.streamingAssetsPath+"/data",selection[0].name,"dat");
            if(path.Length != 0)
            {
                BuildPipeline.BuildAssetBundle(Selection.activeObject,selection,path,BuildAssetBundleOptions.CollectDependencies | BuildAssetBundleOptions.CompleteAssets,BuildTarget.StandaloneWindows);
                Debug.Log("PC .dat文件导出完成");
            }

            AssetDatabase.LoadAssetAtPath("", typeof(GameObject));
        }

        [MenuItem("Arthas/AB包/打包选中的资源(.Android)", false, 12)]
        static void AndroBuilding ()
        {
            Object[] selection = Selection.GetFiltered(typeof(Object),SelectionMode.DeepAssets);
            if (selection.Length <= 0)
                return;
            string path = EditorUtility.SaveFilePanel("另存为",Application.streamingAssetsPath+"/data",selection[0].name,"dat");
            if(path.Length != 0)
            {
                BuildPipeline.BuildAssetBundle(Selection.activeObject,selection,path,BuildAssetBundleOptions.CollectDependencies | BuildAssetBundleOptions.CompleteAssets,BuildTarget.Android);
                Debug.Log("Android .dat文件导出完成");
            }

        }

        [MenuItem("Arthas/AB包/打包选中的资源(.IOS)", false, 13)]
        static void IOSBuilding ()
        {
            Object[] selection = Selection.GetFiltered(typeof(Object),SelectionMode.DeepAssets);
            if (selection.Length <= 0)
                return;

            string path = EditorUtility.SaveFilePanel("另存为", Application.streamingAssetsPath + "/data", selection[0].name, "dat");
            if(path.Length != 0)
            {
                BuildPipeline.BuildAssetBundle(Selection.activeObject,selection,path,BuildAssetBundleOptions.CollectDependencies | BuildAssetBundleOptions.CompleteAssets,BuildTarget.iOS);
                Debug.Log("IOS .dat文件导出完成");
            }
        }
    }
}