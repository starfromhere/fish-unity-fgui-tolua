#!/bin/sh
###########配置开始###########
#设置Unity3d项目目录
UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/Arthas/Arthas/"
#设置Unity3d执行的编译方法
UNITY3D_BUILD_METHOD="ProjectTools.AutoBuildAPK.BuildHotPackageAndroid"
#设置Unity3d exe文件路径
UNITY3D_EXE_PATH="/Applications/Unity/Hub/Editor/2019.4.6f1/Unity.app/Contents/MacOS/Unity"
#Unity3d项目打包后生成的APK路径
UNITY3D_OUTPUT_PATH="/Users/jjhgame/Desktop/code/buyu3/package/android/"
###########配置结束###########

#Android apk 文件的名字
ANDROID_APK_NAME="fish3_Android.apk"
# des 网页上的文件描述
DES=$2
# name 网页上文件名称
FILE_NAME=$3
# 共享文件夹地址
WEB_FILE_PATH="/Library/WebServer/Documents/"

if [ "$1" == "2" ]; then
  UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/IOS/Arthas/Arthas/"
  UNITY3D_BUILD_METHOD="ProjectTools.AutoBuildAPK.BuildHotPackageIOS"
elif [ "$1" == "1" ]; then
  UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/Arthas"
  UNITY3D_BUILD_METHOD="ProjectTools.AutoBuildAPK.BuildHotPackageAndroid"
fi

echo "-------------unity项目地址："$UNITY3D_PROJECT_PATH

if [ ! -d ${UNITY3D_OUTPUT_PATH}  ];then
  mkdir ${UNITY3D_OUTPUT_PATH}
else
  echo dir exist
fi

#执行Unity3d编译指令
#-executeMethod 指定执行的编译方法
#-projectPath 指定Unity3d项目目录
#-projectPath 指定Unity3d项目目录
 ${UNITY3D_EXE_PATH} -quit -batchmode -executeMethod ${UNITY3D_BUILD_METHOD} -projectPath ${UNITY3D_PROJECT_PATH} -logFile "${UNITY3D_OUTPUT_PATH}/log.log"

if [ !-f"$UNITY3D_OUTPUT_PATH$ANDROID_APK_NAME" ];then
 mv "$UNITY3D_OUTPUT_PATH$ANDROID_APK_NAME" "$WEB_FILE_PATH$FILE_NAME.apk"
fi

JSON_OBJECT=$(cat ${WEB_FILE_PATH}apk-version.json |jq)
JSON_LENGTH=$(cat ${WEB_FILE_PATH}apk-version.json|jq 'length')
NEW_JSON_LENGTH=$(expr ${JSON_LENGTH} + 1 )
echo "-------NEW_JSON_LENGTH---------"$NEW_JSON_LENGTH
cat "${WEB_FILE_PATH}apk-version.json"|jq '.+{"'${NEW_JSON_LENGTH}'":{"des":"'${DES}'","fileName":"'${FILE_NAME}'"}}' > "${WEB_FILE_PATH}temp.json"
cat "${WEB_FILE_PATH}temp.json" > "${WEB_FILE_PATH}apk-version.json"
rm -rf "${WEB_FILE_PATH}temp.json"
echo "------------------END---------------"
