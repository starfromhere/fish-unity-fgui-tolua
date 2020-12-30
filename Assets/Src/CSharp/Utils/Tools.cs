using System;
using UnityEditor;
using UnityEngine;

namespace Arthas
{
    public class Tools
    {
        public static int timespace=8;
 
        //获取当前时间
        public static string GetTimeStamp(bool bflag = true)
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0);
            long ret;
            if (bflag)
                ret = Convert.ToInt64(ts.TotalSeconds);
            else
                ret = Convert.ToInt64(ts.TotalMilliseconds);
            return ret.ToString();
        }
        
        //获取今天时间
        public static long GetTimeToday(bool bflag = true)
        {
            TimeSpan ts = DateTime.Today -  new DateTime(1970, 1, 1, 0+timespace, 0, 0);
 
            long ret;
            if (bflag)
                ret = Convert.ToInt64(ts.TotalSeconds);
            else
                ret = Convert.ToInt64(ts.TotalMilliseconds);
            return ret;
        }


        public static string GetTimeNow()
        {
            int hour = DateTime.Now.Hour;
            int minute = DateTime.Now.Minute;
            int second = DateTime.Now.Second;
            int year = DateTime.Now.Year;
            int month = DateTime.Now.Month;
            int day = DateTime.Now.Day;

            //格式化显示当前时间
            return string.Format("{0:D2}:{1:D2}:{2:D2} " + "{3:D4}/{4:D2}/{5:D2}", hour, minute, second, year, month, day);
        }
        
        public static bool InEditor()
        {
            bool isEditor = false;
#if UNITY_EDITOR
            isEditor = true;
#endif
            return isEditor;
        }

        public static string GetPlatform()
        {
            string ret = "";
#if UNITY_STANDALONE_WIN
            ret = "Win";
#elif UNITY_STANDALONE_OSX
            ret = "Mac";
#elif UNITY_ANDROID
            ret = "Android";            
#elif UNITY_IPHONE
            ret = "IOS";       
#endif
            return ret;
        }

        public static string GetPrefix()
        {
#if UNITY_EDITOR || !ENABLE_DOWNLOAD_ASSETBUNDLE
            return Application.streamingAssetsPath;
#else
            return Application.persistentDataPath;
#endif
        }

        public static bool IsNull(object obj)
        {
            return obj == null;
        }
        
        /// <summary>
        /// 加载资源
        /// </summary>
        /// <param name="assetPath"></param>
        /// <returns></returns>
        public static UnityEngine.Object LoadAsset(string assetPath)
        {
            UnityEngine.Object ret = null;
#if UNITY_EDITOR
                ret = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(assetPath);
#else
                ret = UnityEngine.AssetBundle.LoadFromFile(assetPath);
#endif
            return ret;
        }


        public static FairyGUI.ColorFilter GetColorFilter(int r,int g,int b,int a)
        {
            float [] arr = new float[]{
                0,0,0,0,r,
                0,0,0,0,g,
                0,0,0,0,b,
                0,0,0,a,0};
            
            FairyGUI.ColorFilter filter = new FairyGUI.ColorFilter();
            filter.ConcatValues(arr);
            return filter;
        }

        public static void shakePhone(){
#if !UNITY_EDITOR && (UNITY_IPHONE || UNITY_ANDROID)
            Handheld.Vibrate();      
#endif
        }
        //复制剪贴板
        public static void CopyText(string copyTxt){
                GUIUtility.systemCopyBuffer = copyTxt;
        }
        //粘贴剪贴板
        public static string PasteText(){
             return GUIUtility.systemCopyBuffer;
        }

        ///获取动画状态机animator的动画clip的播放持续时长
        public static float GetClipLength(Animator animator, string clipName) 
        {
            if(null== animator || 
               string.IsNullOrEmpty(clipName) || 
               null == animator.runtimeAnimatorController)
                return 0;
            // 获取所有的clips	
            var clips = animator.runtimeAnimatorController.animationClips;
            if( null == clips || clips.Length <= 0) return 0;
            AnimationClip  clip ;
            for (int i = 0, len = clips.Length; i < len ; ++i) 
            {
                clip = clips[i];
                if(null != clip && clip.name == clipName)
                    return clip.length;
            }
            return 0f;
        }

        public static void PlayParticleEffect(ParticleSystem p)
        {
               p.Play();
        }
    }
}