using UnityEngine;
using UnityEditor;
using UnityEditor.Callbacks;
#if (UNITY_IOS || UNITY_EDITOR_OSX) && INSTALL_XCODE
using UnityEditor.iOS.Xcode;
#endif
using System.IO;

namespace ProjectTools
{
    public class XCodeProjectMod : MonoBehaviour
    {
        [PostProcessBuild]
        public static void OnPostprocessBuild(BuildTarget BuildTarget, string path)
        {
            if (BuildTarget != BuildTarget.iOS)
            {
                Debug.LogWarning("Target is not ios, XcodePostProcess will not run");
                return;
            }
#if (UNITY_IOS || UNITY_EDITOR_OSX) && INSTALL_XOCDE
            //这里是固定的
            string projPath = PBXProject.GetPBXProjectPath(path);
            PBXProject proj = new PBXProject();
            proj.ReadFromString(File.ReadAllText(projPath));
            string target = proj.TargetGuidByName("Unity-iPhone");
                
            // set code sign identity & provisioning profile
            proj.SetBuildProperty (target, "CODE_SIGN_IDENTITY", "Apple Development: 445602785@qq.com (2LY894H8LL)");//替换你的code sign identity
            proj.SetBuildProperty (target, "PROVISIONING_PROFILE_SPECIFIER", "com.jjhgame.Arthas");//替换你的provisioning profile specifier
            //proj.SetBuildProperty (target, "CODE_SIGN_ENTITLEMENTS", "KeychainAccessGroups.plist");
            proj.SetBuildProperty (target, "DEVELOPMENT_TEAM", "445602785@qq.com");//替换你的development team
            proj.SetBuildProperty (target, "CODE_SIGN_STYLE", "Manual");

            //ulua 库不支持 bitcode必须要关闭，才能打包
            proj.SetBuildProperty(target,"ENABLE_BITCODE", "NO");

            File.WriteAllText(projPath, proj.WriteToString());
#endif
        }
    }
}