@echo off
echo ==========================================
echo 短信分组应用 - 自动构建脚本
echo ==========================================

REM 设置临时环境变量
set PATH=C:\flutter\bin;%PATH%
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

echo 正在检查 Flutter 环境...
"C:\flutter\bin\flutter.bat" --version
if errorlevel 1 (
    echo Flutter 不可用
    pause
    exit /b 1
)

echo.
echo 正在安装项目依赖...
cd /d D:\study\sms-group
"C:\flutter\bin\flutter.bat" pub get
if errorlevel 1 (
    echo 依赖安装失败
    pause
    exit /b 1
)

echo.
echo ==========================================
echo 选择构建模式:
echo ==========================================
echo 1. 调试版本 (Debug) - 快速构建，用于测试
echo 2. 发布版本 (Release) - 优化构建，用于分发
echo.

set /p choice="请选择 (1-2): "

if "%choice%"=="1" (
    echo.
    echo 正在构建调试版本...
    "C:\flutter\bin\flutter.bat" build apk --debug
    if not errorlevel 1 (
        echo.
        echo ==========================================
        echo 构建成功！
        echo ==========================================
        echo APK 位置: build\app\outputs\flutter-apk\app-debug.apk
        echo.
        echo 您可以：
        echo - 将APK文件传输到Android设备安装测试
        echo - 使用 adb install build\app\outputs\flutter-apk\app-debug.apk
        echo.
    )
) else if "%choice%"=="2" (
    echo.
    echo 正在构建发布版本...
    "C:\flutter\bin\flutter.bat" build apk --release
    if not errorlevel 1 (
        echo.
        echo ==========================================
        echo 构建成功！
        echo ==========================================
        echo APK 位置: build\app\outputs\flutter-apk\app-release.apk
        echo.
        echo 您可以：
        echo - 将APK文件传输到Android设备安装测试
        echo - 分发给其他人使用
        echo - 上传到应用商店
        echo.
    )
) else (
    echo 无效选择
    pause
    exit /b 1
)

echo 构建完成！
pause