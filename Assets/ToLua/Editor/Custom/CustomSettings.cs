﻿using UnityEngine;
using System;
using System.Collections.Generic;
 using System.IO;
 using LuaInterface;
using UnityEditor;

using BindType = ToLuaMenu.BindType;
using System.Reflection;
using FairyGUI;
using Arthas;
using Spine.Unity;
using UnityEngine.Networking;
using Tools = Arthas.Tools;

public static class CustomSettings
{
    public static string saveDir = Application.dataPath + "/Src/CSharp/Generate/";    
    public static string toluaBaseType = Application.dataPath + "/ToLua/ToLua/BaseType/";
    public static string baseLuaDir = Application.dataPath + "/ToLua/ToLua/Lua/";
    public static string injectionFilesPath = Application.dataPath + "/ToLua/ToLua/Injection/";

    //导出时强制做为静态类的类型(注意customTypeList 还要添加这个类型才能导出)
    //unity 有些类作为sealed class, 其实完全等价于静态类
    public static List<Type> staticClassTypes = new List<Type>
    {        
        typeof(UnityEngine.Application),
        typeof(UnityEngine.Time),
        typeof(UnityEngine.Screen),
        typeof(UnityEngine.SleepTimeout),
        typeof(UnityEngine.Input),
        typeof(UnityEngine.Resources),
        typeof(UnityEngine.Physics),
        typeof(UnityEngine.RenderSettings),
        typeof(UnityEngine.QualitySettings),
        typeof(UnityEngine.GL),
        typeof(UnityEngine.Graphics),
    };

    //附加导出委托类型(在导出委托时, customTypeList 中牵扯的委托类型都会导出， 无需写在这里)
    public static DelegateType[] customDelegateList = 
    {        
        _DT(typeof(Action)),                
        _DT(typeof(UnityEngine.Events.UnityAction)),
        _DT(typeof(System.Predicate<int>)),
        _DT(typeof(System.Action<int>)),
        _DT(typeof(System.Comparison<int>)),
        _DT(typeof(System.Func<int, int>)),
    };

    //在这里添加你要导出注册到lua的类型列表
    public static BindType[] customTypeList =
    {                
        //------------------------为例子导出--------------------------------
        //_GT(typeof(TestEventListener)),
        //_GT(typeof(TestProtol)),
        //_GT(typeof(TestAccount)),
        //_GT(typeof(Dictionary<int, TestAccount>)).SetLibName("AccountMap"),
        //_GT(typeof(KeyValuePair<int, TestAccount>)),
        //_GT(typeof(Dictionary<int, TestAccount>.KeyCollection)),
        //_GT(typeof(Dictionary<int, TestAccount>.ValueCollection)),
        //_GT(typeof(TestExport)),
        //_GT(typeof(TestExport.Space)),
        //-------------------------------------------------------------------        
                        
        _GT(typeof(LuaInjectionStation)),
        _GT(typeof(InjectType)),
        _GT(typeof(Debugger)).SetNameSpace(null),
        
        // ------------------------- USING_DOTWEENING -------------------------
        _GT(typeof(DG.Tweening.DOTween)),
        _GT(typeof(DG.Tweening.Tween)).SetBaseType(typeof(System.Object)).AddExtendType(typeof(DG.Tweening.TweenExtensions)),
        _GT(typeof(DG.Tweening.Sequence)).AddExtendType(typeof(DG.Tweening.TweenSettingsExtensions)),
        _GT(typeof(DG.Tweening.Tweener)).AddExtendType(typeof(DG.Tweening.TweenSettingsExtensions)),
        _GT(typeof(DG.Tweening.LoopType)),
        _GT(typeof(DG.Tweening.PathMode)),
        _GT(typeof(DG.Tweening.PathType)),
        _GT(typeof(DG.Tweening.RotateMode)),
        _GT(typeof(Component)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(Transform)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(Light)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(Material)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(Rigidbody)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(Camera)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(AudioSource)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(LineRenderer)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)),
        _GT(typeof(TrailRenderer)).AddExtendType(typeof(DG.Tweening.ShortcutExtensions)), 
        
        _GT(typeof(DG.Tweening.AutoPlay)),
        _GT(typeof(DG.Tweening.AxisConstraint)),
        _GT(typeof(DG.Tweening.Ease)),
        _GT(typeof(DG.Tweening.LogBehaviour)),
        _GT(typeof(DG.Tweening.ScrambleMode)),
        _GT(typeof(DG.Tweening.TweenType)),
        _GT(typeof(DG.Tweening.UpdateType)),

        _GT(typeof(DG.Tweening.DOVirtual)),
        _GT(typeof(DG.Tweening.EaseFactory)),
        _GT(typeof(DG.Tweening.TweenParams)),

        _GT(typeof(DG.Tweening.Core.ABSSequentiable)),
        _GT(typeof(DG.Tweening.Core.TweenerCore<Vector3, Vector3, DG.Tweening.Plugins.Options.VectorOptions>)).SetWrapName("TweenerCoreV3V3VO").SetLibName("TweenerCoreV3V3VO"),

        
// -------------------------- unity -----------------------------      
        _GT(typeof(Behaviour)),
        _GT(typeof(MonoBehaviour)),        
        _GT(typeof(GameObject)),
        _GT(typeof(TrackedReference)),
        _GT(typeof(Application)),
        _GT(typeof(Physics)),
        _GT(typeof(Collider)),
        _GT(typeof(Time)),        
        _GT(typeof(Texture)),
        _GT(typeof(Texture2D)),
        _GT(typeof(Shader)),        
        _GT(typeof(Renderer)),
        _GT(typeof(WWW)),
        _GT(typeof(File)),
        _GT(typeof(StreamWriter)),
        _GT(typeof(Screen)),        
        _GT(typeof(CameraClearFlags)),
        _GT(typeof(AudioClip)),        
        _GT(typeof(AssetBundle)),
//        _GT(typeof(ParticleSystem)),
        _GT(typeof(AsyncOperation)).SetBaseType(typeof(System.Object)),        
        _GT(typeof(LightType)),
        _GT(typeof(SleepTimeout)),
#if UNITY_5_3_OR_NEWER && !UNITY_5_6_OR_NEWER
        _GT(typeof(UnityEngine.Experimental.Director.DirectorPlayer)),
#endif
        _GT(typeof(Animator)),
        _GT(typeof(AnimatorStateInfo)),
        _GT(typeof(Input)),
        _GT(typeof(KeyCode)),
        _GT(typeof(SkinnedMeshRenderer)),
        _GT(typeof(Space)),      
       
        _GT(typeof(Mesh)),
        _GT(typeof(MeshFilter)),
        _GT(typeof(MeshRenderer)),
#if !UNITY_5_4_OR_NEWER
        _GT(typeof(ParticleEmitter)),
        _GT(typeof(ParticleRenderer)),
        _GT(typeof(ParticleAnimator)), 
#endif

        _GT(typeof(BoxCollider)),
        _GT(typeof(MeshCollider)),
        _GT(typeof(SphereCollider)),        
        _GT(typeof(CharacterController)),
        _GT(typeof(CapsuleCollider)),
        
        _GT(typeof(Animation)),        
        _GT(typeof(AnimationClip)).SetBaseType(typeof(UnityEngine.Object)),        
        _GT(typeof(AnimationState)),
        _GT(typeof(AnimationBlendMode)),
        _GT(typeof(QueueMode)),  
        _GT(typeof(PlayMode)),
        _GT(typeof(WrapMode)),

        _GT(typeof(QualitySettings)),
        _GT(typeof(RenderSettings)),                                                   
        _GT(typeof(SkinWeights)),           
        _GT(typeof(RenderTexture)),
        _GT(typeof(Resources)),     
        _GT(typeof(LuaProfiler)),


        _GT(typeof(Rect)),
        _GT(typeof(SystemInfo)),
        
        
        // --------------------------- FairyGUI ---------------------------
        _GT(typeof(EventContext)),
        _GT(typeof(EventDispatcher)),
        _GT(typeof(EventListener)),
        _GT(typeof(InputEvent)),
        _GT(typeof(DisplayObject)),
        _GT(typeof(Container)),
        _GT(typeof(Stage)),
        _GT(typeof(FairyGUI.Controller)),
        _GT(typeof(GObject)),
        _GT(typeof(GGraph)),
        _GT(typeof(GGroup)),
        _GT(typeof(GImage)),
        _GT(typeof(GLoader)),
        _GT(typeof(GMovieClip)),
        _GT(typeof(TextFormat)),
        _GT(typeof(GTextField)),
        _GT(typeof(GRichTextField)),
        _GT(typeof(GTextInput)),
        _GT(typeof(GComponent)),
        _GT(typeof(GList)),
        _GT(typeof(GRoot)),
        _GT(typeof(GLabel)),
        _GT(typeof(GButton)),
        _GT(typeof(GComboBox)),
        _GT(typeof(GProgressBar)),
        _GT(typeof(GSlider)),
        _GT(typeof(PopupMenu)),
        _GT(typeof(ScrollPane)),
        _GT(typeof(Transition)),
        _GT(typeof(UIPackage)),
        _GT(typeof(Window)),
        _GT(typeof(GObjectPool)),
        _GT(typeof(Relations)),
        _GT(typeof(RelationType)),
        _GT(typeof(Timers)),
        _GT(typeof(GTween)),
        _GT(typeof(GTweener)),
        _GT(typeof(EaseType)),
        _GT(typeof(TweenValue)),
        _GT(typeof(TweenPropType)),
        _GT(typeof(UIObjectFactory)),
        _GT(typeof(GoWrapper)),
        _GT(typeof(UIContentScaler)),
        _GT(typeof(UIContentScaler.ScreenMatchMode)),
        _GT(typeof(NTexture)),
        _GT(typeof(FontManager)),
        _GT(typeof(DynamicFont)),
        _GT(typeof(UIConfig)),
        _GT(typeof(ColorFilter)),

        // --------------------------- 自定义组件 ---------------------------
        _GT(typeof(Tools)),
        _GT(typeof(GameEntry)),
        _GT(typeof(SoundCompoent)),
        _GT(typeof(UVChainLightning)),

        // --------------------------- netWork ---------------------------
        _GT(typeof(BestHTTP.HTTPRequest)),
        _GT(typeof(BestHTTP.HTTPResponse)),
        _GT(typeof(BestHTTP.HTTPMethods)),
        _GT(typeof(BestHTTP.WebSocket.WebSocket)),
        _GT(typeof(BestHTTP.WebSocket.WebSocketResponse)),
        _GT(typeof(BestHTTP.WebSocket.WebSocketStates)),
        _GT(typeof(BestHTTP.WebSocket.WebSocketStausCodes)),
        _GT(typeof(System.Uri)),
        
        // ------------------------------ spine -----------------------------
        // _GT(typeof(Spine.Animation)),
        // _GT(typeof(Spine.Atlas)),
        // _GT(typeof(Spine.Attachment)),
        // _GT(typeof(Spine.Bone)),
        // _GT(typeof(Spine.Event)),
        // _GT(typeof(Spine.Format)),
        // _GT(typeof(Spine.Json)),
        // _GT(typeof(Spine.Polygon)),
        // _GT(typeof(Spine.Skeleton)),
        // _GT(typeof(Spine.Skin)),
        // _GT(typeof(Spine.Slot)),
        // _GT(typeof(Spine.Timeline)),
        // _GT(typeof(Spine.AnimationState)),
        // _GT(typeof(Spine.AtlasPage)),
        // _GT(typeof(Spine.AtlasRegion)),
        // _GT(typeof(Spine.AttachmentLoader)),
        // _GT(typeof(Spine.AttachmentTimeline)),
        // _GT(typeof(Spine.AttachmentType)),
        // _GT(typeof(Spine.BlendMode)),
        // _GT(typeof(Spine.BoneData)),
        // _GT(typeof(Spine.BoneMatrix)),
        // _GT(typeof(Spine.BoneMatrix)),
        // _GT(typeof(Spine.ClippingAttachment)),
        // _GT(typeof(Spine.ColorTimeline)),
        _GT(typeof(Spine.Unity.SkeletonAnimation)),
        _GT(typeof(Spine.AnimationState)),
        _GT(typeof(UnityWebRequest)),
        _GT(typeof(UnityWebRequestTexture)),
        _GT(typeof(DownloadHandlerTexture)),
        _GT(typeof(UnityWebRequestAsyncOperation)),
        
        // ------------------------------ xasset -----------------------------
        _GT(typeof(libx.Assets)),
        _GT(typeof(libx.AssetRequest)),
        _GT(typeof(libx.BundleAssetRequest)),
        _GT(typeof(libx.BundleAsyncRequest)),
        _GT(typeof(libx.SceneAssetRequest)),
        _GT(typeof(libx.SceneAssetAsyncRequest))
    };

    public static List<Type> dynamicList = new List<Type>()
    {
        typeof(MeshRenderer),
#if !UNITY_5_4_OR_NEWER
        typeof(ParticleEmitter),
        typeof(ParticleRenderer),
        typeof(ParticleAnimator),
#endif

        typeof(BoxCollider),
        typeof(MeshCollider),
        typeof(SphereCollider),
        typeof(CharacterController),
        typeof(CapsuleCollider),

        typeof(Animation),
        typeof(AnimationClip),
        typeof(AnimationState),

        typeof(SkinWeights),
        typeof(RenderTexture),
        typeof(Rigidbody),
    };

    //重载函数，相同参数个数，相同位置out参数匹配出问题时, 需要强制匹配解决
    //使用方法参见例子14
    public static List<Type> outList = new List<Type>()
    {
        
    };
        
    //ngui优化，下面的类没有派生类，可以作为sealed class
    public static List<Type> sealedList = new List<Type>()
    {
        /*typeof(Transform),
        typeof(UIRoot),
        typeof(UICamera),
        typeof(UIViewport),
        typeof(UIPanel),
        typeof(UILabel),
        typeof(UIAnchor),
        typeof(UIAtlas),
        typeof(UIFont),
        typeof(UITexture),
        typeof(UISprite),
        typeof(UIGrid),
        typeof(UITable),
        typeof(UIWrapGrid),
        typeof(UIInput),
        typeof(UIScrollView),
        typeof(UIEventListener),
        typeof(UIScrollBar),
        typeof(UICenterOnChild),
        typeof(UIScrollView),        
        typeof(UIButton),
        typeof(UITextList),
        typeof(UIPlayTween),
        typeof(UIDragScrollView),
        typeof(UISpriteAnimation),
        typeof(UIWrapContent),
        typeof(TweenWidth),
        typeof(TweenAlpha),
        typeof(TweenColor),
        typeof(TweenRotation),
        typeof(TweenPosition),
        typeof(TweenScale),
        typeof(TweenHeight),
        typeof(TypewriterEffect),
        typeof(UIToggle),
        typeof(Localization),*/
    };

    public static BindType _GT(Type t)
    {
        return new BindType(t);
    }

    public static DelegateType _DT(Type t)
    {
        return new DelegateType(t);
    }    


    [MenuItem("Arthas/Lua/Attach Profiler", false, 151)]
    static void AttachProfiler()
    {
        if (!Application.isPlaying)
        {
            EditorUtility.DisplayDialog("警告", "请在运行时执行此功能", "确定");
            return;
        }

        LuaClient.Instance.AttachProfiler();
    }

    [MenuItem("Arthas/Lua/Detach Profiler", false, 152)]
    static void DetachProfiler()
    {
        if (!Application.isPlaying)
        {            
            return;
        }

        LuaClient.Instance.DetachProfiler();
    }
}
