#!/bin/sh
###########配置开始###########
#设置Unity3d项目目录
UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/Arthas"
###########配置结束###########


if [ "$1" == "2" ]; then
  UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/IOS/Arthas/Arthas/"
  UNITY3D_BUILD_METHOD="ProjectTools.AutoBuildAPK.BuildHotPackageIOS"
elif [ "$1" == "1" ]; then
  UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/Arthas"
  UNITY3D_BUILD_METHOD="ProjectTools.AutoBuildAPK.BuildHotPackageAndroid"
fi
echo "-------------unity项目地址："$UNITY3D_PROJECT_PATH

cd ${UNITY3D_PROJECT_PATH}
pwd
git pull

echo "-------------unity项目----pull---end---------"

