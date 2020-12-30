#!/bin/sh
###########配置开始###########
#设置Unity3d项目目录
UNITY3D_PROJECT_PATH="E:\Arthas\Arthas"
#设置Unity3d执行的编译方法
UNITY3D_BUILD_METHOD="ProjectTools.AutoBuildAPK.ArthasBuildBundles"
#设置Unity3d exe文件路径
UNITY3D_EXE_PATH="D:\UnityHub\Unity\2019.4.6f1\Editor\Unity"
#Unity3d项目打包后生成的增量包路径
UNITY3D_OUTPUT_PATH=$UNITY3D_PROJECT_PATH"Bundles/"
#Unity3d项目更新路径
UPDATE_ONLINE_PATH="/Library/WebServer/Documents/AB/"
###########配置结束###########

#if [ "$1" == "2" ]; then
#  UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/IOS/Arthas/Arthas/"
#elif [ "$1" == "1" ]; then
#  UNITY3D_PROJECT_PATH="/Users/jjhgame/Desktop/code/buyu3/Arthas"
#fi


if [ ! -d ${UNITY3D_OUTPUT_PATH}  ];then
  mkdir ${UNITY3D_OUTPUT_PATH}
else
  echo dir exist
fi
cd ${UNITY3D_PROJECT_PATH}
#执行Unity3d编译指令
#-executeMethod 指定执行的编译方法
#-projectPath 指定Unity3d项目目录
#-projectPath 指定Unity3d项目目录
${UNITY3D_EXE_PATH} -quit -batchmode -executeMethod ${UNITY3D_BUILD_METHOD} -projectPath ${UNITY3D_PROJECT_PATH} -logFile "${UNITY3D_OUTPUT_PATH}/log.log"

echo "-------------update--end-------------"

#CUR_FILE=$(ls -l $UNITY3D_OUTPUT_PATH |awk '/^d/ {print $NF}' | sort |tail -1)

#if  [ -d $UPDATE_ONLINE_PATH$CUR_FILE ];then
#  echo  "文件夹存在"
#  rm -rf $UPDATE_ONLINE_PATH$CUR_FILE
#  echo  "文件夹已删除"
#else
#  echo  "文件夹不存在"
#fi
#mv $UNITY3D_OUTPUT_PATH$CUR_FILE $UPDATE_ONLINE_PATH
#echo  $CUR_FILE"文件夹已移动到"$UPDATE_ONLINE_PATH
#cd ${UPDATE_ONLINE_PATH}
#pwd
#jq '.Android.Version="'${CUR_FILE}'"' TestVersion.json > test.json
#mv test.json TestVersion.json
#echo "------------all-------end------------"
