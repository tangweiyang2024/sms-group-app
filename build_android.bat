@echo off
echo ==========================================
echo 短信分组应用 - Android 构建脚本
echo ==========================================

REM 检查 Flutter 是否安装
where flutter >nul 2>&1
if errorlevel 1 (
    echo 错误: Flutter 未安装或未在环境变量中找到
    echo 请先运行 install_flutter.bat 安装 Flutter SDK
    pause
    exit /b 1
)

echo 正在检查 Flutter 环境...
flutter --version

echo.
echo 正在安装项目依赖...
flutter pub get

if errorlevel 1 (
    echo 错误: 依赖安装失败
    pause
    exit /b 1
)

echo.
echo 正在检查 Android 环境...
flutter doctor

echo.
echo ==========================================
echo 选择构建模式:
echo ==========================================
echo 1. 调试版本 (Debug) - 快速构建，用于测试
echo 2. 发布版本 (Release) - 优化构建，用于分发
echo 3. App Bundle (AAB) - 用于 Google Play
echo.

set /p choice="请选择 (1-3): "

if "%choice%"=="1" (
    echo.
    echo 正在构建调试版本...
    flutter build apk --debug
    if not errorlevel 1 (
        echo.
        echo 构建成功！
        echo APK 位置: build\app\outputs\flutter-apk\app-debug.apk
    )
) else if "%choice%"=="2" (
    echo.
    echo 正在构建发布版本...
    flutter build apk --release
    if not errorlevel 1 (
        echo.
        echo 构建成功！
        echo APK 位置: build\app\outputs\flutter-apk\app-release.apk
    )
) else if "%choice%"=="3" (
    echo.
    echo 正在构建 App Bundle...
    flutter build appbundle --release
    if not errorlevel 1 (
        echo.
        echo 构建成功！
        echo AAB 位置: build\app\outputs\bundle\release\app-release.aab
    )
) else (
    echo 无效选择
    pause
    exit /b 1
)

echo.
echo ==========================================
echo 构建完成！
echo ==========================================
echo.
echo 下一步:
echo - 将 APK 传输到 Android 设备安装测试
echo - 或上传到 Google Play Console (使用 AAB 格式)
echo.
pause