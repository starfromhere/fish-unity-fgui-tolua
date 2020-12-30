#if !UNITY_EDITOR
using FairyGUI;
#endif
using System.Diagnostics;
using UnityEngine;
using Debug = UnityEngine.Debug;

namespace Arthas
{
    public class ArthasInitializer : MonoBehaviour
    {
        public bool splash;
        public bool loggable;
        public libx.VerifyBy verifyBy = libx.VerifyBy.CRC;
        public string downloadURL;
        public bool development;  
        public bool dontDestroyOnLoad = true;
        public string launchScene;
        public string[] searchPaths;
        public string[] patches4Init;
        public bool updateAll;
        private void Start()
        {
            if (dontDestroyOnLoad)
            {
                DontDestroyOnLoad(gameObject);
            }
            EditorInit();
            libx.Assets.updateAll = updateAll;
            libx.Assets.downloadURL = downloadURL;
            libx.Assets.verifyBy = verifyBy;
            libx.Assets.searchPaths = searchPaths;
            libx.Assets.patches4Init = patches4Init;
#if !UNITY_EDITOR
            UIPackage.AddPackage("Load/HotFixLoading/HotFixLoading");
#endif
            libx.Assets.Initialize(error =>
            {
                if (!string.IsNullOrEmpty(error))
                {
                    Debug.LogError(error);
                    return;
                }
                if (splash)
                {
                    Invoke("LoadScene", 2.8f);
                }
                else
                {
                    LoadScene();
                }
                
            });   
        }  

        [Conditional("UNITY_EDITOR")] 
        private void EditorInit()
        {
            libx.Assets.development = development; 
            libx.Assets.loggable = loggable;  
        }

        [Conditional("UNITY_EDITOR")]
        private void Update()
        {
            libx.Assets.loggable = loggable; 
        }
        
        
        void LoadScene()
        {
            libx.Assets.LoadSceneAsync(libx.R.GetScene(launchScene));
        }
    }
}