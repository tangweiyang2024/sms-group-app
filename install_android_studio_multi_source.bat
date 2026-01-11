@echo off
echo ==========================================
echo Android Studio 多源下载安装脚本
echo ==========================================

set AS_VERSION=2022.3.1.22
set AS_INSTALLER=D:\study\sms-group\android-studio-installer.exe

echo.
echo 正在尝试从多个源下载 Android Studio...
echo.

REM 定义下载源
set SOURCES[0]=https://dl.google.com/dl/android/studio/install/%AS_VERSION%/android-studio-%AS_VERSION%-windows.exe
set SOURCES[1]=https://mirrors.ustc.edu.cn/android-studio/install/%AS_VERSION%/android-studio-%AS_VERSION%-windows.exe
set SOURCES[2]=https://mirrors.huaweicloud.com/android-studio/install/%AS_VERSION%/android-studio-%AS_VERSION%-windows.exe

REM 尝试官方源
echo [1/3] 尝试官方源...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://dl.google.com/dl/android/studio/install/%AS_VERSION%/android-studio-%AS_VERSION%-windows.exe' -OutFile '%AS_INSTALLER%' -UseBasicParsing}"

if exist "%AS_INSTALLER%" (
    echo 从官方源下载成功！
    goto :install
)

REM 尝试中科大镜像
echo [2/3] 尝试中科大镜像...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://mirrors.ustc.edu.cn/android-studio/install/%AS_VERSION%/android-studio-%AS_VERSION%-windows.exe' -OutFile '%AS_INSTALLER%' -UseBasicParsing}"

if exist "%AS_INSTALLER%" (
    echo 从中科大镜像下载成功！
    goto :install
)

REM 尝试华为云镜像
echo [3/3] 尝试华为云镜像...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://mirrors.huaweicloud.com/android-studio/install/%AS_VERSION%/android-studio-%AS_VERSION%-windows.exe' -OutFile '%AS_INSTALLER%' -UseBasicParsing}"

if exist "%AS_INSTALLER%" (
    echo 从华为云镜像下载成功！
    goto :install
)

echo.
echo 所有下载源都失败，请手动下载：
echo 1. 访问：https://developer.android.com/studio
echo 2. 下载 Windows 版本
echo 3. 保存为：%AS_INSTALLER%
echo.
pause
exit /b 1

:install
echo.
echo ==========================================
echo 下载完成，准备安装...
echo ==========================================
echo.

start "" "%AS_INSTALLER%"

echo Android Studio 安装程序已启动
echo 请按照安装向导完成安装：
echo.
echo 安装建议：
echo 1. 安装路径使用默认设置
echo 2. 确保勾选 "Android Virtual Device"
echo 3. 安装完成后运行 setup_android_sdk.bat
echo.

pause