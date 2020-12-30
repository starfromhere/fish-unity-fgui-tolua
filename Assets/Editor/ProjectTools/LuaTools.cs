using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.IO;
using Debug = UnityEngine.Debug;
using Newtonsoft.Json;

namespace ProjectTools
{
    public class LuaTools : UnityEditor.Editor
    {
        public static List<string> configList = new List<string>();
        private static List<string> LuaManifest = new List<string>();
        
        [MenuItem("Arthas/AB包/Copy Lua File to Tmp", false, 21)]
        public static void CopyLuaFilesToRes()
        {
            ClearAllLuaFiles();
            string destDir = Application.dataPath + "/Res" + "/Lua";
            CopyAllLuaBytesFiles(destDir);
            BuildManifestJson();
            AssetDatabase.Refresh();
            Debug.Log("Copy lua files to Res over");
        }

        static void ClearAllLuaFiles()
        {
            string osPath = Application.streamingAssetsPath + "/" + GetOS()+"/Lua";

            // TODO Delete AssertsBundle file
            if (Directory.Exists(osPath))
            {
                string[] files = Directory.GetFiles(osPath, "Lua*.dat");

                for (int i = 0; i < files.Length; i++)
                {
                    File.Delete(files[i]);
                }
            }

            string path = osPath + "/Lua";

            if (Directory.Exists(path))
            {
                Directory.Delete(path, true);
            }

            path = Application.streamingAssetsPath + "/Lua";

            if (Directory.Exists(path))
            {
                Directory.Delete(path, true);
            }

            if (Directory.Exists(osPath))
            {
                Directory.Delete(osPath, true);
            }

            path = Application.dataPath + "/temp";

            if (Directory.Exists(path))
            {
                Directory.Delete(path, true);
            }

            path = Application.dataPath + "/Resources/Lua";

            if (Directory.Exists(path))
            {
                Directory.Delete(path, true);
            }
            
            path = Application.dataPath + "/Res/Lua";

            if (Directory.Exists(path))
            {
                Directory.Delete(path, true);
            }

            path = Application.persistentDataPath + "/" + GetOS() + "/Lua";

            if (Directory.Exists(path))
            {
                Directory.Delete(path, true);
            }
        }

        static string GetOS()
        {
            return LuaConst.osDir;
        }
        
        static void CopyAllLuaBytesFiles(string destDir)
        {
            CopyLuaBytesFiles(LuaConst.luaDir, destDir);
            CopyLuaBytesFiles(LuaConst.toluaDir, destDir);
            AssetDatabase.Refresh();
        }
        
        static void CopyLuaBytesFiles(string sourceDir, string destDir, bool appendext = true, string searchPattern = "*.lua", SearchOption option = SearchOption.AllDirectories)
        {
            if (!Directory.Exists(sourceDir))
            {
                return;
            }

            string[] files = Directory.GetFiles(sourceDir, searchPattern, option);
            int len = sourceDir.Length;

            if (sourceDir[len - 1] == '/' || sourceDir[len - 1] == '\\')
            {
                --len;
            }         

            for (int i = 0; i < files.Length; i++)
            {
                string str = files[i].Remove(0, len + 1);
                string dest = destDir + "/" + str;
                if (appendext) dest += ".bytes";
                string dir = Path.GetDirectoryName(dest);
                if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);            
                File.Copy(files[i], dest, true);
                
                string realPath = dest.Replace(Application.dataPath, "");
                LuaManifest.Add(realPath);
                Debug.Log(string.Format("LuaSearchPath: {0}", realPath));
            }
            
            Debug.Log(string.Format("copy {0} \n to {1}", sourceDir, destDir));
        }
        
        static void BuildManifestJson()
        {
            if (LuaManifest != null && LuaManifest.Count > 0)
            {
                string configJsonInfo = JsonConvert.SerializeObject(LuaManifest);
                string directoryPath = string.Format("{0}/Res/Configs", Application.dataPath);
                string configJsonPath = directoryPath + "/LuaManifest.json";
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }
                
                if (File.Exists(configJsonPath))
                {
                    File.Delete(configJsonPath);
                }
                File.WriteAllText(configJsonPath, configJsonInfo);
            }
        }
    }
}