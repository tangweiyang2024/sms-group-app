@echo off
echo ==========================================
echo Android SDK 组件安装脚本
echo ==========================================

REM 设置环境变量
set PATH=C:\Android\sdk\cmdline-tools\latest\bin;%PATH%
set ANDROID_HOME=C:\Android\sdk
set ANDROID_SDK_ROOT=C:\Android\sdk

echo 正在检查 Android SDK...
if not exist "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" (
    echo 错误：Android SDK 未找到
    echo 请先运行 complete_android_setup.bat
    pause
    exit /b 1
)

echo.
echo 正在安装必要的 SDK 组件...
echo 这可能需要几分钟，请耐心等待...
echo.

echo [1/6] 安装 platform-tools...
call "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "platform-tools"

echo.
echo [2/6] 安装 Android 13 (API 33)...
call "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-33"

echo.
echo [3/6] 安装 Build Tools 33.0.0...
call "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;33.0.0"

echo.
echo [4/6] 安装 Android 12 (API 31)...
call "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "platforms;android-31"

echo.
echo [5/6] 安装 Build Tools 31.0.0...
call "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "build-tools;31.0.0"

echo.
echo [6/6] 安装系统镜像 (用于模拟器，可选)...
call "%ANDROID_HOME%\cmdline-tools\latest\bin\sdkmanager.bat" "system-images;android-33;google_apis;x86_64"

echo.
echo ==========================================
echo SDK 组件安装完成！
echo ==========================================
echo.
echo 已安装的组件：
echo - platform-tools
echo - Android 13 (API 33)
echo - Build Tools 33.0.0
echo - Android 12 (API 31)
echo - Build Tools 31.0.0
echo.
echo 下一步：
echo 运行 build_android.bat 开始构建应用
echo.
pause