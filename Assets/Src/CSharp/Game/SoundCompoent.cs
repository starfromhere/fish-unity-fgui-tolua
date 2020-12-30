using System;
using UnityEngine;

namespace Arthas
{
    public class SoundCompoent : MonoBehaviour
    {
        /// <summary>
        /// 背景声音组件
        /// </summary>
        private AudioSource m_BgAudioSource = null;

        /// <summary>
        /// 音效组件
        /// </summary>
//        private AudioSource m_EffectAudioSource = null;
        
        /// <summary>
        /// 监听组件
        /// </summary>
        private AudioListener m_AudioListener = null;
        
        private void Awake()
        {
            AudioListener = gameObject.AddComponent<AudioListener>();
            Audio         = gameObject.AddComponent<AudioSource>();
        }

        public AudioSource AddEffectAudio()
        {
            return gameObject.AddComponent<AudioSource>();
        }

        public AudioSource Audio
        {
            get { return m_BgAudioSource; }
            set { m_BgAudioSource = value; }
        }
        
        public AudioListener AudioListener
        {
            get { return m_AudioListener; }
            set { m_AudioListener = value; }
        }
    }
}