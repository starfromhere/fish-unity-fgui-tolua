using System;
using UnityEngine;

namespace Arthas
{
    public class GameEntry : LuaClient
    {
        /*
        * 启动lua虚拟机, 加载资源和代码。 缓存资源（待优化）
        */

        private static SoundCompoent m_SoundCompoent;
        
        private void Awake()
        {
#if !UNITY_EDITOR
            Application.targetFrameRate = 60;
#endif
            Sound = gameObject.AddComponent<SoundCompoent>();
            base.Awake();
        }

        private void Start()
        {
        }

        public static SoundCompoent Sound
        {
            get { return m_SoundCompoent; }
            set { m_SoundCompoent = value; }
        }

        /// <summary>
        /// 仅提供给lua层使用
        /// 在lua层虚拟机启动完成，资源预加载完成后失效
        /// </summary>
        public static void UpdateProgress(float pregress)
        {
            Game.Instance.ProgressValue = pregress;
            Game.Instance.GameStep = Game.Step.LuaLoad;
        }
        
        /// <summary>
        /// 仅提供给lua层使用
        /// 在lua层虚拟机启动完成，资源预加载完成后失效
        /// </summary>
        public static void PreLoadComplete()
        {
            Game.Instance.GameStep = Game.Step.LuaCompleted;
        }
        
        new void OnApplicationQuit()
        {
            base.OnApplicationQuit();
        }
    }
}