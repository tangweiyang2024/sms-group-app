@echo off
echo ==========================================
echo Android Studio 清华镜像自动安装脚本
echo ==========================================

set AS_VERSION=2023.1.1.28
set AS_INSTALLER=%TEMP%\android-studio-%AS_VERSION%-windows.exe
set DOWNLOAD_URL=https://mirrors.tuna.tsinghua.edu.cn/android/studio/install/%AS_VERSION%/android-studio-%AS_VERSION%-windows.exe

echo.
echo 正在从清华镜像下载 Android Studio %AS_VERSION%...
echo 下载地址: %DOWNLOAD_URL%
echo.

REM 检查是否已下载
if exist "%AS_INSTALLER%" (
    echo 发现已下载的安装程序，跳过下载步骤
) else (
    echo 使用 PowerShell 下载中...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%AS_INSTALLER%' -UseBasicParsing}"

    if errorlevel 1 (
        echo.
        echo 下载失败，请手动下载：
        echo 1. 访问: %DOWNLOAD_URL%
        echo 2. 或访问: https://mirrors.tuna.tsinghua.edu.cn/android/studio/install/
        echo 3. 下载文件保存为: %AS_INSTALLER%
        echo.
        pause
        exit /b 1
    )

    if not exist "%AS_INSTALLER%" (
        echo 错误：下载失败，文件不存在
        pause
        exit /b 1
    )

    echo 下载完成！
)

echo.
echo 正在启动 Android Studio 安装程序...
echo 请按照安装向导完成安装：
echo.
echo 安装建议：
echo 1. 安装路径建议使用默认路径
echo 2. 确保勾选 "Android Virtual Device"
echo 3. 安装完成后启动 Android Studio
echo.

start "" "%AS_INSTALLER%"

echo.
echo ==========================================
echo 安装程序已启动
echo ==========================================
echo.
echo 下一步操作：
echo 1. 完成 Android Studio 安装
echo 2. 启动 Android Studio 并完成初始设置向导
echo 3. 运行 setup_android_sdk.bat 配置 SDK
echo.
echo 安装程序正在运行中...
pause