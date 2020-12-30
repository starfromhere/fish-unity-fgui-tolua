REM ###########配置开始###########
REM #设置Unity3d项目目录
SET UNITY3D_PROJECT_PATH="./"
REM #设置Unity3d执行的编译方法
SET UNITY3D_BUILD_METHOD="ProjectTools.AutoBuildAPK.BuildLocalAPK"
REM #设置Unity3d exe文件路径,
SET UNITY3D_EXE_PATH="/Applications/Unity/Unity.app/Contents/MacOS/Unity"
REM #Unity3d项目打包后生成的APK路径
SET UNITY3D_OUTPUT_PATH="./Build/Android/"
REM ###########配置结束###########


IF NOT EXIST %UNITY3D_OUTPUT_PATH% (
   MKDIR %UNITY3D_OUTPUT_PATH%
) ELSE (
   echo %UNITY3D_OUTPUT_PATH% is exist
)

REM #执行Unity3d编译指令
REM #-executeMethod 指定执行的编译方法
REM #-projectPath 指定Unity3d项目目录
REM #-logFile 指定日志输出目录
%UNITY3D_EXE_PATH% -quit -batchmode -executeMethod %UNITY3D_BUILD_METHOD% -projectPath %UNITY3D_PROJECT_PATH% -logFile "%UNITY3D_OUTPUT_PATH%/log.log"

PAUSE