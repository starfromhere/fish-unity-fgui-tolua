using System;
using FairyGUI;
using Spine.Unity;
using UnityEngine;
using UnityEngine.SceneManagement;
using Object = UnityEngine.Object;

namespace Arthas
{
    public class LoadView : MonoBehaviour, IUpdater
    {
        private string _packageName = "HotFixLoading";
        private string _pageName = "HotFixLoadingPage";
        private const float DESIGN_WIDTH = 1280f;
        private const float DESIGN_HEIGHT = 720f;
        
        private GComponent _view = null;
        private GComponent _frame = null;
        private GTextField _apkDes = null;
        private GProgressBar _progress = null;
        private GGraph _loading = null;
        private GTextField _text = null;
        private GButton _confirmBtn = null;
        private Transition _loadingAni = null;
        
        private void Awake()
        {
            InitView();
        }

        private void Start()
        {
            DontDestroyOnLoad(gameObject);
        }

        private void InitView()
        {
            GRoot.inst.SetContentScaleFactor(1920, 1080);
#if UNITY_EDITOR
            UIPackage.AddPackage("Load/HotFixLoading/HotFixLoading");
#endif
            GComponent view = UIPackage.CreateObject(_packageName, _pageName).asCom;
            GRoot.inst.AddChild(view);
            view.MakeFullScreen();
            _view = view;
            _frame = _view.GetChild("frame").asCom;
            _frame.visible = false;
            _apkDes = _frame.GetChild("context").asCom.GetChild("text").asTextField;
            _confirmBtn = _frame.GetChild("confirmBtn").asButton;
            _loadingAni = _frame.GetTransition("loadingAni");
            
            _progress = _view.GetChild("loading").asProgress;
            _progress.value = 0;
            _loading = _view.GetChild("loadingSpine").asGraph;
            
            Object obj = Resources.Load("Load/Prefab/LoadSpine");
            GameObject spineItem = Instantiate(obj) as GameObject;
            float scaleX = GRoot.inst.width / DESIGN_WIDTH;
            float scaleY = GRoot.inst.height / DESIGN_HEIGHT;
            spineItem.transform.localScale = new Vector3(scaleX, scaleY, 1);
            GoWrapper wrapper = new GoWrapper(spineItem);
            SkeletonAnimation spine = spineItem.gameObject.GetComponent<SkeletonAnimation>();
            spine.state.SetAnimation(0, "H5_loading", true);
            _loading.SetNativeObject(wrapper);

            _text = _view.GetChild("textInfo").asTextField;
            _text.text = "正在检测版本更新...";
            
            _confirmBtn.onClick.Add(onClick);
            
        }

        private void onClick()
        {
            Debug.Log("开始下载apk");
            _confirmBtn.touchable = false;
            _loadingAni.Play();
            var updater = FindObjectOfType<Updater> ();
            updater.loadApk();
        }
        
        private static UIPackage.LoadResource _loadFromResourcesPath = (string name, string extension, System.Type type, out DestroyMethod destroyMethod) =>
        {
            destroyMethod = DestroyMethod.Unload;
            return Resources.Load(name, type);
        };

        private void Update()
        {
            DealGameState();
            if (Game.Instance.GameStep != Game.Step.Start) return;
            switch (SceneManager.GetActiveScene().name)
            {
                case "StartGameScene":
                    var updater = FindObjectOfType<Updater> ();
                    updater.listener = this;
                    break;
                case "EnterGameScene":
                    var startGame = FindObjectOfType<StartGame> ();
                    startGame.listener = this;
                    break;
            }
            Game.Instance.GameStep = Game.Step.Wait;
        }

        private void DealGameState()
        {
            switch (Game.Instance.GameStep)
            {
                case Game.Step.LuaCompleted:
                    Game.Instance.GameStep = Game.Step.Wait;
                    ClearDate();
                    break;
                case Game.Step.LuaLoad:
                    Game.Instance.GameStep = Game.Step.None;
                    OnProgress(Game.Instance.ProgressValue);
                    break;
                case Game.Step.Wait:
                    break;
            }
        }

        private void ClearDate()
        {
            Debug.Log("清理 C# 内容");
            Game.Instance.Clear();
            Destroy(gameObject);
        }
        
        private void OnDestroy()
        {
            _view.RemoveFromParent();
            _view.Dispose();
        }


        #region IUpdateManager implementation

        public void OnStart()
        {
        }

        public void OnMessage(string msg)
        {
            _text.text = msg;
        }
        
        

        public void OnProgress(float progress)
        {
            // Debug.Log(string.Format("C#  progress: {0}", progress));
            // _progress.TweenValue(progress * _progress.max, 0.05f);
            _progress.value = progress*_progress.max;
        }


        public void OnClear()
        {
        }

        public void OnUpdateApk(string msg)
        {
            if (msg != null && msg.Length > 0)
            {
                _apkDes.text = msg;
            }
            _frame.visible = true;
            _loadingAni.Stop();
            if (Application.platform == RuntimePlatform.Android)
            {
                Debug.Log("Android平台");
                _confirmBtn.visible = true;
                _confirmBtn.touchable = true;
            }
            else   //if (Application.platform == RuntimePlatform.IPhonePlayer)
            {
                _confirmBtn.visible = false;
            }

        }

        #endregion
    }
}