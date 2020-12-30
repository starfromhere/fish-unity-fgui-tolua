using System;
using System.Collections;
using BestHTTP;
using System.IO;
using System.Threading;
using BestHTTP.Core;
using Newtonsoft.Json.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.Networking;
using Object = System.Object;

namespace Arthas
{
    public class Updater : MonoBehaviour, IUpdater
    {
        private string _platform;
        private libx.SceneAssetRequest _scene;
        public IUpdater listener { get; set; }

        private string _apiDomain = "https://api-unity.qzygxt.com";

        public void OnMessage(string msg)
        {
            if (listener != null)
            {
                listener.OnMessage(msg);
            }
        }

        public void OnUpdateApk(string msg)
        {
            if (listener != null)
            {
                listener.OnUpdateApk(msg);
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
            Reset();
            if (listener != null)
            {
                listener.OnClear();
            }
        }

        private void Reset()
        {
        }

        private void Start()
        {
            Game.Instance.Init();
#if UNITY_EDITOR
            if (libx.Assets.development)
            {
                LoadGameScene();
                return;
            }
#endif
            libx.NetworkMonitor.Instance.onReachabilityChanged += OnReachablityChanged;
            _platform = GetPlatformForAssetBundles(Application.platform);
            if (Application.internetReachability == NetworkReachability.NotReachable)
            {
                OnMessage("请检查您的网络连接");
            }
            else
            {
                RequsetVersionName();
            }
        }

        private void OnReachablityChanged(NetworkReachability reachability)
        {
            if (reachability == NetworkReachability.NotReachable)
            {
                OnMessage("网络错误");
            }
        }

        private void EnterGame()
        {
        }

        // 点击更新按钮开始更新内容，如果没有跟新内容，则直接进入游戏
        public void StartUpdate()
        {
            OnMessage("正在获取服务器版本信息...");
            if (Application.internetReachability == NetworkReachability.NotReachable)
            {
            }
            else
            {
                libx.Assets.DownloadVersions(error =>
                {
                    if (!string.IsNullOrEmpty(error))
                    {
                        OnMessage("获取服务器版本失败");
                    }
                    else
                    {
                        OnMessage("开始下载服务器资源");
                        libx.Downloader handler;
                        // 按分包下载版本更新，返回true的时候表示需要下载，false的时候，表示不需要下载
                        if (libx.Assets.DownloadAll(libx.Assets.patches4Init, out handler))
                        {
                            var totalSize = handler.size;
                            var tips = string.Format("发现内容更新，总计需要下载 {0} 内容", libx.Downloader.GetDisplaySize(totalSize));
                            OnMessage(tips);
                            handler.onUpdate += delegate(long progress, long size, float speed)
                            {
                                //刷新界面
                                OnMessage(string.Format("下载中...{0}/{1}, 速度：{2}",
                                    libx.Downloader.GetDisplaySize(progress),
                                    libx.Downloader.GetDisplaySize(size),
                                    libx.Downloader.GetDisplaySpeed(speed)));
                                OnProgress(progress * 1f / size);
                            };
                            handler.onFinished += DownloadOnComplete;
                            handler.Start();
                        }
                        else
                        {
                            DownloadOnComplete();
                        }
                    }
                });
            }
        }

        private void Update()
        {
            switch (Game.Instance.GameStep)
            {
                case Game.Step.Wait:
                    break;
                case Game.Step.ChangeScene:
                    if (_scene != null)
                    {
                        // Debug.Log("场景切换中 ======>>" + _scene.progress);
                        OnProgress(_scene.progress);
                    }

                    break;
            }
        }

        // 资源下载完成，启动虚拟机，预加载资源界面
        private void DownloadOnComplete()
        {
            OnMessage("资源加载完成");
            OnProgress(1);
            OnMessage("本地环境初始化");
            LoadGameScene();
        }

        private string GetEnvironment()
        {
            if (libx.Assets.downloadURL == "https://cdn-byh5.jjhgame.com/Unity_Fish/")
            {
                return "cdn";
            }

            return "local";
        }

        private string GetVersion()
        {
            string filePath = Application.persistentDataPath + "/recordingVersion.txt";
            string versionData = "";
            if (File.Exists(filePath))
            {
                versionData = File.ReadAllText(filePath);
            }

            return versionData;
        }

        public void RequsetVersionName()
        {
            string urlStr = _apiDomain + "/foreign/version_check?env=" + GetEnvironment() + "&platform=" + _platform +
                            "&version=" + GetVersion();
            Debug.Log(string.Format("Before the http request starts ,url:{0}", urlStr));
            var httpRequest = new HTTPRequest(new Uri(urlStr), HTTPMethods.Get, OnGetMessagesFinished);
            httpRequest.Send();
        }

        public void UpdateDownloadVersions(string fileName,string apkUrl,string desc)
        {
            if (String.IsNullOrEmpty(fileName))
            {
                Debug.Log("Did not get the latest version");
            }
            else
            {
                libx.Assets.currentVersion = fileName;
                libx.Assets.apkUrl = apkUrl;
                if (GetEnvironment() == "cdn")
                {
                    libx.Assets.downloadURL = string.Format("{0}{1}/", "https://cdn-byh5.jjhgame.com/Unity_Fish/",
                        libx.Assets.currentVersion);
                }
                else
                {
                    libx.Assets.downloadURL =
                        string.Format("{0}{1}/", "http://192.168.86.14/AB/", libx.Assets.currentVersion);
                }
                
                Debug.Log("实际下载资源地址： " + libx.Assets.downloadURL);
                Debug.Log("本地版本： " + libx.Assets.localVersions.ver);
                Debug.Log("远程版本： " + libx.Assets.currentVersion);
                var curV = float.Parse((libx.Assets.currentVersion.Split('_')[0]));
                var localV = float.Parse(libx.Assets.localVersions.ver.Split('.')[0]);
                if (curV > localV && !string.IsNullOrEmpty(libx.Assets.apkUrl))
                {
                    Debug.Log("apk下载地址： " + libx.Assets.apkUrl);
                    OnUpdateApk(desc);
                }
                else
                {
                    StartUpdate();
                }
                
            }
        }
        
        public void loadApk()
        {
            OnMessage("开始下载apk");
            var filename = Application.temporaryCachePath+"/download/fish3.apk";
            var request =libx.Assets.Download(libx.Assets.apkUrl, filename);
            request.SendWebRequest().completed += operation =>
            {
                OnMessage("apk下载完成");
                installApk(filename);
                
                request.Dispose();
            };
        }
        
        public  void installApk(String apkFullPath)
        {
            try
            {
                OnMessage("开始安装apk");
                var FileProvider = new AndroidJavaClass("android.support.v4.content.FileProvider");
                var Intent = new AndroidJavaClass("android.content.Intent");
                var ACTION_VIEW = Intent.GetStatic<string>("ACTION_VIEW");
                var FLAG_ACTIVITY_NEW_TASK = Intent.GetStatic<int>("FLAG_ACTIVITY_NEW_TASK");
                var FLAG_GRANT_READ_URI_PERMISSION = Intent.GetStatic<int>("FLAG_GRANT_READ_URI_PERMISSION");
                var intent = new AndroidJavaObject("android.content.Intent", ACTION_VIEW);
                AndroidJavaClass up = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
                AndroidJavaObject currentActivity = up.GetStatic<AndroidJavaObject>("currentActivity");
 
                var file = new AndroidJavaObject("java.io.File", apkFullPath);
                AndroidJavaObject uri;
                if (getSDKInt() >= 24)
                {
                    uri = FileProvider.CallStatic<AndroidJavaObject>("getUriForFile", currentActivity, Application.identifier+".fileProvider", file);
                    intent.Call<AndroidJavaObject>("setFlags", FLAG_ACTIVITY_NEW_TASK);
                    Debug.Log("Android版本:"+getSDKInt());
                }
                else
                {
                    AndroidJavaClass uriObj = new AndroidJavaClass("android.net.Uri");
                    uri = uriObj.CallStatic<AndroidJavaObject>("fromFile", file);
                    Debug.Log("Android版本:"+getSDKInt());
                }
                intent.Call<AndroidJavaObject>("addFlags", FLAG_GRANT_READ_URI_PERMISSION);
                intent.Call<AndroidJavaObject>("setDataAndType", uri, "application/vnd.android.package-archive");
 
                currentActivity.Call("startActivity", intent);
                OnUpdateApk("");
            }
            catch (System.Exception e)
            {
                Debug.LogError(e.Message);
            }

        }
        
        private int getSDKInt() {
            using (var version = new AndroidJavaClass("android.os.Build$VERSION")) {
                return version.GetStatic<int>("SDK_INT");
            }
        }

        private void OnGetMessagesFinished(HTTPRequest req, HTTPResponse resp)
        {
            string logData = "";
            switch (req.State)
            {
                case HTTPRequestStates.Finished:
                    if (resp.IsSuccess)
                    {
                        Message msg = JsonUtility.FromJson<Message>(resp.DataAsText);
                        Debug.Log(string.Format("==============={0}====", resp.DataAsText));
                        logData = string.Format("Handshake Request finished Successfully,and resources Name{0}",
                            msg.data.resources_uri);
                        UpdateDownloadVersions(msg.data.resources_uri,msg.data.apk_uri,msg.data.desc);
                    }
                    else
                    {
                        logData = string.Format(
                            "Handshake Request finished Successfully, but the server sent an error. Status Code: {0}-{1} Message: {2}",
                            resp.StatusCode,
                            resp.Message,
                            resp.DataAsText);
                    }

                    break;

                // The request finished with an unexpected error. The request's Exception property may contain more info about the error.
                case HTTPRequestStates.Error:
                    logData = "Handshake Request Finished with Error! " + (req.Exception != null
                        ? (req.Exception.Message + "\n" + req.Exception.StackTrace)
                        : "No Exception");
                    break;

                // The request aborted, initiated by the user.
                case HTTPRequestStates.Aborted:
                    logData = "Handshake Request Aborted!";
                    break;

                // Connecting to the server is timed out.
                case HTTPRequestStates.ConnectionTimedOut:
                    logData = "Handshake - Connection Timed Out!";
                    break;

                // The request didn't finished in the given time.
                case HTTPRequestStates.TimedOut:
                    logData = "Handshake - Processing the request Timed Out!";
                    break;
            }

            if (!string.IsNullOrEmpty(logData))
            {
                Debug.Log(logData);
            }
        }

        private JObject LoadFileServerInfo(string fileName)
        {
            string str = File.ReadAllText(fileName);
            JObject versionInfo = JObject.Parse(str);
            return versionInfo;
        }

        private static string GetPlatformForAssetBundles(RuntimePlatform target)
        {
            // ReSharper disable once SwitchStatementMissingSomeCases
#if !UNITY_EDITOR
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
#else
            return "OSX";
#endif
        }

        private void LoadGameScene()
        {
            OnProgress(0);
            OnMessage("加载游戏场景");
            var scene = libx.Assets.LoadSceneAsync(libx.R.GetScene("EnterGameScene"));
            Game.Instance.GameStep = Game.Step.ChangeScene;
            _scene = scene;
            scene.completed += request =>
            {
                if (scene.isDone)
                {
                    OnProgress(1.0f);
                    Game.Instance.GameStep = Game.Step.Start;
                    // Debug.Log("场景切换完成 ======>>");
                }
            };
        }

        private void OnDestroy()
        {
            listener = null;
            // Debug.Log("清理 进度条监听 =====>>>");
        }
    }
}