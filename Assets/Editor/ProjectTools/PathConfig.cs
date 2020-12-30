using UnityEditor;
using System.Collections.Generic;
using UnityEngine;

namespace ProjectTools
{
    [InitializeOnLoad]
    public class PathConfig : EditorWindow
    {
        private Vector2 _scrollViewVector;
        private List<string> keys;

        private static Dictionary<string, string> _pathDic = new Dictionary<string, string>()
        {
            // 配置成 本地可用的路径
            {BUNDLE_OUTPUT_PATH, Application.dataPath+"/Build/Unity_Fish"},
            {APK_OUTPUT_PATH, Application.dataPath+"/Build/Android"},
        };

        public const string BUNDLE_OUTPUT_PATH = "bundle_output_path";
        public const string APK_OUTPUT_PATH = "apk_output_path";

        [MenuItem("Arthas/PathConfig", false, 0)]
        private static void _refreshConfig()
        {
            PathConfig refreshWindow = GetWindow<PathConfig>();
            refreshWindow.Show();
        }

        private static void _checkPathConfig(bool isShowDialog = true)
        {
            if (!isShowDialog) return;
            foreach (KeyValuePair<string, string> info in _pathDic)
            {
                string path = PlayerPrefs.GetString(info.Key);
                if (path.Length <= 0)
                {
                    PlayerPrefs.SetString(info.Key, info.Value);
                }
            }
        }

        private void OnDestroy()
        {
            _checkPathConfig(false);
        }

        static PathConfig()
        {
            _checkPathConfig();
        }

        private void Awake()
        {
            _checkPathConfig();
            _initPath();
        }

        /// <summary>
        /// 获取各种配置表路径
        /// </summary>
        /// <param name="configKey">配置表路径Key</param>
        /// <returns></returns>
        public static string GetPath(string configKey)
        {
            string pathTemp = PlayerPrefs.GetString(configKey, string.Empty);
            if (string.IsNullOrEmpty(pathTemp))
            {
                EditorUtility.DisplayDialog("路径错误", string.Format("{0}路径未配置", configKey), "Ok");
            }

            return pathTemp;
        }

        private void _initPath()
        {
            keys = new List<string>(_pathDic.Keys);
            for (int i = 0; i < keys.Count; i++)
            {
                _pathDic[keys[i]] = PlayerPrefs.GetString(keys[i]);
            }
        }

        private void _savePath()
        {
            foreach (KeyValuePair<string, string> info in _pathDic)
            {
                PlayerPrefs.SetString(info.Key, info.Value);
            }
        }

        private void OnGUI()
        {
            _scrollViewVector = EditorGUILayout.BeginScrollView(_scrollViewVector);
            for (int i = 0; i < keys.Count; i++)
            {
                _pathDic[keys[i]] = EditorGUILayout.TextField(keys[i], _pathDic[keys[i]]);
            }

            if (GUILayout.Button("Save"))
            {
                _savePath();
            }

            EditorGUILayout.EndScrollView();
        }
    }
}