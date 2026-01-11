@echo off
echo ==========================================
echo Android 开发环境一键安装脚本
echo ==========================================

set SDK_DIR=C:\Android\sdk
set CMDTOOLS_URL=https://dl.google.com/android/repository/commandlinetools-win-9513336_latest.zip
set CMDTOOLS_ZIP=%TEMP%\commandlinetools.zip

echo.
echo [步骤 1/5] 下载 Android SDK 命令行工具...
echo.

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Write-Host '正在下载...'; Invoke-WebRequest -Uri '%CMDTOOLS_URL%' -OutFile '%CMDTOOLS_ZIP%' -UseBasicParsing; Write-Host '下载完成'}"

if not exist "%CMDTOOLS_ZIP%" (
    echo 错误：下载失败
    pause
    exit /b 1
)

echo.
echo [步骤 2/5] 创建 SDK 目录结构...
if not exist "%SDK_DIR%" mkdir "%SDK_DIR%"
if not exist "%SDK_DIR%\cmdline-tools\latest" mkdir "%SDK_DIR%\cmdline-tools\latest"

echo.
echo [步骤 3/5] 解压命令行工具...
powershell -Command "Expand-Archive -Path '%CMDTOOLS_ZIP%' -DestinationPath '%SDK_DIR%\cmdline-tools\latest' -Force"

echo.
echo [步骤 4/5] 配置环境变量...
setx ANDROID_HOME "%SDK_DIR%" >nul
setx ANDROID_SDK_ROOT "%SDK_DIR%" >nul

REM 获取当前Path并添加新路径
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "current_path=%%b"
setx Path "%current_path%;%SDK_DIR%\cmdline-tools\latest\bin;%SDK_DIR%\platform-tools" >nul

echo 环境变量配置完成

echo.
echo [步骤 5/5] 接受 Android 许可...
echo.
echo 这一步需要您手动确认，请按提示操作。
echo.

"%SDK_DIR%\cmdline-tools\latest\bin\sdkmanager.bat" --licenses

if errorlevel 1 (
    echo.
    echo 许可接受失败，请稍后手动运行：
    echo sdkmanager --licenses
    echo.
)

echo.
echo ==========================================
echo Android SDK 安装完成！
echo ==========================================
echo.
echo SDK 位置：%SDK_DIR%
echo.
echo 下一步操作：
echo 1. 重启命令提示符
echo 2. 运行 install_sdk_components.bat 安装必要组件
echo 3. 运行 build_android.bat 构建应用
echo.

pause