@echo off
echo ==========================================
echo Android SDK 命令行工具安装脚本
echo 轻量级版本 - 无需完整 Android Studio
echo ==========================================

set SDK_DIR=C:\Android\sdk
set CMDTOOLS_VERSION=9513336
set CMDTOOLS_ZIP=%TEMP%\commandlinetools-win-%CMDTOOLS_VERSION%_latest.zip

echo.
echo 正在从官方源下载 Android SDK 命令行工具...
echo 下载地址: https://dl.google.com/android/repository/commandlinetools-win-%CMDTOOLS_VERSION%_latest.zip
echo.

REM 下载命令行工具
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/commandlinetools-win-%CMDTOOLS_VERSION%_latest.zip' -OutFile '%CMDTOOLS_ZIP%' -UseBasicParsing}"

if not exist "%CMDTOOLS_ZIP%" (
    echo 下载失败，请手动下载：
    echo 1. 访问：https://developer.android.com/studio#command-tools
    echo 2. 下载 "Command line tools only"
    echo 3. 保存为：%CMDTOOLS_ZIP%
    echo.
    pause
    exit /b 1
)

echo 下载完成！
echo.

REM 创建SDK目录结构
echo 正在创建 SDK 目录结构...
if not exist "%SDK_DIR%" mkdir "%SDK_DIR%"
if not exist "%SDK_DIR%\cmdline-tools" mkdir "%SDK_DIR%\cmdline-tools"
if not exist "%SDK_DIR%\cmdline-tools\latest" mkdir "%SDK_DIR%\cmdline-tools\latest"

REM 解压文件
echo 正在解压文件...
powershell -Command "Expand-Archive -Path '%CMDTOOLS_ZIP%' -DestinationPath '%SDK_DIR%\cmdline-tools\latest' -Force"

REM 配置环境变量
echo.
echo 正在配置环境变量...
setx ANDROID_HOME "%SDK_DIR%" >nul
setx ANDROID_SDK_ROOT "%SDK_DIR%" >nul

REM 添加到Path
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "current_path=%%b"
setx Path "%current_path%;%SDK_DIR%\cmdline-tools\latest\bin;%SDK_DIR%\platform-tools" >nul

echo.
echo 正在安装必要的 SDK 组件...
echo.

REM 使用 sdkmanager 安装组件
"%SDK_DIR%\cmdline-tools\latest\bin\sdkmanager.bat" --list | findstr /i "platform-tools"

echo.
echo 接下来需要手动安装以下组件：
echo.
echo 1. 打开命令提示符
echo 2. 运行：sdkmanager --list
echo 3. 运行：sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
echo.
echo 或者使用简化安装脚本：
echo sdkmanager --install "platform-tools" "platforms;android-33" "build-tools;33.0.0"
echo.

echo ==========================================
echo Android SDK 基础安装完成！
echo ==========================================
echo.
echo SDK 位置: %SDK_DIR%
echo 环境变量已配置，请重启命令提示符
echo.
pause