using System;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
using Newtonsoft.Json;
using UnityEngine;

namespace Arthas
{
    public class StartGame : MonoBehaviour, IUpdater
    {
        private TextAsset _luaManifesTextAsset = null;
        private List<string> _luaManifest = null;
        private List<libx.AssetRequest> _requests = new List<libx.AssetRequest> ();
        private int _progressIndex = 0;
        
        private void Awake()
        {
#if !UNITY_EDITOR
            Application.targetFrameRate = 60;
#endif
            StartCoroutine(LoadAsset());
            OnMessage("正在初始化资源列表");
        }

        IEnumerator LoadAsset()
        {
            yield return true;
#if !UNITY_EDITOR
            LuaFileUtils.Instance.beZip = true;
            _luaManifesTextAsset = libx.Assets.LoadAsset("Assets/Res/Configs/LuaManifest.json", typeof(UnityEngine.TextAsset)).asset as TextAsset;
            _luaManifest = JsonConvert.DeserializeObject<List<string>>(_luaManifesTextAsset.text);
            StartCoroutine(LoadAllLuaFile(_luaManifest.Count));
            Debug.Log("加载 lua 资源完成！");
#else
            LuaLoadEnd();
#endif
        }
        
        IEnumerator LoadAllLuaFile(int size)
        {
            int count = 0;
            List<libx.AssetRequest> list = new List<libx.AssetRequest> ();
            for (int i = 0; i < _luaManifest.Count; ++i)
            {
                if (count >= size) break;
                string filepath = "Assets"+_luaManifest[i];
                libx.AssetRequest request = LoadLuaFile(filepath);
                request.extensionName = _luaManifest[i].Replace("/Res/Lua/", "")
                                                        .Replace(".bytes", "");
                request.extensionName = request.extensionName.Replace('/', '.');
                request.completed += OnCompleted;
                ++count;
                _progressIndex = count;
            }
            
            yield return new WaitUntil (() => list.TrueForAll (o => {
                return o.isDone;
            }));
            
            LuaLoadEnd();
        }
        
        private void LuaLoadEnd()
        {
            gameObject.AddComponent<GameEntry>();
        }

        private libx.AssetRequest LoadLuaFile(string path)
        {
            var request = libx.Assets.LoadAsset(path, typeof(TextAsset));
            _requests.Add (request);
            return request;
        }
        
        private void OnCompleted (libx.AssetRequest request)
        {
            if (!string.IsNullOrEmpty (request.error)) {
                request.Release ();
                return;
            }

            var text = request.asset as TextAsset;
            // Debug.Log("加载的text名称： "+ request.extensionName +"\n"+text.text);
            LuaFileUtils.Instance.AddSearchFile(request.extensionName, text);
            OnProgress(_progressIndex/_luaManifest.Count);
        }
        
        
        #region IUpdateManager implementation
        public IUpdater listener { get; set; }

        public void OnMessage(string msg)
        {
            if (listener != null)
            {
                listener.OnMessage(msg);
            }
        }

        public void OnProgress(float progress)
        {
            if (listener != null)
            {
                listener.OnProgress(progress);
            }
        }

        public void OnClear()
        {
            OnMessage("数据清除完毕");
            OnProgress(0);
            if (listener != null)
            {
                listener.OnClear();
            }
        }

        public void OnUpdateApk(string msg)
        {
            
        }

        #endregion
    }
}