@echo off
echo ==========================================
echo 短信分组应用 - 快速构建脚本
echo ==========================================

REM 设置环境变量
set PATH=C:\flutter\bin;%PATH%
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

echo Flutter 版本信息:
"C:\flutter\bin\flutter.bat" --version

echo.
echo 正在切换到项目目录...
cd /d D:\study\sms-group

echo.
echo 正在安装项目依赖，请稍候...
"C:\flutter\bin\flutter.bat" pub get

if errorlevel 1 (
    echo 依赖安装失败，正在重试...
    "C:\flutter\bin\flutter.bat" pub get --no-precompile
)

echo.
echo 正在构建 Android 发布版本...
echo 这可能需要几分钟时间，请耐心等待...
echo.

"C:\flutter\bin\flutter.bat" build apk --release

if errorlevel 1 (
    echo.
    echo 构建失败！
    echo 请检查错误信息并解决后重试
    echo.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo 构建成功！
echo ==========================================
echo.
echo APK 文件位置:
echo build\app\outputs\flutter-apk\app-release.apk
echo.

REM 检查文件是否存在
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo 文件大小:
    dir "build\app\outputs\flutter-apk\app-release.apk" | find "app-release.apk"
    echo.
    echo 安装说明:
    echo 1. 将 APK 文件传输到 Android 设备
    echo 2. 在设备上启用"未知来源应用安装"
    echo 3. 点击 APK 文件进行安装
    echo.
    echo 或者使用 ADB 安装:
    echo adb install build\app\outputs\flutter-apk\app-release.apk
    echo.
) else (
    echo 警告: APK 文件未找到，构建可能失败
)

pause